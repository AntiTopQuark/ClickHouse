#include <set>
#include <string>

#include <Common/Exception.h>
#include <Common/PODArray.h>
#include <Common/OptimizedRegularExpression.h>

#define MIN_LENGTH_FOR_STRSTR 3
#define MAX_SUBPATTERNS 1024


namespace DB
{
    namespace ErrorCodes
    {
        extern const int CANNOT_COMPILE_REGEXP;
    }
}

namespace
{

struct Literal
{
    std::string literal;
    bool prefix; /// this literal string is the prefix of the whole string.
    bool suffix; /// this literal string is the suffic of the whole string.
    void clear()
    {
        literal.clear();
        prefix = false;
        suffix = false;
    }
};

using Literals = std::vector<Literal>;

size_t shortest_alter_length(const Literals & literals)
{
    if (literals.empty()) return 0;
    size_t shortest = ~(0);
    for (const auto & lit : literals)
    {
        if (shortest > lit.literal.size())
            shortest = lit.literal.size();
    }
    return shortest;
}

const char * analyzeImpl(
    std::string_view regexp,
    const char * pos,
    Literal & required_substring,
    bool & is_trivial,
    Literals & global_alters)
{
    /** The expression is trivial if all the metacharacters in it are escaped.
      * The non-alternative string is
      *  a string outside parentheses,
      *  in which all metacharacters are escaped,
      *  and also if there are no '|' outside the brackets,
      *  and also avoid substrings of the form `http://` or `www` and some other
      *   (this is the hack for typical use case in web analytics applications).
      */
    const char * begin = pos;
    const char * end = regexp.data() + regexp.size();
    bool first_call = begin == regexp.data();
    int depth = 0;
    is_trivial = true;
    ///required_substring_is_prefix = false;
    required_substring.clear();
    bool has_alternative_on_depth_0 = false;
    bool has_case_insensitive_flag = false;

    /// Substring with a position.
    using Substring = std::pair<std::string, size_t>;
    using Substrings = std::vector<Substring>;

    Substrings trivial_substrings(1);
    Substring * last_substring = &trivial_substrings.back();

    Literals cur_alters;

    auto finish_cur_alters = [&]()
    {
        if (cur_alters.empty())
            return;

        if (global_alters.empty())
        {
            global_alters = std::move(cur_alters);
            return;
        }
        if (shortest_alter_length(global_alters) > shortest_alter_length(cur_alters))
        {
            cur_alters.clear();
        }
        else
        {
            global_alters.clear();
            global_alters = std::move(cur_alters);
        }
    };

    auto finish_non_trivial_char = [&](bool create_new_substr = true)
    {
        if (depth != 0)
            return;

        for (auto & alter : cur_alters)
        {
            if (alter.suffix)
            {
                alter.literal += last_substring->first;
            }
        }

        finish_cur_alters();

        if (!last_substring->first.empty() && create_new_substr)
        {
            trivial_substrings.resize(trivial_substrings.size() + 1);
            last_substring = &trivial_substrings.back();
        }
    };

    /// Resolve the string or alters in a group (xxxxx)
    auto finish_group = [&](Literal & group_required_string, Literals & group_alters)
    {
        for (auto & alter : group_alters)
        {
            if (alter.prefix)
            {
                alter.literal = last_substring->first + alter.literal;
            }
        }

        if (group_required_string.prefix)
            last_substring->first += group_required_string.literal;
        else
        {
            finish_non_trivial_char();
            last_substring->first = std::move(group_required_string).literal;
        }
        /// if we can still append, no need to finish it. e.g. abc(de)fg should capture abcdefg
        if (!last_substring->first.empty() && !group_required_string.suffix)
        {
            trivial_substrings.resize(trivial_substrings.size() + 1);
            last_substring = &trivial_substrings.back();
        }

        /// assign group alters to current alters.
        finish_cur_alters();
        cur_alters = std::move(group_alters);
    };

    bool in_curly_braces = false;
    bool in_square_braces = false;

    while (pos != end)
    {
        switch (*pos)
        {
            case '\0':
                pos = end;
                break;

            case '\\':
            {
                ++pos;
                if (pos == end)
                    break;

                switch (*pos)
                {
                    case '|':
                    case '(':
                    case ')':
                    case '^':
                    case '$':
                    case '.':
                    case '[':
                    case ']':
                    case '?':
                    case '*':
                    case '+':
                    case '-':
                    case '{':
                    case '}':
                    case '/':
                        goto ordinary;
                    default:
                        /// all other escape sequences are not supported
                        is_trivial = false;
                        finish_non_trivial_char();
                        break;
                }

                ++pos;
                break;
            }

            case '|':
                is_trivial = false;
                ++pos;
                if (depth == 0)
                {
                    has_alternative_on_depth_0 = true;
                    goto finish;
                }
                break;

            case '(':
                is_trivial = false;
                if (!in_square_braces)
                {
                    /// Check for case-insensitive flag.
                    if (pos + 1 < end && pos[1] == '?')
                    {
                        for (size_t offset = 2; pos + offset < end; ++offset)
                        {
                            if (pos[offset] == '-'  /// it means flag negation
                                /// various possible flags, actually only imsU are supported by re2
                                || (pos[offset] >= 'a' && pos[offset] <= 'z')
                                || (pos[offset] >= 'A' && pos[offset] <= 'Z'))
                            {
                                if (pos[offset] == 'i')
                                {
                                    /// Actually it can be negated case-insensitive flag. But we don't care.
                                    has_case_insensitive_flag = true;
                                    break;
                                }
                            }
                            else
                                break;
                        }
                    }
                    if (pos + 2 < end && pos[1] == '?' && pos[2] == ':')
                    {
                        pos += 2;
                    }
                    Literal group_required_substr;
                    bool group_is_trival = true;
                    Literals group_alters;
                    pos = analyzeImpl(regexp, pos + 1, group_required_substr, group_is_trival, group_alters);
                    /// pos should be ')', if not, then it is not a valid regular expression
                    if (pos == end)
                        return pos;

                    /// For ()? or ()* or (){0,1}, we can just ignore the whole group.
                    if ((pos + 1 < end && (pos[1] == '?' || pos[1] == '*')) ||
                        (pos + 2 < end && pos[1] == '{' && pos[2] == '0'))
                    {
                        finish_non_trivial_char();
                    }
                    else
                    {
                        finish_group(group_required_substr, group_alters);
                    }
                }
                ++pos;
                break;

            case '[':
                in_square_braces = true;
                ++depth;
                is_trivial = false;
                finish_non_trivial_char();
                ++pos;
                break;

            case ']':
                if (!in_square_braces)
                    goto ordinary;

                --depth;
                if (depth == 0)
                    in_square_braces = false;
                is_trivial = false;
                finish_non_trivial_char();
                ++pos;
                break;

            case ')':
                if (!in_square_braces)
                {
                    goto finish;
                }
                ++pos;
                break;

            case '^': case '$': case '.': case '+':
                is_trivial = false;
                finish_non_trivial_char();
                ++pos;
                break;

            /// Quantifiers that allow a zero number of occurrences.
            case '{':
                in_curly_braces = true;
                [[fallthrough]];
            case '?':
                [[fallthrough]];
            case '*':
                is_trivial = false;
                if (depth == 0 && !last_substring->first.empty() && !in_square_braces)
                {
                    last_substring->first.resize(last_substring->first.size() - 1);
                }
                finish_non_trivial_char();
                ++pos;
                break;

            case '}':
                if (!in_curly_braces)
                    goto ordinary;

                in_curly_braces = false;
                ++pos;
                break;

            ordinary:   /// Normal, not escaped symbol.
            [[fallthrough]];
            default:
                if (depth == 0 && !in_curly_braces && !in_square_braces)
                {
                    if (last_substring->first.empty())
                        last_substring->second = pos - begin;
                    last_substring->first.push_back(*pos);
                }
                ++pos;
                break;
        }
    }
finish:

    finish_non_trivial_char(false);

    if (!is_trivial)
    {
        /// we calculate required substring even though has_alternative_on_depth_0.
        /// we will clear the required substring after putting it to alternatives.
        if (!has_case_insensitive_flag)
        {
            /// We choose the non-alternative substring of the maximum length for first search.

            /// Tuning for typical usage domain
            auto tuning_strings_condition = [](const std::string & str)
            {
                return str != "://" && str != "http://" && str != "www" && str != "Windows ";
            };
            size_t max_length = 0;
            Substrings::const_iterator candidate_it = trivial_substrings.begin();
            for (Substrings::const_iterator it = trivial_substrings.begin(); it != trivial_substrings.end(); ++it)
            {
                if (it->first.size() > max_length && tuning_strings_condition(it->first))
                {
                    max_length = it->first.size();
                    candidate_it = it;
                }
            }

            if (max_length >= MIN_LENGTH_FOR_STRSTR || (!first_call && max_length > 0))
            {
                required_substring.literal = candidate_it->first;
                required_substring.prefix = candidate_it->second == 0;
                required_substring.suffix = candidate_it + 1 == trivial_substrings.end();
            }
        }
    }
    else if (!trivial_substrings.empty())
    {
        required_substring.literal = trivial_substrings.front().first;
        required_substring.prefix = trivial_substrings.front().second == 0;
        required_substring.suffix = true;
    }

    /// if it is xxx|xxx|xxx, we should call the next xxx|xxx recursively and collect the result.
    if (has_alternative_on_depth_0)
    {
        /// compare the quality of required substring and alternatives and choose the better one.
        if (shortest_alter_length(global_alters) < required_substring.literal.size())
            global_alters = {required_substring};
        Literals next_alternatives;
        /// this two vals are useless, xxx|xxx cannot be trivial nor prefix.
        bool next_is_trivial = true;
        pos = analyzeImpl(regexp, pos, required_substring, next_is_trivial, next_alternatives);
        /// For xxx|xxx|xxx, we only conbine the alternatives and return a empty required_substring.
        if (next_alternatives.empty() || shortest_alter_length(next_alternatives) < required_substring.literal.size())
        {
            global_alters.push_back(required_substring);
        }
        else
        {
            global_alters.insert(global_alters.end(), next_alternatives.begin(), next_alternatives.end());
        }
        required_substring.clear();
    }

    return pos;

/*    std::cerr
        << "regexp: " << regexp
        << ", is_trivial: " << is_trivial
        << ", required_substring: " << required_substring
        << ", required_substring_is_prefix: " << required_substring_is_prefix
        << std::endl;*/
}
}

