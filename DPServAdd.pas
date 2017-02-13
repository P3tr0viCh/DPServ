unit DPServAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Utils_FileIni, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Utils_Str, Utils_Misc,
  Utils_Files, Utils_Date, DateUtils, StrUtils, DB, ADODB, Utils_Log, Utils_SQL;

const
  CFGKEY      = 21834;
  CFGOK       = 'P3tr0viCh1310';

type
  TProcessAction    = (acOpen, acLoad, acSave, acDelete);
  TConnectionType   = (ctLocal, ctServer);
  TCheckTimer       = (ctOff, ct1, ct5, ct10, ct15, ct20, ct30);

  TSettings = record
    Scales:        SmallInt;  // Номер весов
    Place:         String;    // Место установки
    TypeS:         String;    // Тип весов
    SClass:        String;    // Точность в статике
    DClass:        String;    // Точность в динамике

    LocalDB:       String;    // База данных "Веском"
    LocalUser:     String;    // Пользователь БД "Веском"
    LocalPass:     String;    // Пароль пользователя БД "Веском"

    ServerIP:      String;    // IP сервера MySQL
    ServerPort:    String;    // Порт сервера MySQL
    ServerUser:    String;    // Пользователь на сервере
    ServerPass:    String;    // Пароль пользователя на сервере

    ProgramPass:   String;    // Пароль для входа в настройки
    CheckTimer:    TCheckTimer;   // Таймер проверки таблиц
  end;

var
  Settings: TSettings;

function  CanServer: Boolean;
function  OpenConnections: Boolean;
procedure CloseConnections;
procedure SelectConnection(AConnectionType: TConnectionType);

function  SQLSelect(ATableName, AWhat, AWhere: String): String;
function  SQLInsert(ATableName, AFields, AValues: String): String;
function  SQLUpdate(ATableName: String; AColumns: array of String; AValues: array of Variant; AWhere: String): String;
function  SQLDelete(ATableName, AWhere: String): String;
function  SQLWhere(AWhere: String): String;
function  SQLOrderBy(AOrderBy: array of String; AOrderDesc: array of Boolean): String;

function  SQLNameEqualValue(AName: String; AValue: Variant): String;
function  SQLNamesEqualValues(AColumns: array of String; AValues: array of Variant): String;

function  WhereScalesIndex(AScales: SmallInt): String;
function  WhereScalesAndIDIndex(AScales: SmallInt; AID: Integer): String;

procedure ErrorSaveLoad(ProcessAction: TProcessAction; ConnectionType: TConnectionType; AWhat, AError: String;
  CloseConnections: Boolean = True; ShowMessage: Boolean = False);

function  DTToSQLStr  (ADateTime: TDateTime): String;
function  DTToWTime(ADateTime: TDateTime): LongWord;
function  WTimeToDT(AWTime: LongWord): TDateTime;

function  GetTimerCount(AFirstTick: LongWord): String;
function  SToF(Value: String): Double;

implementation

uses DPServStrings, DPServMain;

function CanConnectServer: Boolean;
begin
  with Settings do Result := (Scales <> 0) and (ServerIP <> '');
end;

function CanServer: Boolean;
begin
  Result := CanConnectServer;
  if Result then Result := Main.ConnectionServer.Connected;
end;

function OpenConnections: Boolean;
var
  LocalDB, sError, sErrorE: String;
begin
  Result := False;
  sError := '';
  try // finally
    LocalDB := Settings.LocalDB;
    if not FileExists(LocalDB) then begin
      sError := Format(rsErrorLocalNotExists, [LocalDB]);
      Exit;
    end;
    
    if not Main.ConnectionLocal.Connected then begin
      Main.ConnectionLocal.ConnectionString :=
      Format(rsConnectionLocal, [LocalDB, {Settings.LocalUser,} Settings.LocalPass]);
      try
        Main.ConnectionLocal.Open;
      except
        on E: Exception do sErrorE := E.Message;
      end;
      if not Main.ConnectionLocal.Connected then begin
        sError := Format(rsErrorLocalOpen, [sErrorE]);
        Exit;
      end;
    end;

    Result := sError = '';

    if Result and CanConnectServer then begin
      if not Main.ConnectionServer.Connected then begin
        with Settings do
          Main.ConnectionServer.ConnectionString := Format(rsConnectionServer,
            [ServerIP, ServerPort, ServerUser, ServerPass]);
        try
          Main.ConnectionServer.Open;
        except
          on E: Exception do sErrorE := E.Message;
        end;
        if not Main.ConnectionServer.Connected then 
          sError := Format(rsErrorServerNotExists, [sErrorE]);
      end;
    end;
  finally
    if sError <> '' then ErrorSaveLoad(acOpen, ctLocal, '', sError, True, False);
  end;
