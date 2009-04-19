{*------------------------------------------------------------------------------
  Dweetta.pas

  This unit contains the main Dweetta Object

  @Author  $Author$
  @LastChangedBy $LastChangedBy$
  @Version $Rev$
-------------------------------------------------------------------------------}
unit Dweetta;

{$I Dweetta.inc}

interface

uses
  Classes, SysUtils, DweettaTypes, DweettaAPI, DweettaContainers;

type
{ TDweetta }

  TDweetta = class(TObject)
  private
    FUser: String;
    FPassword: String;
    FDweettaAPI: TDweettaAPI;
    FResponseInfo: TDweettaResponseInfo;

    function GetRateLimit: Integer;
    function GetRemainingCalls: Integer;
    function GetResponseCode: Integer;
    function GetResponseString: String;
    procedure SetUser(Value: String);
    procedure SetPassword(Value: String);
    procedure UpdateAuth;
  public
    constructor Create;
    destructor Destroy; override;

    function StatusesPublicTimeline: TDweettaStatusElementList;
    function StatusesFriendsTimeline: TDweettaStatusElementList; overload;
    function StatusesFriendsTimeline(since: String): TDweettaStatusElementList; overload;
    function StatusesUserTimeline: TDweettaStatusElementList; overload;
    function StatusesUserTimeline(id: String): TDweettaStatusElementList; overload;
    function StatusesShow(id: Integer): TDweettaStatusElement;
    function StatusesUpdate(status: String): TDweettaStatusElement; overload;
    function StatusesUpdate(status: String; in_reply_to_status_id: Integer): TDweettaStatusElement; overload;
    function StatusesReplies: TDweettaStatusElementList; overload;
    function StatusesReplies(since_id: Integer): TDweettaStatusElementList; overload;
    function StatusesDestroy(id: Integer): TDweettaStatusElement;

    property User: String read FUser write Setuser;
    property Password: String read FPassword write SetPassword;
    property ResponseCode: Integer read GetResponseCode;
    property ResponseString: String read GetResponseString;
    property RemainingCalls: Integer read GetRemainingCalls;
    property RateLimit: Integer read GetRateLimit;
  end;

implementation

{ TDweetta }

procedure TDweetta.SetUser ( Value: String ) ;
begin
  if Value <> FUser then
  begin
    FUser := Value;
    UpdateAuth;
  end;
end;

function TDweetta.GetRateLimit: Integer;
begin
  Result := FResponseInfo.RateLimit;
end;

function TDweetta.GetRemainingCalls: Integer;
begin
  Result := FResponseInfo.RemainingCalls;
end;

function TDweetta.GetResponseCode: Integer;
begin
  Result := FResponseInfo.HTTPStatus;
end;

function TDweetta.GetResponseString: String;
begin
  Result := FResponseInfo.HTTPMessage;
end;

procedure TDweetta.SetPassword ( Value: String ) ;
begin
  if Value <> FPassword then
  begin
    FPassword := Value;
    UpdateAuth;
  end;
end;

procedure TDweetta.UpdateAuth;
begin
  FDweettaAPI.User := FUser;
  FDweettaAPI.Password := FPassword;
end;

constructor TDweetta.Create;
begin
  inherited Create;
  FDweettaAPI := TDweettaAPI.Create;
  FDweettaAPI.User := FUser;
  FDweettaAPI.Password := FPassword;
  FDweettaAPI.UserAgent := 'Dweetta/0.1';
  FDweettaAPI.Server := 'twitter.com';
end;

destructor TDweetta.Destroy;
begin
  FDweettaAPI.Free;
  inherited Destroy;
end;

function TDweetta.StatusesPublicTimeline: TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_public_timeline(FResponseInfo);
end;

function TDweetta.StatusesFriendsTimeline: TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_friends_timeline('', 0, 0, 0, 0, FResponseInfo);
end;

function TDweetta.StatusesFriendsTimeline(since: String): TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_friends_timeline(since, 0, 0, 0, 0, FResponseInfo);
end;

function TDweetta.StatusesUserTimeline: TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_user_timeline('', 0, '', 0, 0, 0, '', FResponseInfo);
end;

function TDweetta.StatusesUserTimeline ( id: String ) : TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_user_timeline(id, 0, '', 0, 0, 0, '', FResponseInfo);
end;

function TDweetta.StatusesShow(id: Integer): TDweettaStatusElement;
begin
  Result := FDweettaAPI.Statuses_show(id, FResponseInfo);
end;

function TDweetta.StatusesUpdate(status: String): TDweettaStatusElement;
begin
  Result := FDweettaAPI.Statuses_update(status, 0, FResponseInfo);
end;

function TDweetta.StatusesUpdate(status: String; in_reply_to_status_id: Integer
  ): TDweettaStatusElement;
begin
  Result := FDweettaAPI.Statuses_update(status, in_reply_to_status_id, FResponseInfo);
end;

function TDweetta.StatusesReplies: TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_replies(0, 0, '', 0, FResponseInfo);
end;

function TDweetta.StatusesReplies(since_id: Integer
  ): TDweettaStatusElementList;
begin
  Result := FDweettaAPI.Statuses_replies(since_id, 0, '', 0, FResponseInfo);
end;

function TDweetta.StatusesDestroy(id: Integer): TDweettaStatusElement;
begin
  Result := FDweettaAPI.Statuses_destroy(id, FResponseInfo);
end;

end.

