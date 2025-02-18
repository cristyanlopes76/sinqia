unit uClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmClientes = class(TForm)
    pagPrincipal: TPageControl;
    tabConsulta: TTabSheet;
    Panel2: TPanel;
    cboPesquisa: TComboBox;
    dbGridConsulta: TDBGrid;
    tabCadastro: TTabSheet;
    pnlCadastrar: TPanel;
    fdConsulta: TFDQuery;
    dsConsulta: TDataSource;
    fdConsultaCodigo_Cliente: TFDAutoIncField;
    fdConsultaCGC_CPF_Cliente: TStringField;
    fdConsultaNome: TStringField;
    fdConsultaTelefone: TStringField;
    fdConsultaEndereco: TStringField;
    fdConsultaBairro: TStringField;
    fdConsultaComplemento: TStringField;
    fdConsultaE_mail: TStringField;
    fdConsultaCodigo_Cidade: TIntegerField;
    fdConsultaCep: TStringField;
    Panel7: TPanel;
    pnlCadastro: TPanel;
    btnConsultar: TBitBtn;
    Label1: TLabel;
    edtPesquisa: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    Label4: TLabel;
    edtEmail: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtCep: TEdit;
    Panel4: TPanel;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    Panel1: TPanel;
    btnSair: TBitBtn;
    btnExcluir: TBitBtn;
    btnEditar: TBitBtn;
    btnNovo: TBitBtn;
    Label8: TLabel;
    edtDocumento: TEdit;
    edtEndereco: TEdit;
    Label9: TLabel;
    edtBairro: TEdit;
    Label10: TLabel;
    edtComplemento: TEdit;
    edtCodigoCidade: TEdit;
    Label11: TLabel;
    spdPesquisaCidade: TSpeedButton;
    pnlPesquisaCid: TPanel;
    Panel5: TPanel;
    dbGridfConsulta2: TDBGrid;
    Panel6: TPanel;
    btnConsultarCid: TBitBtn;
    edtPesquisaCid: TEdit;
    Label12: TLabel;
    spdSair: TSpeedButton;
    fdConsulta2: TFDQuery;
    dsConsulta2: TDataSource;
    Label13: TLabel;
    edtTelefone: TEdit;
    fdConsulta2Codigo_Cidade: TFDAutoIncField;
    fdConsulta2Nome: TStringField;
    fdConsulta2Estado: TStringField;
    fdConsulta2Cep_Inicial: TStringField;
    fdConsulta2Cep_Final: TStringField;
    procedure btnSairClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure spdPesquisaCidadeClick(Sender: TObject);
    procedure spdSairClick(Sender: TObject);
    procedure dbGridfConsulta2DblClick(Sender: TObject);
    procedure btnConsultarCidClick(Sender: TObject);
    procedure edtCepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepChange(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure edtCodigoCidadeExit(Sender: TObject);
    procedure edtDocumentoExit(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCadastro;
    procedure PreencherCadastro;
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

uses uDM, syslib;

procedure TfrmClientes.btnNovoClick(Sender: TObject);
begin
  pagPrincipal.ActivePage := tabCadastro;
  pnlCadastro.Caption := 'Cadastro de Cliente (NOVO)';
  LimparCadastro;
  edtCodigo.Text := dm.PegaProximoNumero('CLIENTES', 'CODIGO_CLIENTE');
  dm.fModo := mdInserir;
  edtDocumento.SetFocus;
end;

procedure TfrmClientes.spdPesquisaCidadeClick(Sender: TObject);
begin
  pnlCadastrar.Enabled   := False;
  pnlPesquisaCid.Visible := True;
  btnConsultarCid.Click;
  edtPesquisaCid.SetFocus;
end;

procedure TfrmClientes.btnExcluirClick(Sender: TObject);
begin
  LimparCadastro;
  dm.ExcluirRegistro('CLIENTES', 'CODIGO_CLIENTE', fdConsulta.FieldByName('CODIGO_CLIENTE').AsInteger);
  btnConsultar.Click;
end;

procedure TfrmClientes.btnEditarClick(Sender: TObject);
begin
  if fdConsulta.FieldByName('Codigo_Cliente').AsString = EmptyStr then
  begin
    MessageBox(0, 'Necessário escolher um registro!', 'Alerta', MB_OK or MB_ICONWARNING);
    Exit;
  end;

  pagPrincipal.ActivePage := tabCadastro;
  pnlCadastro.Caption := 'Cadastro de Cliente (EDITAR)';
  PreencherCadastro;
  dm.fModo := mdEditar;
  edtDocumento.SetFocus;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
  dm.fModo := mdConsultar;
  LimparCadastro;
  pagPrincipal.ActivePage := tabConsulta;
end;

procedure TfrmClientes.btnConsultarClick(Sender: TObject);
var vSQL, vWhere: String;
begin
  vSQL   := 'SELECT * FROM Clientes ';
  vWhere := '';

  if edtPesquisa.Text <> EmptyStr then
  begin
    vWhere := 'WHERE ' + cboPesquisa.Text + ' like ''%' + edtPesquisa.Text + '%'' ';
  end;

  fdConsulta.Close;
  fdConsulta.SQL.Clear;
  fdConsulta.SQL.Add(vSQL + vWhere + ' ORDER BY ' + cboPesquisa.Text);
  fdConsulta.Open;
end;

procedure TfrmClientes.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmClientes.dbGridfConsulta2DblClick(Sender: TObject);
begin
  if fdConsulta2.FieldByName('CODIGO_CIDADE').AsString <> EmptyStr then
  begin
    edtCodigoCidade.Text := fdConsulta2.FieldByName('CODIGO_CIDADE').AsString;
    spdSair.Click;
  end;
end;

procedure TfrmClientes.edtCepChange(Sender: TObject);
begin
  FormataCep(edtCep);
end;

procedure TfrmClientes.edtCepExit(Sender: TObject);
begin
  if Empty(edtCodigoCidade.Text) then
  begin
    MessageBox(0, 'O Cep informado  é necessário!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCep.SetFocus;
  end;

  if not dm.ValidarCepCliente(StrTOInt(edtCodigoCidade.Text), edtCep.Text) then
    edtCep.SetFocus;
end;

procedure TfrmClientes.edtCepKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then // Permite apenas números e Backspace
    Key := #0;
end;

procedure TfrmClientes.edtCodigoCidadeExit(Sender: TObject);
begin
  if Empty(edtCodigoCidade.Text) then
  begin
    MessageBox(0, 'O Código da Cidade é necessário!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCodigoCidade.SetFocus;
  end;

  if not dm.ValidarCodigoCidade(StrToInt(edtCodigoCidade.Text)) then
  begin
    MessageBox(0, 'O Código da Cidade não foi encontrado!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCodigoCidade.SetFocus;
  end;
end;

procedure TfrmClientes.edtDocumentoExit(Sender: TObject);
var vNumero: String;
begin
  if Trim(edtDocumento.Text) = EmptyStr then
    Exit;

  vNumero := AllTrim(OnlyDigit(edtDocumento.Text));

  if Length(vNumero) = 11  then // CPF
  begin
    if not ValidarCPF(vNumero) then
    begin
      edtDocumento.SetFocus;
      Exit;
    end;

    FormataCPF(edtDocumento);
  end
  else if Length(edtDocumento.Text) = 14  then // CNPJ
  begin
    if not ValidarCNPJ(vNumero) then
    begin
      edtDocumento.SetFocus;
      Exit;
    end;

    FormataCNPJ(edtDocumento);
  end
  else begin
    MessageBox(0, 'Numero do Documento não é CPF ou CNPJ!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtDocumento.SetFocus;
  end;
end;

procedure TfrmClientes.edtTelefoneChange(Sender: TObject);
begin
  FormataTelefone(edtTelefone);
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
  tabCadastro.TabVisible  := False;
  tabConsulta.TabVisible  := False;
  pagPrincipal.ActivePage := tabConsulta;
  btnConsultar.Click;
end;

procedure TfrmClientes.LimparCadastro;
begin
  edtCodigo.Clear;
  edtDocumento.Clear;
  edtNome.Clear;
  edtTelefone.Clear;
  edtEndereco.Clear;
  edtBairro.Clear;
  edtComplemento.Clear;
  edtEmail.Clear;
  edtCodigoCidade.Clear;
  edtCep.Clear;
end;

procedure TfrmClientes.PreencherCadastro;
begin
  edtCodigo.Text       := fdConsultaCodigo_Cliente.AsString;
  edtDocumento.Text    := fdConsultaCGC_CPF_Cliente.AsString;

  if Length(edtDocumento.Text) = 11  then // CPF
    FormataCPF(edtDocumento)
  else if Length(edtDocumento.Text) = 14  then // CNPJ
    FormataCNPJ(edtDocumento);

  edtNome.Text         := fdConsultaNome.AsString;
  edtTelefone.Text     := fdConsultaTelefone.AsString;
  edtEndereco.Text     := fdConsultaEndereco.AsString;
  edtBairro.Text       := fdConsultaBairro.AsString;
  edtComplemento.Text  := fdConsultaComplemento.AsString;
  edtEmail.Text        := fdConsultaE_mail.AsString;
  edtCodigoCidade.Text := fdConsultaCodigo_Cidade.AsString;
  edtCep.Text          := fdConsultaCep.AsString;
end;

procedure TfrmClientes.spdSairClick(Sender: TObject);
begin
  pnlCadastrar.Enabled   := True;
  pnlPesquisaCid.Visible := False;
  edtCodigoCidade.SetFocus;
end;

procedure TfrmClientes.btnGravarClick(Sender: TObject);
begin
  if Trim(edtDocumento.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Documento!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtDocumento.SetFocus;
    Exit;
  end;

  if Trim(edtNome.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Nome!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtNome.SetFocus;
    Exit;
  end;

  if Trim(edtEndereco.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Endereço!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtEndereco.SetFocus;
    Exit;
  end;

  if Trim(edtBairro.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Bairro!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtBairro.SetFocus;
    Exit;
  end;

  if Trim(edtCodigoCidade.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Código de Cidade!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCodigoCidade.SetFocus;
    Exit;
  end;

  if Trim(edtCep.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Cep!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCep.SetFocus;
    Exit;
  end;

  if DM.SalvarDadosClientes(
    StrtoInt(edtCodigo.Text),
    OnlyDigit(edtDocumento.Text),
    edtNome.Text,
    edtTelefone.Text,
    edtEndereco.Text,
    edtBairro.Text,
    edtComplemento.Text,
    edtEmail.Text,
    edtCodigoCidade.Text,
    OnlyDigit(edtCep.Text)
    ) then
  begin
    btnConsultar.Click;
    pagPrincipal.ActivePage := tabConsulta;
  end;
end;

procedure TfrmClientes.btnConsultarCidClick(Sender: TObject);
var vSQL, vWhere: String;
begin
  vSQL   := 'SELECT * FROM Cidades ';
  vWhere := '';

  if edtPesquisaCid.Text <> EmptyStr then
  begin
    vWhere := 'WHERE Nome like ''%' + edtPesquisaCid.Text + '%'' ';
  end;

  fdConsulta2.Close;
  fdConsulta2.SQL.Clear;
  fdConsulta2.SQL.Add(vSQL + vWhere + ' ORDER BY 2 ');
  fdConsulta2.Open;
end;

end.
