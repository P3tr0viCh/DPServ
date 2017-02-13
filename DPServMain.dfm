object Main: TMain
  Left = 453
  Top = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'DPServ'
  ClientHeight = 91
  ClientWidth = 173
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = pmMain
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pmMain: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 44
    Top = 12
    object miCheck: TMenuItem
      Caption = #1055#1077#1088#1077#1076#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
      Default = True
      OnClick = miCheckClick
    end
    object miSeparator01: TMenuItem
      Caption = '-'
    end
    object miOptions: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = miOptionsClick
    end
    object miSeparator02: TMenuItem
      Caption = '-'
    end
    object miAbout: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = miAboutClick
    end
    object miSeparator03: TMenuItem
      Caption = '-'
    end
    object miExit: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = miExitClick
    end
  end
  object ConnectionLocal: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 46
  end
  object ConnectionServer: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Left = 44
    Top = 46
  end
  object Query: TADOQuery
    AutoCalcFields = False
    CommandTimeout = 15
    ParamCheck = False
    Parameters = <>
    Left = 76
    Top = 46
  end
  object CheckTimer: TTimer
    Enabled = False
    OnTimer = CheckTimerTimer
    Left = 76
    Top = 12
  end
  object TrayIcon: TP3TrayIcon
    PopupMenu = pmMain
    OnDblClick = TrayIconDblClick
    Left = 16
    Top = 12
  end
end
