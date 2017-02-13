unit DPServOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtSpin, ComCtrls, Utils_Str, Utils_Misc,
  Utils_Files, Utils_Date, Utils_Base64, Utils_FileIni, PathEdit, Spin,
  Utils_Log;

type
  TfrmOptions = class(TForm)
    BevelBottom: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    PanelMain: TPanel;
    PageControl: TPageControl;
    tsProgramLocalDB: TTabSheet;
    tsScales: TTabSheet;
    gbPlace: TGroupBox;
    ePlace: TEdit;
    gbScales: TGroupBox;
    eScales: TExtSpinEdit;
    gbType: TGroupBox;
    eType: TEdit;
    gbSClass: TGroupBox;
    cboxSClass: TComboBox;
    gbDClass: TGroupBox;
    cboxDClass: TComboBox;
    tsServer: TTabSheet;
    gbServerIP: TGroupBox;
    eServerIP: TEdit;
    gbServerPort: TGroupBox;
    eServerPort: TEdit;
    gbServerUser: TGroupBox;
    eServerUser: TEdit;
    gbServerPass: TGroupBox;
    eServerPass: TEdit;
    gbLocalUser: TGroupBox;
    eLocalUser: TEdit;
    gbLocalPass: TGroupBox;
    eLocalPass: TEdit;
    gbLocalDB: TGroupBox;
    peLocalDB: TPathEdit;
    tsProgram: TTabSheet;
    gbPass: TGroupBox;
    ePass: TEdit;
    gbPass2: TGroupBox;
    ePass2: TEdit;
    gbCheckTimer: TGroupBox;
    cboxCheckTimer: TComboBox;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure LoadSettings;
    function  SaveSettings: Boolean;
  public
  end;

implementation

uses DPServAdd, DPServStrings, DPServMain;

{$R *.dfm}

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  if SaveSettings then ModalResult := mrOk;
end;

procedure TfrmOptions.LoadSettings;
begin
  with Settings do begin
    peLocalDB.Text := LocalDB;
    eLocalUser.Text := LocalUser;
    eLocalPass.Text := LocalPass;

    eScales.Value := Scales;
    ePlace.Text := Place;
    eType.Text := TypeS;
    cboxSClass.Text := SClass;
    cboxDClass.Text := DClass;

    eServerIP.Text := ServerIP;
    eServerPort.Text := ServerPort;
    eServerUser.Text := ServerUser;
    eServerPass.Text := ServerPass;

    ePass.Text := ProgramPass;
    ePass2.Text := ProgramPass;
    cboxCheckTimer.ItemIndex := Ord(CheckTimer);
  end;
end;

function TfrmOptions.SaveSettings: Boolean;
  function CheckForErrors: Boolean;
  begin
    Result := ePass.Text = ePass2.Text;
    if not Result then begin
      PageControl.ActivePage := tsProgram;
      ePass2.SetFocus;
      MsgBoxErr(rsErrorCheckPass);
    end;
  end;
var
  TempSettings: TSettings;
  SettingsList: TStringList;
begin
  Result := CheckForErrors;
  if not Result then Exit;

  WriteToLog(rsLOGSettingsSave);

  SettingsList := TStringList.Create;
  try // finally
    try // except
      with TempSettings do begin
        LocalDB := peLocalDB.Text;
        LocalUser := eLocalUser.Text;
        LocalPass := eLocalPass.Text;

        Scales := eScales.Value;
        Place := ePlace.Text;
        TypeS := eType.Text;
        SClass := cboxSClass.Text;
        DClass := cboxDClass.Text;

        ServerIP := eServerIP.Text;
        ServerPort := eServerPort.Text;
        ServerUser := eServerUser.Text;
        ServerPass := eServerPass.Text;

        ProgramPass := ePass.Text;
        CheckTimer := TCheckTimer(cboxCheckTimer.ItemIndex);

        SettingsList.Add(LocalDB);
        SettingsList.Add(LocalUser);
        SettingsList.Add(LocalPass);

        SettingsList.Add(IToS(Scales));
        SettingsList.Add(Place);
        SettingsList.Add(TypeS);
        SettingsList.Add(SClass);
        SettingsList.Add(DClass);

        SettingsList.Add(ServerIP);
        SettingsList.Add(ServerPort);
        SettingsList.Add(ServerUser);
        SettingsList.Add(ServerPass);

        SettingsList.Add(ProgramPass);
        SettingsList.Add(IToS(Ord(CheckTimer)));
      end;

      SettingsList.Add(CFGOK);

      SettingsList.Text := String(Encrypt(AnsiString(SettingsList.Text), CFGKEY));
      SettingsList.SaveToFile(ChangeFileExt(Application.ExeName, '.cfg'));

      with Settings do
        if (ServerIP <> TempSettings.ServerIP) or
        (ServerPort <> TempSettings.ServerPort) or
        (ServerUser <> TempSettings.ServerUser) or
        (ServerPass <> TempSettings.ServerPass) then
          Main.ConnectionServer.Connected := False;
      Settings := TempSettings;
    except
      on E: Exception do begin
        Result := False;
        ErrorSaveLoad(acSave, ctLocal, rsErrorSLSettings, E.Message, False, True);
      end;
    end;
  finally
    SettingsList.Free;
  end;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  WriteToLogForm(True, rsLOGFormOptions);
  LoadSettings;
end;

procedure TfrmOptions.FormDestroy(Sender: TObject);
begin
  WriteToLogForm(False, rsLOGFormOptions);
end;

end.
