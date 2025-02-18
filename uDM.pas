unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    fdExcluir: TFDQuery;
    fdExcluirproximo: TIntegerField;
    fdProximo: TFDQuery;
    fdProximoproximo: TIntegerField;
    fdGravar: TFDQuery;
    FDQuery1: TFDQuery;
    fdRelatorio: TFDQuery;
    fdRelatorioCodigo_Cliente: TFDAutoIncField;
    fdRelatorioNome: TStringField;
    fdRelatorioCodigo_Cidade: TIntegerField;
    fdRelatorioCidade: TStringField;
    fdRelatorioEstado: TStringField;
    dsRelatorio: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fModo: (mdInserir, mdEditar, mdConsultar);

    function ExcluirRegistro(pTabela, pCampo: String; pCodigo: Integer): Boolean;
    function PegaProximoNumero(pTabela, pCampo: String): String;
    function SalvarDadosCidade(pCodigo: Integer; pNome, pEstado, pCepIni, pCepFim: String): Boolean;
    function SalvarDadosClientes(pCodigo: Integer; pDocumento, pNome, pTelefone, pEndereco, pBairro, pComplemento, pMail, pCodCidade, pCep: String): Boolean;
    function ValidarCepCliente(pCodCidade: Integer; pCep: String): Boolean;
    function ValidarCodigoCidade(pCodCidade: Integer): Boolean;
  end;

var
  DM: TDM;

implementation

uses syslib;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    DM.Conexao.Connected := True;
    // ShowMessage('Conectado com sucesso!');
  except
    on E: Exception do
      MessageBox(0, PChar('Erro na conexão: ' + E.Message), 'Erro', MB_OK or MB_ICONERROR);
  end;
end;

function TDM.ExcluirRegistro(pTabela, pCampo: String; pCodigo: Integer): Boolean;
begin
  if MessageBox(0, PChar('Deseja excluir o registro ' + IntToStr(pCodigo) + '?'), 'Confirmação', MB_YESNO or MB_ICONQUESTION) = IDYES then
  begin
    with fdExcluir do
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM ' + pTabela + ' WHERE ' + pCampo + ' = :Codigo');
      ParamByName('Codigo').AsInteger := pCodigo;

      try
        ExecSQL;
        MessageBox(0, 'Registro excluído com sucesso!', 'Sucesso', MB_OK or MB_ICONINFORMATION);
        Result := True;
      except
        on E: Exception do
        begin
          MessageBox(0, PChar('Erro ao excluir registro: ' + E.Message), 'Erro', MB_OK or MB_ICONERROR);
          Result := False;
        end;
      end;
    end;
  end
  else begin
    MessageBox(0, 'Exclusão cancelada!', 'Cancelado', MB_OK or MB_ICONWARNING);
    Result := False;
  end;
end;

function TDM.PegaProximoNumero(pTabela, pCampo: String): String;
begin
  with fdProximo do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MAX(' + pCampo + ')+1 as proximo FROM ' + pTabela);

    try
      Open;
      result := FieldByName('proximo').AsString;
      Close;
    except
      on E: Exception do
        MessageBox(0, PChar('Erro ao pegar o proximo registro da tabela ' + pTabela + ': ' + E.Message), 'Erro', MB_OK or MB_ICONERROR);
    end;
  end;
end;

function TDM.SalvarDadosCidade(pCodigo: Integer; pNome, pEstado, pCepIni, pCepFim: String): Boolean;
begin
  with fdGravar do
  begin
    Close;
    if fModo = mdInserir then
    begin
      SQL.Text := 'INSERT INTO Cidades(' +
                  '  Nome, Estado, Cep_Inicial, Cep_Final' +
                  ') VALUES (' +
                  '  :Nome, :Estado, :Cep_Inicial, :Cep_Final' +
                  ')';
    end
    else begin
      SQL.Text := 'UPDATE Cidades SET ' +
                  '  Nome = :Nome, ' +
                  '  Estado = :Estado, ' +
                  '  Cep_Inicial = :Cep_Inicial, ' +
                  '  Cep_Final = :Cep_Final ' +
                  'WHERE Codigo_Cidade = :Codigo';
      ParamByName('Codigo').AsInteger := pCodigo;
    end;

    ParamByName('Nome').AsString        := pNome;
    ParamByName('Estado').AsString      := pEstado;
    ParamByName('Cep_Inicial').AsString := pCepIni;
    ParamByName('Cep_Final').AsString   := pCepFim;

    try
      ExecSQL;
      MessageBox(0, 'Registro Graavado com Sucesso!', 'Sucesso', MB_OK or MB_ICONINFORMATION);
      Result := True;
    except
      on E: Exception do
      begin
        MessageBox(0, PChar('Erro ao Gravar o Registro: ' + E.Message), 'Erro', MB_OK or MB_ICONERROR);
        Result := False;
      end;
    end;
  end;
