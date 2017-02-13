object frmOptions: TfrmOptions
  Left = 419
  Top = 234
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 296
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    490
    296)
  PixelsPerInch = 96
  TextHeight = 18
  object BevelBottom: TBevel
    Left = 8
    Top = 244
    Width = 474
    Height = 5
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object btnOK: TButton
    Left = 289
    Top = 254
    Width = 90
    Height = 32
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 387
    Top = 254
    Width = 90
    Height = 32
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object PanelMain: TPanel
    Left = 8
    Top = 8
    Width = 476
    Height = 228
    Anchors = [akLeft, akTop, akBottom]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 2
    object PageControl: TPageControl
      Tag = 4
      Left = 0
      Top = 0
      Width = 472
      Height = 224
      ActivePage = tsProgram
      Align = alClient
      MultiLine = True
      TabOrder = 0
      object tsProgram: TTabSheet
        Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object gbPass: TGroupBox
          Left = 4
          Top = 4
          Width = 224
          Height = 60
          Caption = #1055#1072#1088#1086#1083#1100' '#1085#1072#1089#1090#1088#1086#1077#1082
          TabOrder = 0
          object ePass: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 50
            PasswordChar = '#'
            TabOrder = 0
          end
        end
        object gbPass2: TGroupBox
          Left = 234
          Top = 4
          Width = 224
          Height = 60
          Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
          TabOrder = 1
          object ePass2: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 50
            PasswordChar = '#'
            TabOrder = 0
          end
        end
        object gbCheckTimer: TGroupBox
          Left = 4
          Top = 64
          Width = 224
          Height = 60
          Caption = #1058#1072#1081#1084#1077#1088' '#1086#1090#1087#1088#1072#1074#1082#1080
          TabOrder = 2
          object cboxCheckTimer: TComboBox
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = #1054#1090#1082#1083#1102#1095#1077#1085
            Items.Strings = (
              #1054#1090#1082#1083#1102#1095#1077#1085
              '1 '#1084#1080#1085#1091#1090#1072
              '5 '#1084#1080#1085#1091#1090
              '10 '#1084#1080#1085#1091#1090
              '15 '#1084#1080#1085#1091#1090
              '20 '#1084#1080#1085#1091#1090
              '30 '#1084#1080#1085#1091#1090)
          end
        end
      end
      object tsProgramLocalDB: TTabSheet
        Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object gbLocalUser: TGroupBox
          Left = 4
          Top = 64
          Width = 224
          Height = 60
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          TabOrder = 1
          object eLocalUser: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            Color = clBtnFace
            MaxLength = 50
            ReadOnly = True
            TabOrder = 0
            Text = 'Admin'
          end
        end
        object gbLocalPass: TGroupBox
          Left = 234
          Top = 64
          Width = 224
          Height = 60
          Caption = #1055#1072#1088#1086#1083#1100
          TabOrder = 2
          object eLocalPass: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 50
            PasswordChar = '#'
            TabOrder = 0
          end
        end
        object gbLocalDB: TGroupBox
          Left = 4
          Top = 4
          Width = 454
          Height = 60
          Caption = #1055#1091#1090#1100' '#1082' '#1041#1044' (mdb)'
          TabOrder = 0
          object peLocalDB: TPathEdit
            Left = 8
            Top = 24
            Width = 412
            Height = 26
            TabOrder = 0
            Button.Left = 420
            Button.Top = 25
            Button.Width = 24
            Button.Height = 24
            Button.Caption = '...'
            Button.TabOrder = 1
            OpenFileDialog.Filter = #1041#1044' Access (mdb)|*.mdb|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
            OpenFileDialog.Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
            OpenFolderDialog.SyncCustomButton = False
            OpenFolderDialog.Position = bpCenter
            OpenFolderDialog.PositionLeft = 0
            OpenFolderDialog.PositionTop = 0
            RelativePath = False
          end
        end
      end
      object tsScales: TTabSheet
        Caption = #1042#1077#1089#1099
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object gbPlace: TGroupBox
          Left = 4
          Top = 64
          Width = 224
          Height = 60
          Caption = #1052#1077#1089#1090#1086' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
          TabOrder = 1
          object ePlace: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 127
            TabOrder = 0
          end
        end
        object gbScales: TGroupBox
          Left = 4
          Top = 4
          Width = 120
          Height = 60
          Caption = #1053#1086#1084#1077#1088' '#1074#1077#1089#1086#1074
          TabOrder = 0
          object eScales: TExtSpinEdit
            Left = 8
            Top = 24
            Width = 104
            Height = 27
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 0
          end
        end
        object gbType: TGroupBox
          Left = 234
          Top = 64
          Width = 224
          Height = 60
          Caption = #1058#1080#1087
          TabOrder = 2
          object eType: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 15
            TabOrder = 0
          end
        end
        object gbSClass: TGroupBox
          Left = 4
          Top = 124
          Width = 224
          Height = 60
          Caption = #1050#1083#1072#1089#1089' '#1090#1086#1095#1085#1086#1089#1090#1080' '#1074' '#1089#1090#1072#1090#1080#1082#1077
          TabOrder = 3
          object cboxSClass: TComboBox
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            DropDownCount = 4
            MaxLength = 7
            TabOrder = 0
            Items.Strings = (
              #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1081
              #1042#1099#1089#1086#1082#1080#1081
              #1057#1088#1077#1076#1085#1080#1081
              #1054#1073#1099#1095#1085#1099#1081)
          end
        end
        object gbDClass: TGroupBox
          Left = 234
          Top = 124
          Width = 224
          Height = 60
          Caption = #1050#1083#1072#1089#1089' '#1090#1086#1095#1085#1086#1089#1090#1080' '#1074' '#1076#1080#1085#1072#1084#1080#1082#1077
          TabOrder = 4
          object cboxDClass: TComboBox
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            DropDownCount = 4
            MaxLength = 7
            TabOrder = 0
            Items.Strings = (
              '0.2'
              '0.5'
              '1'
              '2')
          end
        end
      end
      object tsServer: TTabSheet
        Caption = #1057#1077#1088#1074#1077#1088
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object gbServerIP: TGroupBox
          Left = 4
          Top = 4
          Width = 224
          Height = 60
          Caption = 'IP-'#1072#1076#1088#1077#1089
          TabOrder = 0
          object eServerIP: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 15
            TabOrder = 0
          end
        end
        object gbServerPort: TGroupBox
          Left = 234
          Top = 4
          Width = 224
          Height = 60
          Caption = #1055#1086#1088#1090
          TabOrder = 1
          object eServerPort: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 5
            TabOrder = 0
            Text = '3306'
          end
        end
        object gbServerUser: TGroupBox
          Left = 4
          Top = 64
          Width = 224
          Height = 60
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          TabOrder = 2
          object eServerUser: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 50
            TabOrder = 0
          end
        end
        object gbServerPass: TGroupBox
          Left = 234
          Top = 64
          Width = 224
          Height = 60
          Caption = #1055#1072#1088#1086#1083#1100
          TabOrder = 3
          object eServerPass: TEdit
            Left = 8
            Top = 24
            Width = 206
            Height = 26
            MaxLength = 50
            PasswordChar = '#'
            TabOrder = 0
          end
        end
      end
    end
  end
end
