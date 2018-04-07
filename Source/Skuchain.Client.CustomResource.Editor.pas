(*
  Copyright 2016, Skuchain-Curiosity library

  Home: https://github.com/andrea-magni/Skuchain
*)
unit Skuchain.Client.CustomResource.Editor;

{$I Skuchain.inc}

interface

uses
  Classes, SysUtils
  , DesignEditors
  , Skuchain.Client.CustomResource;

type
  TSkuchainClientCustomResourceEditor = class(TComponentEditor)
  private
    function CurrentObj: TSkuchainClientCustomResource;
  protected
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

uses
{$ifdef DelphiXE7_UP}
  VCL.Dialogs
{$else}
  Dialogs
{$endif}
  , DesignIntf
  , Windows, IdHTTP;

procedure Register;
begin
  RegisterComponentEditor(TSkuchainClientCustomResource, TSkuchainClientCustomResourceEditor);
end;

{ TSkuchainClientCustomResourceEditor }

function TSkuchainClientCustomResourceEditor.CurrentObj: TSkuchainClientCustomResource;
begin
  Result := Component as TSkuchainClientCustomResource;
end;

procedure TSkuchainClientCustomResourceEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  try
    case Index of
      0: CurrentObj.GET(nil, nil, nil);
      1: CurrentObj.POST(nil, nil, nil);
      2: CurrentObj.DELETE(nil, nil, nil);
  //    3: CurrentObj.PUT;
  //    4: CurrentObj.PATCH;
  //    5: CurrentObj.HEAD;
  //    6: CurrentObj.OPTIONS;
    end;

    if (GetKeyState(VK_LSHIFT) < 0) then
      ShowMessage(CurrentObj.Client.ResponseText);
  except
    on E: EIdHTTPProtocolException do
     raise Exception.Create('Error: ' + E.ErrorCode.ToString + ' ' + E.ErrorMessage + sLineBreak + E.Message);
  end;

    Designer.Modified;
end;

function TSkuchainClientCustomResourceEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'GET';
    1: Result := 'POST';
    2: Result := 'DELETE';
//    3: Result := 'PUT';
//    4: Result := 'PATCH';
//    5: Result := 'HEAD';
//    6: Result := 'OPTIONS';
  end;
end;

function TSkuchainClientCustomResourceEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

end.

