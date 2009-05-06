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
  DweettaUtils.pas

  Some utilities for the lib.

  @Author  $Author$
  @LastChangedBy $LastChangedBy$
  @Version $Rev$
-------------------------------------------------------------------------------}
unit DweettaUtils;

{$I Dweetta.inc}

interface

uses
  Classes, SysUtils;

  function DateTimeToInternetTime(const aDateTime: TDateTime): String;
  function InternetTimeToDateTime(const aInternetTime: String): TDateTime;
  function URLEncodeParams(const aParamList: TStringList; aInQuery: Boolean): String;

implementation

uses
  Windows;

function DateTimeToInternetTime(const aDateTime: TDateTime): String;
var
  LocalTimeZone: TTimeZoneInformation;
begin
  // eg. Sun, 06 Nov 1994 08:49:37 GMT  RFC 822, updated by 1123
  Result := FormatDateTime('ddd, dd mmm yyyy hh:nn:ss', aDateTime);
  // Get the Local Time Zone Bias and report as GMT +/-Bias
  GetTimeZoneInformation(LocalTimeZone);
  Result := Result + 'GMT ' + IntToStr(LocalTimeZone.Bias div 60);
end;

function InternetTimeToDateTime(const aInternetTime: String): TDateTime;
begin
  Result := Now;
end;

function URLEncodeParams(const aParamList: TStringList; aInQuery: Boolean): String;
var
  Index, Index1: Integer;
  DirtyString, CleanString: String;
begin
  Result := '';
  CleanString := '';
  for Index := 0 to aParamList.Count -1 do
  begin
    DirtyString := aParamList.ValueFromIndex[Index];
    for Index1 := 1 to Length(DirtyString) do
    begin
      case DirtyString[Index1] of
        'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.':begin
          CleanString := CleanString + DirtyString[Index1];
        end;
        ' ':begin
          if aInQuery then
          begin
            CleanString := CleanString + '%20';
          end
          else
          begin
            CleanString := CleanString + '+';
          end;
        end;
      else
        CleanString := CleanString + '%' + IntToHex(Ord(DirtyString[Index1]), 1);
      end;
    end;
    aParamList.ValueFromIndex[Index] := CleanString;
    Result := Result + aParamList[Index] + '&';
  end;
  if aParamList.Count > 0 then
  begin
    SetLength(Result, Length(Result) - 1);
  end;
end;

end.

