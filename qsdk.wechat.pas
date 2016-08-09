unit qsdk.wechat;

interface

uses system.classes, system.SysUtils;

type
  IWechatRequest = interface
    ['{4FF6EC96-563B-4F66-9129-BD7ABF7416F1}']
    function getOpenID: String;
    function getTansaction: String;
    function getRequestType: Integer;
    property OpenID: String read getOpenID;
    property Transaction: String read getTansaction;
    property RequestType: Integer read getRequestType;
  end;

  IWechatResponse = interface
    ['{C697B114-AEB1-4227-A2F7-F2EC785E1F11}']
  end;

  TWechatRequestEvent = procedure(ARequest: IWechatRequest) of object;
  TWechatResponseEvent = procedure(AResponse: IWechatResponse) of object;

  IWechatService = interface
    ['{10370690-72BC-438C-8105-042D2029B895}']
    procedure Unregister;
    function IsInstalled: Boolean;
    function getAppId: String;
    function OpenWechat: Boolean;
    function IsAPISupported: Boolean;
    function SendRequest(ARequest: IWechatRequest): Boolean;
    function SendResponse(AResp: IWechatResponse): Boolean;
    function getOnRequest: TWechatRequestEvent;
    procedure setOnRequest(const AEvent: TWechatRequestEvent);
    function getOnResponse: TWechatResponseEvent;
    procedure setOnResponse(const AEvent: TWechatResponseEvent);
    procedure setAppId(const AId: String);
    property AppId: String read getAppId write setAppId;
    property Installed: Boolean read IsInstalled;
    property APISupported: Boolean read IsAPISupported;
    property OnRequest: TWechatRequestEvent read getOnRequest
      write setOnRequest;
    property OnResponse: TWechatResponseEvent read getOnResponse
      write setOnResponse;
  end;

function WechatService: IWechatService;

implementation

uses fmx.platform{$IFDEF ANDROID}, qsdk.wechat.android{$ENDIF}
{$IFDEF IOS}, qsdk.wechat.ios{$ENDIF};

function WechatService: IWechatService;
begin
  if not TPlatformServices.Current.SupportsPlatformService(IWechatService,
    Result) then
    Result := nil;
end;

initialization

RegisterWechatService;

end.