end;

function TDM.SalvarDadosClientes(pCodigo: Integer; pDocumento, pNome, pTelefone, pEndereco, pBairro, pComplemento, pMail, pCodCidade, pCep: String): Boolean;
begin
  with fdGravar do
  begin
    Close;
    if fModo = mdInserir then
    begin
      SQL.Text := 'INSERT INTO Clientes(' +
                  '  CGC_CPF_Cliente, Nome, Telefone, Endereco, Bairro, Complemento, E_Mail, Codigo_Cidade, Cep ' +
                  ') VALUES (' +
                  '  :CGC_CPF_Cliente, :Nome, :Telefone, :Endereco, :Bairro, :Complemento, :E_Mail, :Codigo_Cidade, :Cep ' +
                  ')';
    end
    else begin
      SQL.Text := 'UPDATE Clientes SET ' +
                  '  CGC_CPF_Cliente = :CGC_CPF_Cliente, ' +
                  '  Nome = :Nome, ' +
                  '  Telefone = :Telefone, ' +
                  '  Endereco = :Endereco, ' +
                  '  Bairro = :Bairro, ' +
                  '  Complemento = :Complemento, ' +
                  '  E_Mail = :E_Mail, ' +
                  '  Codigo_Cidade = :Codigo_Cidade, ' +
                  '  Cep = :Cep ' +
                  'WHERE Codigo_Cliente = :Codigo';
      ParamByName('Codigo').AsInteger := pCodigo;
    end;

    ParamByName('CGC_CPF_Cliente').AsString := pDocumento;
    ParamByName('Nome').AsString            := pNome;
    ParamByName('Telefone').AsString        := pTelefone;
    ParamByName('Endereco').AsString        := pEndereco;
    ParamByName('Bairro').AsString          := pBairro;
    ParamByName('Complemento').AsString     := pComplemento;
    ParamByName('E_Mail').AsString          := pMail;
    ParamByName('Codigo_Cidade').AsString   := pCodCidade;
    ParamByName('Cep').AsString             := pCep;

    try
      ExecSQL;
      MessageBox(0, 'Registro Graavado com Sucesso!', 'Sucesso', MB_OK or MB_ICONINFORMATION);
      Result := True;
    except
      on E: Exception do
      begin
        MessageBox(0, PChar('Erro ao Gravar o Registro: ' + E.Message), 'Erro', MB_OK or MB_ICONERROR);
        Result := False;
      end;
    end;
  end;
end;

function TDM.ValidarCepCliente(pCodCidade: Integer; pCep: String): Boolean;
var
  vCepIni, vCepFim: string;
begin
  with FDQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT Cep_Inicial, Cep_Final FROM Cidades WHERE Codigo_Cidade = :Codigo');
    ParamByName('Codigo').AsInteger := pCodCidade;
    Open;

    if not IsEmpty then
    begin
      vCepIni := FieldByName('Cep_Inicial').AsString;
      vCepFim := FieldByName('Cep_Final').AsString;
    end
    else begin
      MessageBox(0, 'Cidade não encontrada.', 'Erro', MB_OK or MB_ICONWARNING);
      Result := False;
      Exit;
    end;
  end;

  if not ValidarCep(pCep, vCepIni, vCepFim) then
  begin
    MessageBox(0, 'CEP inválido para a cidade selecionada.', 'Erro', MB_OK or MB_ICONWARNING);
    Result := False;
  end
  else
    Result := True;
end;

function TDM.ValidarCodigoCidade(pCodCidade: Integer): Boolean;
begin
  with FDQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT Codigo_Cidade as Codigo FROM Cidades WHERE Codigo_Cidade = :Codigo');
    ParamByName('Codigo').AsInteger := pCodCidade;
    Open;

    Result := (not IsEmpty);
    Close;
  end;
end;

end.