template <bool thread_safe>
void OptimizedRegularExpressionImpl<thread_safe>::analyze(
        std::string_view regexp_,
        std::string & required_substring,
        bool & is_trivial,
        bool & required_substring_is_prefix,
        std::vector<std::string> & alternatives)
{
    Literals alter_literals;
    Literal required_lit;
    analyzeImpl(regexp_, regexp_.data(), required_lit, is_trivial, alter_literals);
    required_substring = std::move(required_lit.literal);
    required_substring_is_prefix = required_lit.prefix;
    for (auto & lit : alter_literals)
        alternatives.push_back(std::move(lit.literal));
}

template <bool thread_safe>
OptimizedRegularExpressionImpl<thread_safe>::OptimizedRegularExpressionImpl(const std::string & regexp_, int options)
{
    std::vector<std::string> alternatives; /// this vector collects patterns in (xx|xx|xx). for now it's not used.
    analyze(regexp_, required_substring, is_trivial, required_substring_is_prefix, alternatives);


    /// Just three following options are supported
    if (options & (~(RE_CASELESS | RE_NO_CAPTURE | RE_DOT_NL)))
        throw DB::Exception(DB::ErrorCodes::CANNOT_COMPILE_REGEXP, "OptimizedRegularExpression: Unsupported option.");

    is_case_insensitive = options & RE_CASELESS;
    bool is_no_capture = options & RE_NO_CAPTURE;
    bool is_dot_nl = options & RE_DOT_NL;

    number_of_subpatterns = 0;
    if (!is_trivial)
    {
        /// Compile the re2 regular expression.
        typename RegexType::Options regexp_options;

        /// Never write error messages to stderr. It's ignorant to do it from library code.
        regexp_options.set_log_errors(false);

        if (is_case_insensitive)
            regexp_options.set_case_sensitive(false);

        if (is_dot_nl)
            regexp_options.set_dot_nl(true);

        re2 = std::make_unique<RegexType>(regexp_, regexp_options);
        if (!re2->ok())
        {
            throw DB::Exception(DB::ErrorCodes::CANNOT_COMPILE_REGEXP,
                "OptimizedRegularExpression: cannot compile re2: {}, error: {}. "
                "Look at https://github.com/google/re2/wiki/Syntax "
                "for reference. Please note that if you specify regex as an SQL "
                "string literal, the slashes have to be additionally escaped. "
                "For example, to match an opening brace, write '\\(' -- "
                "the first slash is for SQL and the second one is for regex",
                regexp_, re2->error());
        }

        if (!is_no_capture)
        {
            number_of_subpatterns = re2->NumberOfCapturingGroups();
            if (number_of_subpatterns > MAX_SUBPATTERNS)
                throw DB::Exception(DB::ErrorCodes::CANNOT_COMPILE_REGEXP, "OptimizedRegularExpression: too many subpatterns in regexp: {}", regexp_);
        }
    }

    if (!required_substring.empty())
    {
        if (is_case_insensitive)
            case_insensitive_substring_searcher.emplace(required_substring.data(), required_substring.size());
        else
            case_sensitive_substring_searcher.emplace(required_substring.data(), required_substring.size());
    }
}