end;

procedure CloseConnections;
begin
  Main.ConnectionLocal.Close;
  Main.ConnectionServer.Close;
end;

procedure SelectConnection(AConnectionType: TConnectionType);
var
  ADOConnection: TADOConnection;
begin
  case AConnectionType of
  ctServer:   ADOConnection := Main.ConnectionServer;
  ctLocal:    ADOConnection := Main.ConnectionLocal;
  else        ADOConnection := nil;
  end;
  Main.Query.Connection := ADOConnection;
end;

function  SQLSelect(ATableName, AWhat, AWhere: String): String;
begin
  Result := Format(rsSQLSelect, [AWhat, ATableName]);
  if AWhere <> '' then Result := Result + SQLWhere(AWhere);
end;

function  SQLInsert(ATableName, AFields, AValues: String): String;
begin
  Result := Format(rsSQLInsert, [ATableName, AFields, AValues]);
end;

function  SQLUpdate(ATableName: String; AColumns: array of String; AValues: array of Variant; AWhere: String): String;
begin
  Result := Format(rsSQLUpdate, [ATableName, SQLNamesEqualValues(AColumns, AValues), AWhere]);
end;

function  SQLDelete(ATableName, AWhere: String): String;
begin
  Result := Format(rsSQLDelete, [ATableName]) + SQLWhere(AWhere);
end;

function  SQLWhere(AWhere: String): String;
begin
  Result := Format(rsSQLWhere, [AWhere]);
end;

function  SQLOrderBy(AOrderBy: array of String; AOrderDesc: array of Boolean): String;
var
  i: Integer;
  S: String;
begin
  for i := Low(AOrderBy) to High(AOrderBy) do begin
    S := AOrderBy[i];
    if i in [Low(AOrderDesc)..High(AOrderDesc)] then begin
      if AOrderDesc[i] then S := S + rsSQLOrderDesc;
    end;
    Result := ConcatStrings(Result, S, ', ');
  end;
  Result := rsSQLOrder + Result;
end;

function  SQLNameEqualValue(AName: String; AValue: Variant): String;
begin
  Result := Format(rsNameEqualValue, [AName, SQLFormatValue(AValue)]);
end;

function  SQLNamesEqualValues(AColumns: array of String; AValues: array of Variant): String;
var
  i: Integer;
begin
  Result := '';
  for i := Low(AColumns) to High(AColumns) do
    Result := ConcatStrings(Result, SQLNameEqualValue(AColumns[i], AValues[i]), ', ');
end;

function  WhereScalesIndex(AScales: SmallInt): String;
begin
  Result := SQLNameEqualValue(rsScalesIndex, AScales);
end;

function  WhereScalesAndIDIndex(AScales: SmallInt; AID: Integer): String;
begin
  Result := SQLNameEqualValue(rsScalesIndex, AScales) + rsSQLAnd + SQLNameEqualValue(rsLocalIndex, AID);
end;

procedure ErrorSaveLoad(ProcessAction: TProcessAction; ConnectionType: TConnectionType;
  AWhat, AError: String; CloseConnections: Boolean = True; ShowMessage: Boolean = False);
var
  S, SAction, SDB: String;
begin
  if CloseConnections then begin
    Main.ConnectionLocal.Close;
    Main.ConnectionServer.Close;
  end;
  case ConnectionType of
  ctLocal:    SDB := rsErrorLocalDB;
  ctServer:   SDB := rsErrorServerDB;
  end;
  case ProcessAction of
  acOpen:     begin SAction := rsErrorOpen; SDB := ''; end;
  acLoad:     SAction := rsErrorLoad;
  acSave:     SAction := rsErrorSave;
  acDelete:   SAction := rsErrorDelete;
  end;
  S := Format(rsErrorSaveLoad, [Format(SAction, [AWhat, SDB]), AError]);
  WriteToLog(rsLOGError + S);
  if ShowMessage then MsgBoxErr(S);
end;

function GetTimerCount(AFirstTick: LongWord): String;
begin
  Result := ' (' + MyFormatTime(ExtractHMSFromMS(GetTickCount - AFirstTick), True) + ')';
end;

function  DTToSQLStr(ADateTime: TDateTime): String;
begin
  Result := FormatDateTime(rsDateTimeFormatSQL, ADateTime);
end;

function  DTToWTime(ADateTime: TDateTime): LongWord;
begin
  Result := Integer(DateTimeToUnix(ADateTime));
end;

function  WTimeToDT(AWTime: LongWord): TDateTime;
begin
  Result := UnixToDateTime(AWTime);
end;

function  SToF(Value: String): Double;
begin
  if Value = '' then Result := 0 else Result := StrToFloat(Value);
end;

end.
