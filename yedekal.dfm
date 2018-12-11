object yedekfrm: Tyedekfrm
  Left = 293
  Top = 140
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #199#305'nar Bilgisayar SQL Yedek Alma Program'#305
  ClientHeight = 380
  ClientWidth = 506
  Color = 15259054
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 8
    Top = 8
    Width = 489
    Height = 364
    BorderStyle = bsSingle
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 0
    OnMouseEnter = Panel2MouseEnter
    object Label2: TLabel
      Left = 10
      Top = 13
      Width = 89
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sql Server  Ad'#305
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 1
      Top = 36
      Width = 97
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sql Kullan'#305'c'#305' Ad'#305
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 23
      Top = 60
      Width = 75
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sql Sifre'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label9: TLabel
      Left = 17
      Top = 84
      Width = 81
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Database Ad'#305
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 23
      Top = 110
      Width = 75
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Kay'#305't Yeri'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label1: TLabel
      Left = 1
      Top = 159
      Width = 97
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'S'#305'k'#305#351't'#305'rma  Yeri'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 15
      Top = 337
      Width = 75
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ayarlar'#305' '
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label11: TLabel
      Left = 352
      Top = 334
      Width = 121
      Height = 13
      Caption = 'Versiyon : 28-11-2018-1.2'
    end
    object Label5: TLabel
      Left = 5
      Top = 190
      Width = 93
      Height = 13
      Caption = 'S'#305'k'#305#351't'#305'rma durum'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 280
      Top = 59
      Width = 31
      Height = 13
      Caption = 'G'#246'ster'
      OnClick = Label6Click
    end
    object klasorbuton1: TSpeedButton
      Left = 317
      Top = 104
      Width = 21
      Height = 23
      Caption = '...'
      Spacing = 1
      OnClick = klasorbuton1Click
    end
    object klasorbuton2: TSpeedButton
      Left = 317
      Top = 155
      Width = 21
      Height = 23
      Caption = '...'
      Spacing = 1
      Visible = False
      OnClick = klasorbuton2Click
    end
    object kullanici: TEdit
      Left = 105
      Top = 33
      Width = 169
      Height = 21
      TabOrder = 1
      OnExit = kullaniciExit
    end
    object sifre: TEdit
      Left = 105
      Top = 57
      Width = 169
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
      OnExit = sifreExit
    end
    object kayit_yeri1: TEdit
      Left = 105
      Top = 105
      Width = 213
      Height = 21
      TabOrder = 4
    end
    object zipla: TCheckBox
      Left = 105
      Top = 131
      Width = 121
      Height = 26
      Caption = 'S'#305'k'#305#351't'#305'rma Yap'#305'ls'#305'n'
      TabOrder = 5
      OnClick = ziplaClick
    end
    object kayit_yeri2: TEdit
      Left = 105
      Top = 156
      Width = 213
      Height = 21
      Hint = 
        'Sadece Yedeklenecek s'#252'r'#252'c'#252' ad'#305' ve database ad'#305' girin ba'#351'ka bilgi' +
        ' girmeyin. '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TextHint = 
        'Sadece Yedeklenecek s'#252'r'#252'c'#252' ad'#305' ve database ad'#305' girin ba'#351'ka bilgi' +
        ' girmeyin. '
    end
    object kaydet: TButton
      Left = 97
      Top = 334
      Width = 49
      Height = 22
      Caption = 'Kaydet'
      TabOrder = 7
      OnClick = kaydetClick
    end
    object yukle: TButton
      Left = 153
      Top = 334
      Width = 49
      Height = 22
      Caption = 'Y'#252'kle'
      TabOrder = 8
      OnClick = yukleClick
    end
    object Panel1: TPanel
      Left = 344
      Top = 9
      Width = 129
      Height = 194
      BorderWidth = 3
      BorderStyle = bsSingle
      Color = clRed
      ParentBackground = False
      ShowCaption = False
      TabOrder = 9
      object baglan: TButton
        Left = 16
        Top = 8
        Width = 89
        Height = 25
        Cancel = True
        Caption = 'SQL Ba'#287'lan'
        TabOrder = 0
        WordWrap = True
        OnClick = baglanClick
      end
      object yedekle: TButton
        Left = 16
        Top = 47
        Width = 89
        Height = 25
        Caption = 'Yedekle'
        Enabled = False
        TabOrder = 1
        OnClick = yedekleClick
      end
      object temizle: TButton
        Left = 16
        Top = 84
        Width = 89
        Height = 25
        Caption = 'Ayarlar'#305' temizle'
        TabOrder = 2
        OnClick = temizleClick
      end
      object kapat: TButton
        Left = 16
        Top = 157
        Width = 89
        Height = 25
        Caption = 'Kapat'
        TabOrder = 3
        OnClick = kapatClick
      end
      object yardim: TButton
        Left = 16
        Top = 122
        Width = 89
        Height = 25
        Caption = 'Yard'#305'm'
        TabOrder = 4
        OnClick = yardimClick
      end
    end
    object AbProgressBar1: TAbProgressBar
      Left = 105
      Top = 185
      Width = 233
      Height = 26
      TabOrder = 10
    end
    object comboserver: TComboBox
      Left = 105
      Top = 9
      Width = 169
      Height = 21
      TabOrder = 0
      OnExit = comboserverExit
    end
    object combodb: TComboBox
      Left = 105
      Top = 81
      Width = 169
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object log_memo: TMemo
      Left = 9
      Top = 225
      Width = 464
      Height = 103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 11
    end
  end
  object sql_memo: TMemo
    Left = 510
    Top = 8
    Width = 352
    Height = 104
    TabOrder = 1
    Visible = False
  end
  object sunucu_baglan: TADOConnection
    Left = 216
    Top = 336
  end
  object sorgu: TADOQuery
    Connection = sunucu_baglan
    Parameters = <>
    Left = 256
    Top = 336
  end
  object AbZipper1: TAbZipper
    ArchiveProgressMeter = AbProgressBar1
    ArchiveSaveProgressMeter = AbProgressBar1
    ItemProgressMeter = AbProgressBar1
    AutoSave = True
    DOSMode = False
    StoreOptions = [soStripDrive, soStripPath, soRemoveDots, soRecurse, soFreshen, soReplace]
    Left = 296
    Top = 336
  end
  object diyalog1: TOpenDialog
    Left = 328
    Top = 336
  end
end