template <bool thread_safe>
OptimizedRegularExpressionImpl<thread_safe>::OptimizedRegularExpressionImpl(OptimizedRegularExpressionImpl && rhs) noexcept
    : is_trivial(rhs.is_trivial)
    , required_substring_is_prefix(rhs.required_substring_is_prefix)
    , is_case_insensitive(rhs.is_case_insensitive)
    , required_substring(std::move(rhs.required_substring))
    , re2(std::move(rhs.re2))
    , number_of_subpatterns(rhs.number_of_subpatterns)
{
    if (!required_substring.empty())
    {
        if (is_case_insensitive)
            case_insensitive_substring_searcher.emplace(required_substring.data(), required_substring.size());
        else
            case_sensitive_substring_searcher.emplace(required_substring.data(), required_substring.size());
    }
}

template <bool thread_safe>
bool OptimizedRegularExpressionImpl<thread_safe>::match(const char * subject, size_t subject_size) const
{
    const UInt8 * haystack = reinterpret_cast<const UInt8 *>(subject);
    const UInt8 * haystack_end = haystack + subject_size;

    if (is_trivial)
    {
        if (required_substring.empty())
            return true;

        if (is_case_insensitive)
            return haystack_end != case_insensitive_substring_searcher->search(haystack, subject_size);
        else
            return haystack_end != case_sensitive_substring_searcher->search(haystack, subject_size);
    }
    else
    {
        if (!required_substring.empty())
        {
            if (is_case_insensitive)
            {
                if (haystack_end == case_insensitive_substring_searcher->search(haystack, subject_size))
                    return false;
            }
            else
            {
                if (haystack_end == case_sensitive_substring_searcher->search(haystack, subject_size))
                    return false;
            }
        }

        return re2->Match(StringPieceType(subject, subject_size), 0, subject_size, RegexType::UNANCHORED, nullptr, 0);
    }
}


