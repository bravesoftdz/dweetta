//      Mozilla Public License.
//
//      The contents of this file are subject to the Mozilla Public License
//      Version 1.1 (the "License"); you may not use this file except in compliance
//      with the License. You may obtain a copy of the License at
//
//      http://www.mozilla.org/MPL/
//
//      Software distributed under the License is distributed on an "AS IS"
//      basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
//      License for the specific language governing rights and limitations under
//      the License.
{*------------------------------------------------------------------------------
  DweettaSocketsSynapse.pas

  This includes a wrapper around the Sockets lib of choice.
  This version uses Indy.

  @Author  $Author$
  @LastChangedBy $LastChangedBy$
  @Version $Rev$
-------------------------------------------------------------------------------}
interface

uses
  Classes, SysUtils, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, idHTTP;

type

{ TDweettaSockets }
  TDweettaSockets = class(TObject)
  private
    FHTTP: TidHTTP;

    function GetHeaders: TStringList;
    function GetContent: TStringList;
    function GetResult: Integer;
    function GetResultText: String;
    function GetUserAgent: String;
    procedure SetUserAgent(const AValue: String);
  public
    constructor Create;
    destructor Destroy; override;

    function Execute(Method, URL: String; const Params: TStringList = nil): Boolean;

    property UserAgent: String read GetUserAgent write SetUserAgent;
    property Headers: TStringList read GetHeaders;
    property Content: TStringList read GetContent;
    property Result: Integer read GetResult;
    property ResultText: String read GetResultText;
  end;

implementation

uses
  DweettaUtils;

{ TDweettaSockets }

function TDweettaSockets.GetHeaders: TStringList;
begin
  Result := FHTTP.Request.RawHeaders;
end;

function TDweettaSockets.GetContent: TStringList;
begin
  Result := TStringList.Create;
  Result.LoadFromStream(FHTTP.Response.ContentStream);
end;

function TDweettaSockets.GetResult: Integer;
begin
  Result := FHTTP.ResponseCode;
end;

function TDweettaSockets.GetResultText: String;
begin
  Result := FHTTP.ResponseText;
end;

function TDweettaSockets.GetUserAgent: String;
begin
  Result := FHTTP.Request.UserAgent;
end;

procedure TDweettaSockets.SetUserAgent(const AValue: String);
begin
  FHTTP.Request.UserAgent := AValue;
end;

constructor TDweettaSockets.Create;
begin
  inherited Create;
  FHTTP := TidHTTP.Create;
end;

destructor TDweettaSockets.Destroy;
begin
  FreeAndNil(FHTTP);
  inherited Destroy;
end;

function TDweettaSockets.Execute(Method, URL: String; const Params: TStringList = nil): Boolean;
var
  Index: Integer;
  Data: TStringList;
  ResponseData: String;
begin
  Result := False;
  FHTTP.Request.Clear;
  FHTTP.Response.Clear;
  if (Assigned(Params)) and (Params.Count > 0) then
  begin
    Data := TStringList.Create;
    Data.Text := URLEncodeParams(Params, false);
    if Method = 'POST' then
    begin
      //FHTTP.Post(
    end;
    if Method = 'PUT' then
    begin
    
    end;
    if Method = 'GET' then
    begin
    
    end;
    if Method = 'DELETE' then
    begin
    
    end;
  end;
end;
