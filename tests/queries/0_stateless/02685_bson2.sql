-- It correctly throws exception about incorrect data:

SELECT * FROM format('BSONEachRow',
'WatchID Int64, JavaEnable Int16, Title String, GoodEvent Int16, EventTime DateTime, EventDate Date, CounterID Int32, ClientIP Int32, RegionID Int32, UserID Int64, CounterClass Int16, OS Int16, UserAgent Int16, URL String, Referer String, IsRefresh Int16, RefererCategoryID Int16, RefererRegionID Int32, URLCategoryID Int16, URLRegionID Int32, ResolutionWidth Int16, ResolutionHeight Int16, ResolutionDepth Int16, FlashMajor Int16, FlashMinor Int16, FlashMinor2 String, NetMajor Int16, NetMinor Int16, UserAgentMajor Int16, UserAgentMinor String, CookieEnable Int16, JavascriptEnable Int16, IsMobile Int16, MobilePhone Int16, MobilePhoneModel String, Params String, IPNetworkID Int32, TraficSourceID Int16, SearchEngineID Int16, SearchPhrase String, AdvEngineID Int16, IsArtifical Int16, WindowClientWidth Int16, WindowClientHeight Int16, ClientTimeZone Int16, ClientEventTime DateTime, SilverlightVersion1 Int16, SilverlightVersion2 Int16, SilverlightVersion3 Int32, SilverlightVersion4 Int16, PageCharset String, CodeVersion Int32, IsLink Int16, IsDownload Int16, IsNotBounce Int16, FUniqID Int64, OriginalURL String, HID Int32, IsOldCounter Int16, IsEvent Int16, IsParameter Int16, DontCountHits Int16, WithHash Int16, HitColor String, LocalEventTime DateTime, Age Int16, Sex Int16, Income Int16, Interests Int16, Robotness Int16, RemoteIP Int32, WindowName Int32, OpenerName Int32, HistoryLength Int16, BrowserLanguage String, BrowserCountry String, SocialNetwork String, SocialAction String, HTTPError Int16, SendTiming Int32, DNSTiming Int32, ConnectTiming Int32, ResponseStartTiming Int32, ResponseEndTiming Int32, FetchTiming Int32, SocialSourceNetworkID Int16, SocialSourcePage String, ParamPrice Int64, ParamOrderID String, ParamCurrency String, ParamCurrencyID Int16, OpenstatServiceName String, OpenstatCampaignID String, OpenstatAdID String, OpenstatSourceID String, UTMSource String, UTMMedium String, UTMCampaign String, UTMContent String, UTMTerm String, FromTag String, HasGCLID Int16, RefererHash Int64, URLHash Int64, CLID Int32',
$$^  WatchID c*5/ !p~JavaEnable     Title      GoodEvent    EventTime 7��Q    EventDate >  CounterID    ClientIP ��z�RegionID G  UserID � ��:6��CounterClass     OS     UserAgent     URL      Referer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID     URLRegionID     ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor     UserAgentMinor     �OCookieEnable     JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID ��9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion2     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime &��Q    Age     Sex     Income     Interests     Robotness     RemoteIP ^DI�WindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash �|3��b.�CLID      ^  WatchID ��F�ӓ2qJavaEnable     Title      GoodEvent    EventTime n$�Q    EventDate >  CounterID    ClientIP ��z�RegionID G  UserID � ��:6��CounterClass     OS     UserAgent     URL      Referer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID     URLRegionID     ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor     UserAgentMinor     �OCookieEnable     JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID ��9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime ǘ�Q    Age     Sex     Income     Interests     Robotness     RemoteIP ^DI�WindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash �|3��b.�CLID      ^  WatchID l!�|�@HJavaEnable     Title      GoodEvent    EventTime �)�Q    EventDate >  CounterID    ClientIP ��z�RegionID G  UserID � ��:6��CounterClass     OS     UserAgent     URL      Referer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID     URLRegionID     ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor     UserAgentMinor     �OCookieEnable     JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID ��9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime }��Q    Age     Sex     Income     Interests     Robotness     RemoteIP ^DI�WindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash �|3��b.�CLID      ^  WatchID �ǐ=ЌWJavaEnable     Title      GoodEvent    EventTime 8*�Q    EventDate >  CounterID    ClientIP ��z�RegionID G  UserID � ��:6��CounterClass     OS     UserAgent     URL      Referer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID     URLRegionID     ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor     UserAgentMinor     �OCookieEnable     JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID ��9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime ݞ�Q    Age     Sex     Income     Interests     Robotness     RemoteIP ^DI�WindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash �|3��b.�CLID      �  WatchID ��E&LyJavaEnable     Title      GoodEvent    EventTime J��Q    EventDate >  CounterID    ClientIP ��I`RegionID '   UserID q��Jd8CounterClass     OS    UserAgent    URL -    http://holodilnik.ru/russia/05jul2013&model=0Referer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID �9  URLRegionID    ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor    NetMinor    UserAgentMajor    UserAgentMinor     D�CookieEnable    JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID �d9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID %�l��+kOriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime '��Q    Age    Sex    Income    Interests �:  Robotness    RemoteIP 9�3NWindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash �
o���eCLID      �  WatchID ��k=��pJavaEnable     Title      GoodEvent    EventTime ��Q    EventDate >  CounterID    ClientIP ��z�RegionID G  UserID �Ks}��CounterClass     OS    UserAgent    URL H    http://afisha.mail.ru/catalog/314/women.ru/ency=1&page3/?errovat-pinnikiReferer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID 0=  URLRegionID �   ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor    UserAgentMinor     D�CookieEnable    JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID ��9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID :��W��mOriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime A��Q    Age     Sex     Income     Interests     Robotness     RemoteIP ^DI�WindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash ���#�\CLID      �  WatchID �1��o�CJavaEnable     Title      GoodEvent    EventTime �0�Q    EventDate >  CounterID    ClientIP �^{]RegionID �   UserID &n%�t"6CounterClass     OS '   UserAgent    URL >    http://bonprix.ru/index.ru/cinema/art/0 986 424 233 сезонReferer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID    URLRegionID �   ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor    UserAgentMinor     D�CookieEnable    JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID �#( TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime ���Q    Age     Sex     Income     Interests     Robotness     RemoteIP �UWindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash X-h��X CLID      �  WatchID »-�C_JavaEnable     Title      GoodEvent    EventTime 83�Q    EventDate >  CounterID    ClientIP �^{]RegionID �   UserID &n%�t"6CounterClass     OS '   UserAgent    URL :    http://bonprix.ru/index.ru/cinema/art/A00387,3797); ru)&bLReferer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID    URLRegionID �   ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor    UserAgentMinor     D�CookieEnable    JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID �#( TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime 
��Q    Age     Sex     Income     Interests     Robotness     RemoteIP �UWindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash v�v����CLID      �  WatchID ���\JavaEnable     Title      GoodEvent    EventTime � �Q    EventDate >  CounterID    ClientIP �gURegionID �   UserID �s�yy��fCounterClass     OS ,   UserAgent    URL 1    http://tours/Ekategoriya%2F&sr=http://slovareniyeReferer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID     URLRegionID �   esRolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor 	   UserAgentMinor     D�CookieEnable     JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID �� TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime Y��Q    Age     Sex     Income     Interests     Robotness     RemoteIP �=kWindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash h��9�DCLID      ^  WatchID �/E��J�{JavaEnable     Title      GoodEvent    EventTime �1�Q    EventDate >  CounterID    ClientIP ��z�RegionID G  UserID � ��:6��CounterClass     OS     UserAgent     URL      Referer      IsRefresh     RefererCategoryID     RefererRegionID     URLCategoryID     URLRegionID     ResolutionWidth     ResolutionHeight     ResolutionDepth     FlashMajor     FlashMinor     FlashMinor2      NetMajor     NetMinor     UserAgentMajor     UserAgentMinor     �OCookieEnable     JavascriptEnable     IsMobile     MobilePhone     MobilePhoneModel      Params      IPNetworkID ��9 TraficSourceID    SearchEngineID     SearchPhrase      AdvEngineID     IsArtifical     WindowClientWidth     WindowClientHeight     ClientTimeZone ����ClientEventTime ��    SilverlightVersion1     SilverlightVersion2     SilverlightVersion3     SilverlightVersion4     PageCharset      CodeVersion     IsLink     IsDownload     IsNotBounce     FUniqID         OriginalURL      HID     IsOldCounter     IsEvent     IsParameter     DontCountHits     WithHash     HitColor     5LocalEventTime ���Q    Age     Sex     Income     Interests     Robotness     RemoteIP ^DI�WindowName ����OpenerName ����HistoryLength ����BrowserLanguage     �BrowserCountry     �SocialNetwork      SocialAction      HTTPError     SendTiming     DNSTiming     ConnectTiming     ResponseStartTiming     ResponseEndTiming     FetchTiming     SocialSourceNetworkID     SocialSourcePage      ParamPrice         ParamOrderID      ParamCurrency     NHParamCurrencyID     OpenstatServiceName      OpenstatCampaignID      OpenstatAdID      OpenstatSourceID      UTMSource      UTMMedium      UTMCampaign      UTMContent      UTMTerm      FromTag      HasGCLID     RefererHash X+��'���URLHash �|3��b.�CLID      $$);