template <bool thread_safe>
bool OptimizedRegularExpressionImpl<thread_safe>::match(const char * subject, size_t subject_size, Match & match) const
{
    const UInt8 * haystack = reinterpret_cast<const UInt8 *>(subject);
    const UInt8 * haystack_end = haystack + subject_size;

    if (is_trivial)
    {
        if (required_substring.empty())
            return true;

        const UInt8 * pos;
        if (is_case_insensitive)
            pos = case_insensitive_substring_searcher->search(haystack, subject_size);
        else
            pos = case_sensitive_substring_searcher->search(haystack, subject_size);

        if (haystack_end == pos)
            return false;
        else
        {
            match.offset = pos - haystack;
            match.length = required_substring.size();
            return true;
        }
    }
    else
    {
        if (!required_substring.empty())
        {
            const UInt8 * pos;
            if (is_case_insensitive)
                pos = case_insensitive_substring_searcher->search(haystack, subject_size);
            else
                pos = case_sensitive_substring_searcher->search(haystack, subject_size);

            if (haystack_end == pos)
                return false;
        }

        StringPieceType piece;

        if (!RegexType::PartialMatch(StringPieceType(subject, subject_size), *re2, &piece))
            return false;
        else
        {
            match.offset = piece.data() - subject;
            match.length = piece.length();
            return true;
        }
    }
}


template <bool thread_safe>
unsigned OptimizedRegularExpressionImpl<thread_safe>::match(const char * subject, size_t subject_size, MatchVec & matches, unsigned limit) const
{
    const UInt8 * haystack = reinterpret_cast<const UInt8 *>(subject);
    const UInt8 * haystack_end = haystack + subject_size;

    matches.clear();

    if (limit == 0)
        return 0;

    if (limit > number_of_subpatterns + 1)
        limit = number_of_subpatterns + 1;

    if (is_trivial)
    {
        if (required_substring.empty())
        {
            matches.emplace_back(Match{0, 0});
            return 1;
        }

        const UInt8 * pos;
        if (is_case_insensitive)
            pos = case_insensitive_substring_searcher->search(haystack, subject_size);
        else
            pos = case_sensitive_substring_searcher->search(haystack, subject_size);

        if (haystack_end == pos)
            return 0;
        else
        {
            Match match;
            match.offset = pos - haystack;
            match.length = required_substring.size();
            matches.push_back(match);
            return 1;
        }
    }
    else
    {
        if (!required_substring.empty())
        {
            const UInt8 * pos;
            if (is_case_insensitive)
                pos = case_insensitive_substring_searcher->search(haystack, subject_size);
            else
                pos = case_sensitive_substring_searcher->search(haystack, subject_size);

            if (haystack_end == pos)
                return 0;
        }

        DB::PODArrayWithStackMemory<StringPieceType, 128> pieces(limit);

        if (!re2->Match(
            StringPieceType(subject, subject_size),
            0,
            subject_size,
            RegexType::UNANCHORED,
            pieces.data(),
            static_cast<int>(pieces.size())))
        {
            return 0;
        }
        else
        {
            matches.resize(limit);
            for (size_t i = 0; i < limit; ++i)
            {
                if (pieces[i] != nullptr)
                {
                    matches[i].offset = pieces[i].data() - subject;
                    matches[i].length = pieces[i].length();
                }
                else
                {
                    matches[i].offset = std::string::npos;
                    matches[i].length = 0;
                }
            }
            return limit;
        }
    }
}

template class OptimizedRegularExpressionImpl<true>;
template class OptimizedRegularExpressionImpl<false>;
