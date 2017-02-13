program DPServ;

uses
  Forms,
  Windows,
  DPServMain in 'DPServMain.pas' {Main},
  DPServStrings in 'DPServStrings.pas',
  DPServOptions in 'DPServOptions.pas' {frmOptions},
  DPServAdd in 'DPServAdd.pas',
  DPServLogin in 'DPServLogin.pas' {frmLogin};

{$R *.res}
{$R DPServAdd.res}

function AlreadyRun : Boolean;
begin
  Result:=FindWindow(PChar('TApplication'), PChar('�������� ������ �� ������')) <> 0;
end;

begin
  If AlreadyRun then Exit;
  Application.Initialize;
  Application.Title := '�������� ������ �� ������';
  Application.ShowMainForm:=False;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
