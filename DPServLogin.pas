unit DPServLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Utils_Graf, Dialogs, ExtCtrls, StdCtrls, Utils_Str, Utils_Misc, Utils_Files,
  Utils_FileIni, Utils_KAndM, Utils_Log;

type
  TfrmLogin = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    bvlBottom: TBevel;
    ePassword: TLabeledEdit;
    ImagePassword: TImage;
    procedure btnOKClick(Sender: TObject);
  private
    function  CheckPassword: Boolean;
  public
  end;

function ShowLogin: Boolean;

implementation

uses DPServMain, DPServAdd, DPServStrings;

{$R *.dfm}

function ShowLogin: Boolean;
begin
  with TfrmLogin.Create(Application) do
    try
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

function TfrmLogin.CheckPassword: Boolean;
begin
  Result := ePassword.Text = Settings.ProgramPass;
  if not Result then begin
    ePassword.Clear;
    ePassword.SetFocus;
    WriteToLog(rsLOGErrorPassword);
    MsgBoxErr(rsErrorPassword);
  end;
end;

procedure TfrmLogin.btnOKClick(Sender: TObject);
begin
  if not CheckPassword then ModalResult := mrNone;
end;

end.
