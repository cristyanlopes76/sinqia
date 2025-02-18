object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 671
  Width = 1066
  object Conexao: TFDConnection
    Params.Strings = (
      'Server=DESKTOP-ACBC9GS\SQLEXPRESS'
      'OSAuthent=Yes'
      'ConnectionDef=DBDados')
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object fdExcluir: TFDQuery
    Connection = Conexao
    Left = 88
    Top = 16
    object fdExcluirproximo: TIntegerField
      FieldName = 'proximo'
      Origin = 'proximo'
      ReadOnly = True
    end
  end
  object fdProximo: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select Max(Codigo_Cidade)+1 as proximo from Cidades')
    Left = 24
    Top = 72
    object fdProximoproximo: TIntegerField
      FieldName = 'proximo'
      Origin = 'proximo'
      ReadOnly = True
    end
  end
  object fdGravar: TFDQuery
    Connection = Conexao
    Left = 88
    Top = 72
  end
  object FDQuery1: TFDQuery
    Connection = Conexao
    Left = 144
    Top = 16
  end
  object fdRelatorio: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      
        'SELECT Cli.Codigo_Cliente, Cli.Nome, Cli.Codigo_Cidade, CID.Nome' +
        ' as Cidade, CID.Estado '
      'FROM Clientes Cli'
      'INNER JOIN Cidades CID ON CID.Codigo_Cidade = Cli.Codigo_Cidade')
    Left = 144
    Top = 72
    object fdRelatorioCodigo_Cliente: TFDAutoIncField
      FieldName = 'Codigo_Cliente'
      Origin = 'Codigo_Cliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdRelatorioNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 100
    end
    object fdRelatorioCodigo_Cidade: TIntegerField
      FieldName = 'Codigo_Cidade'
      Origin = 'Codigo_Cidade'
      Required = True
    end
    object fdRelatorioCidade: TStringField
      FieldName = 'Cidade'
      Origin = 'Cidade'
      Required = True
      Size = 100
    end
    object fdRelatorioEstado: TStringField
      FieldName = 'Estado'
      Origin = 'Estado'
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  object dsRelatorio: TDataSource
    DataSet = fdRelatorio
    Left = 176
    Top = 72
  end
end
