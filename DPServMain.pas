unit DPServMain;

interface

//{$DEFINE NOPASS} {$DEFINE FORCECLOSE}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AboutFrm, Utils_Misc, DB, ADODB, Utils_Base64,
  Utils_Date, Utils_Str, Utils_Files, ImgList, StdCtrls, ExtCtrls, Utils_Log,
  P3TrayIcon, Utils_SQL;

type
  TMain = class(TForm)
    pmMain: TPopupMenu;
    miExit: TMenuItem;
    miAbout: TMenuItem;
    miSeparator01: TMenuItem;
    miOptions: TMenuItem;
    miSeparator02: TMenuItem;
    ConnectionLocal: TADOConnection;
    ConnectionServer: TADOConnection;
    Query: TADOQuery;
    miCheck: TMenuItem;
    miSeparator03: TMenuItem;
    CheckTimer: TTimer;
    TrayIcon: TP3TrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure miOptionsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miCheckClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState);
    procedure CheckTimerTimer(Sender: TObject);
  private
    UralSteelChangeTable: UINT;
    function  PerformOpenDataBase: Boolean;
    procedure TrayIconShowMenu(AMenu: Byte);
    procedure TrayIconTip(AWait: Boolean);

    function  SaveScaleInfo: Boolean;
    function  StartSendData: Boolean;
  public
    function  LoadSettings: Boolean;
    procedure ChangeCheckTimer;
    function  ShowOptions: Boolean;

    procedure DefaultHandler(var Message); override;
  end;

var
  Main: TMain;

implementation

uses DPServStrings, DPServOptions, DPServAdd, DPServLogin;

{$R *.dfm}

function TMain.PerformOpenDataBase: Boolean;
begin
  Result := LoadSettings;
  if not Result then Exit;
  StartSendData;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  TrayIconTip(False);
  WriteToLog(Format(rsLOGStartProgram, [GetFileVersion(Application.ExeName)]));
  UseADOQuery(Query);
  UralSteelChangeTable := RegisterWindowMessage('UralSteelChangeTable');
  TrayIconTip(True);
  PerformOpenDataBase;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  WriteToLog(rsLOGStopProgram);
end;

