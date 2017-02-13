unit DPServStrings;

interface

resourcestring
  rsCopyright = '© П3тр0виЧъ (К.П. Дураев, ЦВТС Уральская Сталь, 2004-2014)|По возникшим вопросам обращаться непосредственно к автору';
  rsAddComp   = '• База данных Access, входящая в состав Microsoft® Office,'#13#10 +
             '  © Корпорация Майкрософт, 2003.'#13#10 +
             '• MySQL ODBC 3.51, © MySQL AB, 2005.';

  rsConnectionLocal  = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Persist Security Info=False;User ID=Admin;Jet OLEDB:Database Password="%s";';
  rsConnectionServer = 'DRIVER={MySQL ODBC 3.51 Driver};SERVER=%s;PORT=%s;DATABASE=wdb3;USER=%s;PASSWORD=%s;OPTION=3;';

  rsTrayIconTip      = 'Передача данных на сервер: ';
  rsTrayIconWait     = 'ожидание';
  rsTrayIconWork     = 'отправка данных';

  rsDateTimeFormatLog  = 'yyyy"-"mm"-"dd" "hh":"nn":"ss';
  rsDateTimeFormatSQL  = 'yyyy"-"mm"-"dd" "hh":"nn":"ss';

  rsQuestionClose = 'Закрыть программу и остановить передачу данных на сервер?';

  rsErrorLocalNotExists   = 'База данных "Веском" (%s) не существует или недоступна в данный момент';
  rsErrorServerNotExists  = 'Произошла ошибка во время открытия сетевой базы данных:'#13#10 +
                         '"%s"';
  rsErrorLocalOpen        = 'Произошла ошибка во время открытия базы данных "Веском":'#13#10 +
                         '"%s"';
  rsErrorSettingsNotExists= 'База данных с настройками не существует';
  rsErrorSettingsBad      = 'База данных с настройками повреждена';
  rsErrorCloseApp         = '.'#13#10#13#10'Данная база необходима для работы, поэтому программа закрывается';
  rsErrorCheckPass     = 'Введенные пароли не совпадают. Повторите ввод нового пароля и его подверждения';
  rsErrorPassword      = 'Забыли пароль?'#13#10#13#10 +
                      'Введите пароль заново.'#13#10 +
                      'Проверьте правильность используемого регистра и раскладки клавиатуры';

  rsErrorSaveLoad      = 'Не удалось %s, так как произошла ошибка:'#13#10#13#10'%s';
  rsErrorOpen          = 'открыть БД%s%s';
  rsErrorSave          = 'сохранить %s в %s базе данных';
  rsErrorLoad          = 'прочитать %s из %s базы данных';
  rsErrorDelete        = 'удалить %s из %s базы данных';
  rsErrorLocalDB       = 'локальной';
  rsErrorServerDB      = 'сетевой';
  rsErrorSLSettings    = 'настройки';
  rsErrorSLScaleInfo   = 'данные о весах';
  rsErrorSLVans        = 'провески';

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
