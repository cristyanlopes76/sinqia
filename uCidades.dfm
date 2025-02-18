object frmCidades: TfrmCidades
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Cidades'
  ClientHeight = 316
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pagPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 674
    Height = 316
    ActivePage = tabCadastro
    Align = alClient
    TabOrder = 0
    object tabConsulta: TTabSheet
      Caption = 'Consulta'
      object Panel2: TPanel
        Left = 0
        Top = 27
        Width = 666
        Height = 46
        Align = alTop
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 7
          Top = 3
          Width = 46
          Height = 13
          Caption = 'Pesquisar'
        end
        object Label2: TLabel
          Left = 430
          Top = 3
          Width = 117
          Height = 13
          Caption = 'Campo a ser Pesquisado'
        end
        object edtPesquisa: TEdit
          Left = 7
          Top = 19
          Width = 417
          Height = 21
          TabOrder = 0
          TextHint = 'Digite aqui para pesquisar'
        end
        object btnConsultar: TBitBtn
          AlignWithMargins = True
          Left = 582
          Top = 14
          Width = 80
          Height = 27
          Margins.Top = 13
          Margins.Bottom = 4
          Align = alRight
          Caption = 'Consultar'
          TabOrder = 2
          OnClick = btnConsultarClick
        end
        object cboPesquisa: TComboBox
          Left = 430
          Top = 19
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 1
          TabStop = False
          Text = 'Nome'
          Items.Strings = (
            'Codigo_Cidade'
            'Nome'
            'Estado'
            'Cep_Inicial'
            'Cep_Final')
        end
      end
      object dbGridConsulta: TDBGrid
        Left = 0
        Top = 73
        Width = 666
        Height = 180
        Align = alClient
        DataSource = dsConsulta
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo_Cidade'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 418
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Estado'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cep_Inicial'
            Title.Caption = 'Cep Inicial'
            Width = 58
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cep_Final'
            Title.Caption = 'Cep Final'
            Width = 56
            Visible = True
          end>
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 666
        Height = 27
        Align = alTop
        Alignment = taLeftJustify
        BevelKind = bkSoft
        BevelOuter = bvLowered
        Caption = '  Consulta de Cidades'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object Panel1: TPanel
        Left = 0
        Top = 253
        Width = 666
        Height = 35
        Align = alBottom
        ParentBackground = False
        TabOrder = 3
        object btnSair: TBitBtn
          AlignWithMargins = True
          Left = 582
          Top = 4
          Width = 80
          Height = 27
          Align = alRight
          Caption = 'Sair'
          TabOrder = 3
          TabStop = False
          OnClick = btnSairClick
        end
        object btnExcluir: TBitBtn
          AlignWithMargins = True
          Left = 496
          Top = 4
          Width = 80
          Height = 27
          Align = alRight
          Caption = 'Excluir'
          TabOrder = 2
          TabStop = False
          OnClick = btnExcluirClick
        end
        object btnEditar: TBitBtn
          AlignWithMargins = True
          Left = 410
          Top = 4
          Width = 80
          Height = 27
          Align = alRight
          Caption = 'Editar'
          TabOrder = 1
          TabStop = False
          OnClick = btnEditarClick
        end
        object btnNovo: TBitBtn
          AlignWithMargins = True
          Left = 324
          Top = 4
          Width = 80
          Height = 27
          Align = alRight
          Caption = 'Novo'
          TabOrder = 0
          TabStop = False
          OnClick = btnNovoClick
        end
      end
    end
    object tabCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 666
        Height = 253
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          Left = 26
          Top = 36
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label4: TLabel
          Left = 32
          Top = 63
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label5: TLabel
          Left = 10
          Top = 117
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'CEP Inicial:'
        end
        object Label6: TLabel
          Left = 26
          Top = 90
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label7: TLabel
          Left = 15
          Top = 145
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = 'CEP Final:'
        end
        object pnlCadastro: TPanel
          Left = 1
          Top = 1
          Width = 664
          Height = 27
          Align = alTop
          Alignment = taLeftJustify
          BevelKind = bkSoft
          BevelOuter = bvLowered
          Caption = '  Cadastro de Cidade (EDITAR)'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
        end
        object edtCodigo: TEdit
          Left = 67
          Top = 32
          Width = 49
          Height = 21
          TabStop = False
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = 'edtCodigo'
        end
        object edtNome: TEdit
          Left = 67
          Top = 59
          Width = 313
          Height = 21
          MaxLength = 100
          TabOrder = 1
        end
        object edtCepInicial: TEdit
          Left = 67
          Top = 113
          Width = 121
          Height = 21
          MaxLength = 9
          TabOrder = 3
          OnChange = edtCepInicialChange
          OnKeyPress = edtCepInicialKeyPress
        end
        object cboEstado: TComboBox
          Left = 67
          Top = 86
          Width = 145
          Height = 21
          Style = csDropDownList
          MaxLength = 2
          TabOrder = 2
          Items.Strings = (
            'AC'
            'AL'
            'AP'
            'AM'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MT'
            'MS'
            'MG'
            'PA'
            'PB'
            'PR'
            'PE'
            'PI'
            'RJ'
            'RN'
            'RS'
            'RO'
            'RR'
            'SC'
            'SP'
            'SE'
            'TO')
        end
        object edtCepFinal: TEdit
          Left = 67
          Top = 141
          Width = 121
          Height = 21
          MaxLength = 9
          TabOrder = 4
          OnChange = edtCepFinalChange
          OnKeyPress = edtCepInicialKeyPress
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 253
        Width = 666
        Height = 35
        Align = alBottom
        ParentBackground = False
        TabOrder = 1
        object btnCancelar: TBitBtn
          AlignWithMargins = True
          Left = 582
          Top = 4
          Width = 80
          Height = 27
          Align = alRight
          Caption = 'Cancelar'
          TabOrder = 1
          TabStop = False
          OnClick = btnCancelarClick
        end
        object btnGravar: TBitBtn
          AlignWithMargins = True
          Left = 496
          Top = 4
          Width = 80
          Height = 27
          Align = alRight
          Caption = 'Gravar'
          TabOrder = 0
          OnClick = btnGravarClick
        end
      end
    end
  end
  object dsConsulta: TDataSource
    DataSet = fdConsulta
    Left = 632
    Top = 136
  end
  object fdConsulta: TFDQuery
    Connection = DM.Conexao
    SQL.Strings = (
      'select * from Cidades')
    Left = 602
    Top = 136
    object fdConsultaCodigo_Cidade: TFDAutoIncField
      FieldName = 'Codigo_Cidade'
      Origin = 'Codigo_Cidade'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdConsultaNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 100
    end
    object fdConsultaEstado: TStringField
      FieldName = 'Estado'
      Origin = 'Estado'
      Required = True
      FixedChar = True
      Size = 2
    end
    object fdConsultaCep_Inicial: TStringField
      DisplayWidth = 8
      FieldName = 'Cep_Inicial'
      Origin = 'Cep_Inicial'
      Required = True
      FixedChar = True
      Size = 8
    end
    object fdConsultaCep_Final: TStringField
      DisplayWidth = 8
      FieldName = 'Cep_Final'
      Origin = 'Cep_Final'
      Required = True
      FixedChar = True
      Size = 8
    end
  end
end
