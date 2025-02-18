object frmClientes: TfrmClientes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 474
  ClientWidth = 672
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
    Width = 672
    Height = 474
    ActivePage = tabCadastro
    Align = alClient
    TabOrder = 0
    object tabConsulta: TTabSheet
      Caption = 'Consulta'
      object Panel2: TPanel
        Left = 0
        Top = 27
        Width = 664
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
        object cboPesquisa: TComboBox
          Left = 430
          Top = 19
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 0
          TabStop = False
          Text = 'CGC_CPF_Cliente'
          Items.Strings = (
            'Codigo_Cliente'
            'CGC_CPF_Cliente'
            'Nome'
            'Telefone'
            'Endereco'
            'Bairro'
            'Complemento'
            'E_mail'
            'Codigo_Cidade'
            'Cep')
        end
        object btnConsultar: TBitBtn
          AlignWithMargins = True
          Left = 580
          Top = 14
          Width = 80
          Height = 27
          Margins.Top = 13
          Margins.Bottom = 4
          Align = alRight
          Caption = 'Consultar'
          TabOrder = 1
          OnClick = btnConsultarClick
        end
        object edtPesquisa: TEdit
          Left = 7
          Top = 19
          Width = 417
          Height = 21
          TabOrder = 2
          TextHint = 'Digite aqui para pesquisar'
        end
      end
      object dbGridConsulta: TDBGrid
        Left = 0
        Top = 73
        Width = 664
        Height = 338
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
            FieldName = 'Codigo_Cliente'
            Title.Caption = 'C'#243'digo'
            Width = 43
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CGC_CPF_Cliente'
            Title.Caption = 'N'#186' Documento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 356
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Telefone'
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Endereco'
            Width = 272
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Bairro'
            Width = 193
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Complemento'
            Width = 251
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'E_mail'
            Title.Caption = 'E-Mail'
            Width = 258
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Codigo_Cidade'
            Title.Caption = 'C'#243'd. Cidade'
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cep'
            Width = 61
            Visible = True
          end>
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 27
        Align = alTop
        Alignment = taLeftJustify
        BevelKind = bkSoft
        BevelOuter = bvLowered
        Caption = '  Consulta de Clientes'
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
        Top = 411
        Width = 664
        Height = 35
        Align = alBottom
        ParentBackground = False
        TabOrder = 3
        object btnSair: TBitBtn
          AlignWithMargins = True
          Left = 580
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
          Left = 494
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
          Left = 408
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
          Left = 322
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
      object pnlCadastrar: TPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 406
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          Left = 45
          Top = 36
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label4: TLabel
          Left = 51
          Top = 63
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label5: TLabel
          Left = 54
          Top = 171
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Caption = 'E-Mail'
        end
        object Label6: TLabel
          Left = 33
          Top = 90
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label7: TLabel
          Left = 371
          Top = 198
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object Label8: TLabel
          Left = 145
          Top = 36
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'N'#186' Documento:'
        end
        object Label9: TLabel
          Left = 50
          Top = 117
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label10: TLabel
          Left = 13
          Top = 140
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label11: TLabel
          Left = 197
          Top = 198
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'C'#243'digo Cidade:'
        end
        object spdPesquisaCidade: TSpeedButton
          Left = 339
          Top = 194
          Width = 23
          Height = 22
          Hint = 'Clique aqui para Pesquisar'
          Caption = '...'
          OnClick = spdPesquisaCidadeClick
        end
        object Label13: TLabel
          Left = 36
          Top = 198
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Telefone:'
        end
        object pnlCadastro: TPanel
          Left = 1
          Top = 1
          Width = 662
          Height = 27
          Align = alTop
          Alignment = taLeftJustify
          BevelKind = bkSoft
          BevelOuter = bvLowered
          Caption = '  Cadastro de Cliente (EDITAR)'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 10
        end
        object edtCodigo: TEdit
          Left = 88
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
          Left = 88
          Top = 59
          Width = 433
          Height = 21
          MaxLength = 100
          TabOrder = 2
        end
        object edtEmail: TEdit
          Left = 88
          Top = 167
          Width = 433
          Height = 21
          MaxLength = 100
          TabOrder = 6
          Text = 'Edit1'
        end
        object edtCep: TEdit
          Left = 400
          Top = 194
          Width = 121
          Height = 21
          MaxLength = 9
          TabOrder = 9
          OnChange = edtCepChange
          OnExit = edtCepExit
          OnKeyPress = edtCepKeyPress
        end
        object edtDocumento: TEdit
          Left = 222
          Top = 32
          Width = 177
          Height = 21
          MaxLength = 14
          TabOrder = 1
          OnExit = edtDocumentoExit
          OnKeyPress = edtCepKeyPress
        end
        object edtEndereco: TEdit
          Left = 88
          Top = 86
          Width = 433
          Height = 21
          MaxLength = 100
          TabOrder = 3
        end
        object edtBairro: TEdit
          Left = 88
          Top = 113
          Width = 433
          Height = 21
          MaxLength = 100
          TabOrder = 4
        end
        object edtComplemento: TEdit
          Left = 88
          Top = 140
          Width = 433
          Height = 21
          MaxLength = 100
          TabOrder = 5
        end
        object edtCodigoCidade: TEdit
          Left = 276
          Top = 194
          Width = 57
          Height = 21
          TabOrder = 8
          OnExit = edtCodigoCidadeExit
        end
        object edtTelefone: TEdit
          Left = 88
          Top = 194
          Width = 102
          Height = 21
          MaxLength = 15
          TabOrder = 7
          OnChange = edtTelefoneChange
          OnKeyPress = edtCepKeyPress
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 406
        Width = 664
        Height = 40
        Align = alBottom
        ParentBackground = False
        TabOrder = 1
        object btnCancelar: TBitBtn
          AlignWithMargins = True
          Left = 580
          Top = 4
          Width = 80
          Height = 32
          Align = alRight
          Caption = 'Cancelar'
          TabOrder = 1
          TabStop = False
          OnClick = btnCancelarClick
        end
        object btnGravar: TBitBtn
          AlignWithMargins = True
          Left = 494
          Top = 4
          Width = 80
          Height = 32
          Align = alRight
          Caption = 'Gravar'
          TabOrder = 0
          OnClick = btnGravarClick
        end
      end
      object pnlPesquisaCid: TPanel
        Left = 188
        Top = 222
        Width = 468
        Height = 177
        TabOrder = 2
        Visible = False
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 466
          Height = 27
          Align = alTop
          Alignment = taLeftJustify
          BevelKind = bkSoft
          BevelOuter = bvLowered
          Caption = '  Pesquisando Cidades (Duplo Clique na Grade para Escolher)'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object spdSair: TSpeedButton
            Left = 439
            Top = 0
            Width = 23
            Height = 22
            Hint = 'Clique aqui para Fechar'
            Caption = 'X'
            Flat = True
            OnClick = spdSairClick
          end
        end
        object dbGridfConsulta2: TDBGrid
          Left = 1
          Top = 59
          Width = 466
          Height = 117
          Align = alClient
          DataSource = dsConsulta2
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = dbGridfConsulta2DblClick
        end
        object Panel6: TPanel
          Left = 1
          Top = 28
          Width = 466
          Height = 31
          Align = alTop
          ParentBackground = False
          TabOrder = 2
          DesignSize = (
            466
            31)
          object Label12: TLabel
            Left = 7
            Top = 8
            Width = 31
            Height = 13
            Caption = 'Nome:'
          end
          object btnConsultarCid: TBitBtn
            AlignWithMargins = True
            Left = 382
            Top = 4
            Width = 80
            Height = 23
            Align = alRight
            Caption = 'Consultar'
            TabOrder = 0
            OnClick = btnConsultarCidClick
          end
          object edtPesquisaCid: TEdit
            Left = 44
            Top = 4
            Width = 332
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
            TextHint = 'Digite aqui para pesquisar'
          end
        end
      end
    end
  end
  object fdConsulta: TFDQuery
    Connection = DM.Conexao
    SQL.Strings = (
      'select * from Clientes')
    Left = 444
    object fdConsultaCodigo_Cliente: TFDAutoIncField
      FieldName = 'Codigo_Cliente'
      Origin = 'Codigo_Cliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdConsultaCGC_CPF_Cliente: TStringField
      FieldName = 'CGC_CPF_Cliente'
      Origin = 'CGC_CPF_Cliente'
      Required = True
      Size = 14
    end
    object fdConsultaNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 100
    end
    object fdConsultaTelefone: TStringField
      FieldName = 'Telefone'
      Origin = 'Telefone'
      Size = 15
    end
    object fdConsultaEndereco: TStringField
      FieldName = 'Endereco'
      Origin = 'Endereco'
      Required = True
      Size = 200
    end
    object fdConsultaBairro: TStringField
      FieldName = 'Bairro'
      Origin = 'Bairro'
      Required = True
      Size = 100
    end
    object fdConsultaComplemento: TStringField
      FieldName = 'Complemento'
      Origin = 'Complemento'
      Size = 100
    end
    object fdConsultaE_mail: TStringField
      FieldName = 'E_mail'
      Origin = 'E_mail'
      Size = 100
    end
    object fdConsultaCodigo_Cidade: TIntegerField
      FieldName = 'Codigo_Cidade'
      Origin = 'Codigo_Cidade'
      Required = True
    end
    object fdConsultaCep: TStringField
      FieldName = 'Cep'
      Origin = 'Cep'
      Required = True
      FixedChar = True
      Size = 8
    end
  end
  object dsConsulta: TDataSource
    DataSet = fdConsulta
    Left = 472
  end
  object fdConsulta2: TFDQuery
    Connection = DM.Conexao
    SQL.Strings = (
      'select * from Cidades')
    Left = 540
    object fdConsulta2Codigo_Cidade: TFDAutoIncField
      FieldName = 'Codigo_Cidade'
      Origin = 'Codigo_Cidade'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdConsulta2Nome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 100
    end
    object fdConsulta2Estado: TStringField
      FieldName = 'Estado'
      Origin = 'Estado'
      Required = True
      FixedChar = True
      Size = 2
    end
    object fdConsulta2Cep_Inicial: TStringField
      FieldName = 'Cep_Inicial'
      Origin = 'Cep_Inicial'
      Required = True
      FixedChar = True
      Size = 8
    end
    object fdConsulta2Cep_Final: TStringField
      FieldName = 'Cep_Final'
      Origin = 'Cep_Final'
      Required = True
      FixedChar = True
      Size = 8
    end
  end
  object dsConsulta2: TDataSource
    DataSet = fdConsulta2
    Left = 568
  end
end