procedure TMain.TrayIconShowMenu(AMenu: Byte);
// AMenu: 0 - Close, 1 - About, 2 - Options
begin
  TrayIcon.Enabled := False;
  try
    case AMenu of
    0:
      {$IFNDEF FORCECLOSE}
      if MsgBoxYesNo(rsQuestionClose) then
      {$ENDIF}
      Close;
    1: begin
      WriteToLog('ABOUT');
      ShowAbout(18, 1, 3, #0, nil, rsAddComp, #0, #0, rsCopyright);
    end;
    2: if ShowOptions then
      begin
        SaveScaleInfo;
        ChangeCheckTimer;
      end;
    end;
  finally
    TrayIcon.Enabled := True;
  end;
end;

function TMain.ShowOptions: Boolean;
begin
  {$IFNDEF NOPASS}
  Result := ShowLogin;
  if not Result then Exit;
  {$ENDIF}
  with TfrmOptions.Create(Application) do
    try
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

procedure TMain.miExitClick(Sender: TObject);
begin
  TrayIconShowMenu(0);
end;

procedure TMain.miAboutClick(Sender: TObject);
begin
  TrayIconShowMenu(1);
end;

procedure TMain.miOptionsClick(Sender: TObject);
begin
  TrayIconShowMenu(2);
end;

function TMain.LoadSettings: Boolean;
var
  i: Integer;
  SettingsFile: String;
  SettingsList: TStringList;

  function GetSettingsList(var Index: Integer): String;
  begin
    Result := SettingsList[i]; Inc(i);
  end;
begin
  Result := False;
  SettingsFile := ChangeFileExt(Application.ExeName, '.cfg');
  SettingsList := TStringList.Create;
  try
    try
      Result := FileExists(SettingsFile);
      if not Result then
        begin
          ErrorSaveLoad(acLoad, ctLocal, rsErrorSLSettings, rsErrorSettingsNotExists + rsErrorCloseApp, True, True);
          Exit;
        end;

      SettingsList.LoadFromFile(SettingsFile);
      SettingsList.Text := String(Decrypt(AnsiString(SettingsList[0]), CFGKEY));
      Result := SettingsList[SettingsList.Count - 1] = CFGOK;

      if not Result then
        begin
          ErrorSaveLoad(acLoad, ctLocal, rsErrorSLSettings, rsErrorSettingsBad + rsErrorCloseApp, True, True);
          Exit;
        end;

      with Settings do
        begin
          i := 0;
          LocalDB :=       GetSettingsList(i);
          LocalUser :=     GetSettingsList(i);
          LocalPass :=     GetSettingsList(i);

          Scales :=        SToI(GetSettingsList(i));
          Place :=         GetSettingsList(i);
          TypeS :=         GetSettingsList(i);
          SClass :=        GetSettingsList(i);
          DClass :=        GetSettingsList(i);

          ServerIP :=      GetSettingsList(i);
          ServerPort :=    GetSettingsList(i);
          ServerUser :=    GetSettingsList(i);
          ServerPass :=    GetSettingsList(i);

          ProgramPass :=   GetSettingsList(i);
          CheckTimer :=    TCheckTimer(SToI(GetSettingsList(i)));
          ChangeCheckTimer;
        end;
      Result := True;
    except
      on E: Exception do begin
        Result := False;
        ErrorSaveLoad(acLoad, ctLocal, rsErrorSLSettings, rsErrorSettingsBad + rsErrorCloseApp, True, True);
      end;
    end;
  finally
    SettingsList.Free;
    if not Result then Application.Terminate;
  end;
end;

function TMain.SaveScaleInfo: Boolean;
var
  ATableName, AFields, AValues, AError, ALog: String;
  FirstTick: LongWord;
begin
  StartTimer(FirstTick);

  TrayIcon.Enabled := False;
  ALog := rsLOGScaleInfoSave;
  try
    with Settings do
      try
        Result := OpenConnections;
        if not Result then Exit;
        if not CanServer then Exit;

        ATableName := rsTableServerScalesInfo;
        AFields := rsSQLServerScalesInfo;
        AValues := SQLFormatValues([
          Scales,                    // Номер весов
          DTToWTime(Now),            // Системное время начала связи
          DTToSQLStr(Now),           // Дата и время начала связи
          // Системное время окончания связи
          // Дата и время окончания связи
          // Системное время окончания последнего взвешивания
          GetLocalIP,                // ИП-адрес весов
          TypeS,                     // Тип весов
          SClass,                    // Класс точности в статике
          DClass,                    // Класс точности в динамике
          Place,                     // Место установки весов
          20102                      // Тип весов
        ]);
        AError := rsErrorSLScaleInfo;

        SelectConnection(ctServer);

        SQLExec(SQLDelete(ATableName, WhereScalesIndex(Scales)));
        //      MsgBox(SQLInsert(ATableName, AFields, AValues)); Exit;
        SQLExec(SQLInsert(ATableName, AFields, AValues));
      except
        on E: Exception do begin
          Result := False;
          ErrorSaveLoad(acSave, ctLocal, AError, E.Message);
        end;
      end;
  finally
    CloseConnections;
    TrayIcon.Enabled := True;
    WriteToLog(ALog + GetTimerCount(FirstTick));
  end;
end;

function  TMain.StartSendData: Boolean;
var
  FirstTick: LongWord;
  SendCount: Integer;
  DataBrutto: TStringList;

  function CheckExit: Boolean;
  begin
    Result := Application.Terminated;
  end;

  function CheckData: Boolean;
  var
    SQLString: String;
  begin
    SelectConnection(ctLocal);
    with Main.Query do
      try // except
        SQLString := SQLSelect(rsTableLocal, rsSQLCount,
          SQLNameEqualValue(rsSQLLocalSend, 0));
        //            MsgBox(SQLString);
        SQLOpen(SQLString);
        try
          SendCount := Fields[0].AsInteger;
          Result := SendCount > 0;
        finally
          Close;
        end;
      except
        on E: Exception do begin
          Result := False;
          ErrorSaveLoad(acLoad, ctLocal, rsErrorSLVans, E.Message);
        end;
    end;
  end;

  function PerformLoadData: Boolean;
  begin
    Result := True;
    SelectConnection(ctLocal);
    with Main.Query do
      try // except
      SQLOpen(SQLSelect(rsTableLocalAll, rsSQLLocalMeasures,  rsSQLLocalWhere) +
      SQLOrderBy([rsLocalOrderBy], [True]));
      //            MsgBox(SQL[0]); Exit;
      try
        while not Eof do begin
          DataBrutto.AddObject(SQLFormatValues([
            Settings.Scales,                    // № весов
            Fields[00].AsInteger,               // № взвешивания (ID)
            DTToSQLStr(Fields[01].AsDateTime),  // Дата и время начала взвешивания (DT)
            Fields[02].AsString,                // Весы (WeighName)
            Fields[03].AsString,                // Продукт (Product)
            Integer(Fields[04].AsBoolean),      // Левая сторона (Left)
            SToF(Fields[05].AsString)           // Вес (Weigh)
          ]), TObject(Fields[00].AsInteger));
//          MsgBox(DataBrutto[DataBrutto.Count - 1] + ', ID: ' + IToS(Integer(DataBrutto.Objects[DataBrutto.Count - 1])));
          ProcMess;
          if CheckExit then Break;
          Next;
        end;
      finally
        SendCount := DataBrutto.Count;
        Close;
      end;
      except
        on E: Exception do begin
          Result := False;
          ErrorSaveLoad(acLoad, ctLocal, rsErrorSLVans, E.Message);
        end;
      end;
  end;

  function PerformSaveData: Boolean;
  var
    i, C: Integer;
    AConnectionType: TConnectionType;
    SQLString, AWhere, AError: String;
  begin
    Result := True;

    AError := rsErrorSLVans;

    if DataBrutto.Count = 0 then Exit;
    AConnectionType := ctServer;
    with Main.Query do
      try
        C := 0;
        try
          for i := 0 to DataBrutto.Count - 1 do begin
            AConnectionType := ctServer;
            SelectConnection(AConnectionType);
            AWhere := WhereScalesAndIDIndex(Settings.Scales,
              Integer(DataBrutto.Objects[i]));
            //                     MsgBox(SQLDelete(ATableName, AWhere));
            SQLExec(SQLDelete(rsTableServer, AWhere));
            //                     ProcMess;
            SQLString := SQLInsert(rsTableServer, rsSQLServerMeasures, DataBrutto[i]);
            //                     MsgBox(SQLString);
            SQLExec(SQLString);
            ProcMess;

            AConnectionType := ctLocal;
            SelectConnection(AConnectionType);
            SQLString := SQLUpdate(rsTableLocal, [rsSQLLocalSend], [1],
            SQLNameEqualValue(rsLocalIndex, Integer(DataBrutto.Objects[i])));
            //                     MsgBox(SQLString);
            SQLExec(SQLString);
            ProcMess;

            Inc(C);
            if CheckExit then Break;
          end;
        finally
          Close;
          SendCount := C;
        end;
      except
        on E: Exception do begin
          Result := False;
          ErrorSaveLoad(acSave, AConnectionType, AError, E.Message);
        end;
      end;
  end;
begin
  Result := True;
  with Settings do begin
    if Scales = 0 then Exit;
    if LocalDB = '' then Exit;
  end;
  StartTimer(FirstTick);
  TrayIconTip(False);
  SendCount := -1;
  DataBrutto := TStringList.Create;
  try
    Result := OpenConnections;
    if not Result then Exit;
    Result := CanServer;
    if not Result then Exit;
    Result := CheckData;
    if not Result then Exit;
    if CheckExit then Exit;
    Result := PerformLoadData;
    if not Result then Exit;
    if CheckExit then Exit;
    Result := PerformSaveData;
  finally
    CloseConnections;
    DataBrutto.Free;
    if Result then Result := not CheckExit;
    WriteToLog(Format(rsLOGDataSave, [SendCount]) + GetTimerCount(FirstTick));
    TrayIconTip(True);
  end;
end;

procedure TMain.DefaultHandler(var Message);
begin
  with TMessage(Message) do begin
    if Msg = UralSteelChangeTable then
      begin
        WriteToLog(rsLOGLocalChangeTable);
      end
    else
      inherited DefaultHandler(Message);
  end;
end;

procedure TMain.TrayIconTip(AWait: Boolean);
begin
  CheckTimer.Enabled := AWait;
  miCheck.Enabled := AWait;
  TrayIcon.Tip := rsTrayIconTip;
  if AWait then begin
    TrayIcon.Icon.Handle := LoadImage(HInstance, PChar('MAINICON'), IMAGE_ICON, 16, 16, 0);
    TrayIcon.Tip := TrayIcon.Tip + rsTrayIconWait;
  end else begin
    TrayIcon.Icon.Handle := LoadImage(HInstance, PChar('STOPICON'), IMAGE_ICON, 16, 16, 0);
    TrayIcon.Tip := TrayIcon.Tip + rsTrayIconWork;
  end;
end;

procedure TMain.miCheckClick(Sender: TObject);
begin
  StartSendData;
end;

procedure TMain.TrayIconDblClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState);
begin
  if (Button = mbLeft) and (Shift = []) then miCheck.Click;
end;

procedure TMain.CheckTimerTimer(Sender: TObject);
begin
  StartSendData;
end;

procedure TMain.ChangeCheckTimer;
begin
  with CheckTimer do
    case Settings.CheckTimer of
    ctOff:   Interval := 0;
    ct1:     Interval := 60000;
    ct5:     Interval := 300000;
    ct10:    Interval := 600000;
    ct15:    Interval := 900000;
    ct20:    Interval := 1200000;
    ct30:    Interval := 1800000;
    end;
end;

end.
