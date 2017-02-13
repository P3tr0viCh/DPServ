unit DPServStrings;

interface

resourcestring
  rsCopyright = '� �3��0���� (�.�. ������, ���� ��������� �����, 2004-2014)|�� ��������� �������� ���������� ��������������� � ������';
  rsAddComp   = '� ���� ������ Access, �������� � ������ Microsoft� Office,'#13#10 +
             '  � ���������� ����������, 2003.'#13#10 +
             '� MySQL ODBC 3.51, � MySQL AB, 2005.';

  rsConnectionLocal  = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Persist Security Info=False;User ID=Admin;Jet OLEDB:Database Password="%s";';
  rsConnectionServer = 'DRIVER={MySQL ODBC 3.51 Driver};SERVER=%s;PORT=%s;DATABASE=wdb3;USER=%s;PASSWORD=%s;OPTION=3;';

  rsTrayIconTip      = '�������� ������ �� ������: ';
  rsTrayIconWait     = '��������';
  rsTrayIconWork     = '�������� ������';

  rsDateTimeFormatLog  = 'yyyy"-"mm"-"dd" "hh":"nn":"ss';
  rsDateTimeFormatSQL  = 'yyyy"-"mm"-"dd" "hh":"nn":"ss';

  rsQuestionClose = '������� ��������� � ���������� �������� ������ �� ������?';

  rsErrorLocalNotExists   = '���� ������ "������" (%s) �� ���������� ��� ���������� � ������ ������';
  rsErrorServerNotExists  = '��������� ������ �� ����� �������� ������� ���� ������:'#13#10 +
                         '"%s"';
  rsErrorLocalOpen        = '��������� ������ �� ����� �������� ���� ������ "������":'#13#10 +
                         '"%s"';
  rsErrorSettingsNotExists= '���� ������ � ����������� �� ����������';
  rsErrorSettingsBad      = '���� ������ � ����������� ����������';
  rsErrorCloseApp         = '.'#13#10#13#10'������ ���� ���������� ��� ������, ������� ��������� �����������';
  rsErrorCheckPass     = '��������� ������ �� ���������. ��������� ���� ������ ������ � ��� ������������';
  rsErrorPassword      = '������ ������?'#13#10#13#10 +
                      '������� ������ ������.'#13#10 +
                      '��������� ������������ ������������� �������� � ��������� ����������';

  rsErrorSaveLoad      = '�� ������� %s, ��� ��� ��������� ������:'#13#10#13#10'%s';
  rsErrorOpen          = '������� ��%s%s';
  rsErrorSave          = '��������� %s � %s ���� ������';
  rsErrorLoad          = '��������� %s �� %s ���� ������';
  rsErrorDelete        = '������� %s �� %s ���� ������';
  rsErrorLocalDB       = '���������';
  rsErrorServerDB      = '�������';
  rsErrorSLSettings    = '���������';
  rsErrorSLScaleInfo   = '������ � �����';
  rsErrorSLVans        = '��������';

  rsTableLocal            = 'Measures';
  rsTableLocalAll         = 'Measures, Weights, Products';
  rsTableServerScalesInfo = 'scalesinfo';
  rsTableServer           = 'dpb';

  rsSQLServerScalesInfo   = 'scales, ctime, cdatetime, ipaddr, type, sclass, dclass, place, tag1';
  rsSQLLocalMeasures      = 'Measures.ID, Measures.DT, Weights.WeighName, Products.Product, Weights.Left, Measures.Weigh';
  rsSQLLocalWhere         = '(Send=0) AND (Measures.WeighID = Weights.WeighID) AND (Measures.ProductID = Products.ProductID)';
  rsSQLServerMeasures     = 'scales, id, bdatetime, weighname, product, leftside, netto';
  rsSQLLocalSend          = 'Send';

  rsSQLInsert    = 'INSERT INTO %s (%s) VALUES (%s)';
  rsSQLUpdate    = 'UPDATE %s SET %s WHERE %s';
  rsSQLDelete    = 'DELETE FROM %s';
  rsSQLSelect    = 'SELECT %s FROM %s';
  rsSQLWhere     = ' WHERE (%s)';
  rsSQLOrder     = ' ORDER BY ';
  rsSQLLimitOne  = ' LIMIT 1';
  rsSQLOrderDesc = ' DESC';
  rsSQLCount     = 'COUNT(*)';

  rsNameEqualValue = '%s=%s';
  rsSQLAnd         = ' AND ';

  rsLocalIndex      = 'ID';
  rsScalesIndex     = 'scales';
  rsScalesDateIndex = 'bdatetime';
  rsLocalOrderBy    = 'DT';

  rsLOGStartProgram       = '<><><><><><><>< START PROGRAM DPServ %s ><><><><><><><>';
  rsLOGStopProgram        = 'STOP PROGRAM';
  rsLOGError              = 'ERROR: ';
  rsLOGSettingsSave       = 'save settings';
  rsLOGScaleInfoSave      = 'save scale info';
  rsLOGFormOptions        = 'options';
  rsLOGDataSave           = 'save data, count=%d';
  rsLOGLocalChangeTable   = 'change table message';
  rsLOGErrorPassword      = 'options password error';

implementation

end.
