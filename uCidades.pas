unit uCidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCidades = class(TForm)
    pagPrincipal: TPageControl;
    tabConsulta: TTabSheet;
    tabCadastro: TTabSheet;
    Panel2: TPanel;
    dbGridConsulta: TDBGrid;
    dsConsulta: TDataSource;
    Label1: TLabel;
    edtPesquisa: TEdit;
    btnConsultar: TBitBtn;
    cboPesquisa: TComboBox;
    Label2: TLabel;
    fdConsulta: TFDQuery;
    fdConsultaCodigo_Cidade: TFDAutoIncField;
    fdConsultaNome: TStringField;
    fdConsultaEstado: TStringField;
    fdConsultaCep_Inicial: TStringField;
    fdConsultaCep_Final: TStringField;
    Panel3: TPanel;
    pnlCadastro: TPanel;
    Panel7: TPanel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    Label4: TLabel;
    edtCepInicial: TEdit;
    Label5: TLabel;
    cboEstado: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    edtCepFinal: TEdit;
    Panel1: TPanel;
    btnSair: TBitBtn;
    btnExcluir: TBitBtn;
    btnEditar: TBitBtn;
    btnNovo: TBitBtn;
    Panel4: TPanel;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCepInicialKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepFinalChange(Sender: TObject);
    procedure edtCepInicialChange(Sender: TObject);
  private
    procedure LimparCadastro;
    procedure PreencherCadastro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCidades: TfrmCidades;

implementation

uses uDM, syslib;

{$R *.dfm}

procedure TfrmCidades.btnNovoClick(Sender: TObject);
begin
  pagPrincipal.ActivePage := tabCadastro;
  pnlCadastro.Caption := 'Cadastro de Clidade (NOVO)';
  LimparCadastro;
  edtCodigo.Text := dm.PegaProximoNumero('CIDADES', 'CODIGO_CIDADE');
  dm.fModo := mdInserir;
  edtNome.SetFocus;
end;

procedure TfrmCidades.btnExcluirClick(Sender: TObject);
begin
  LimparCadastro;
  dm.ExcluirRegistro('CIDADES', 'CODIGO_CIDADE', fdConsulta.FieldByName('CODIGO_CIDADE').AsInteger);
  btnConsultar.Click;
end;

procedure TfrmCidades.btnEditarClick(Sender: TObject);
begin
  if fdConsulta.FieldByName('Codigo_Cidade').AsString = EmptyStr then
  begin
    MessageBox(0, 'Necessário escolher um registro!', 'Alerta', MB_OK or MB_ICONWARNING);
    Exit;
  end;

  pagPrincipal.ActivePage := tabCadastro;
  PreencherCadastro;
  dm.fModo := mdEditar;
  edtNome.SetFocus;
end;

procedure TfrmCidades.btnCancelarClick(Sender: TObject);
begin
  dm.fModo := mdConsultar;
  LimparCadastro;
  pagPrincipal.ActivePage := tabConsulta;
end;

procedure TfrmCidades.btnConsultarClick(Sender: TObject);
var vSQL, vWhere: String;
begin
  vSQL   := 'SELECT * FROM Cidades ';
  vWhere := '';

  if (edtPesquisa.Text <> EmptyStr) then
  begin
    vWhere := 'WHERE ' + cboPesquisa.Text + ' like ''%' + edtPesquisa.Text + '%'' ';
  end;

  fdConsulta.Close;
  fdConsulta.SQL.Clear;
  fdConsulta.SQL.Add(vSQL + vWhere + ' ORDER BY ' + cboPesquisa.Text);
  fdConsulta.Open;
end;

procedure TfrmCidades.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCidades.edtCepFinalChange(Sender: TObject);
begin
  FormataCep(edtCepFinal);
end;

procedure TfrmCidades.edtCepInicialChange(Sender: TObject);
begin
  FormataCep(edtCepInicial);
end;

procedure TfrmCidades.edtCepInicialKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then // Permite apenas números e Backspace
    Key := #0;
end;

procedure TfrmCidades.FormShow(Sender: TObject);
begin
  tabCadastro.TabVisible := False;
  tabConsulta.TabVisible := False;
  pagPrincipal.ActivePage := tabConsulta;

  btnConsultar.Click;
end;

procedure TfrmCidades.LimparCadastro;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  cboEstado.ItemIndex := -1;
  edtCepInicial.Clear;
  edtCepFinal.Clear;
end;

procedure TfrmCidades.PreencherCadastro;
begin
  if fdConsulta.FieldByName('Codigo_Cidade').AsString = EmptyStr then
    Exit;

  edtCodigo.Text      := fdConsulta.FieldByName('Codigo_Cidade').AsString;
  edtNome.Text        := fdConsulta.FieldByName('nome').AsString;
  cboEstado.ItemIndex := cboEstado.Items.IndexOf(fdConsulta.FieldByName('Estado').AsString);
  edtCepInicial.Text  := fdConsulta.FieldByName('Cep_inicial').AsString;
  edtCepFinal.Text    := fdConsulta.FieldByName('Cep_final').AsString;
end;

procedure TfrmCidades.btnGravarClick(Sender: TObject);
begin
  if Trim(edtNome.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Nome!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtNome.SetFocus;
    Exit;
  end;

  if cboEstado.ItemIndex = -1 then
  begin
    MessageBox(0, 'Informe um Estado!', 'Alerta', MB_OK or MB_ICONWARNING);
    cboEstado.SetFocus;
    Exit;
  end;

  if Trim(edtCepInicial.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Cep Inicial!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCepInicial.SetFocus;
    Exit;
  end;

  if Trim(edtCepFinal.Text) = EmptyStr then
  begin
    MessageBox(0, 'Informe um Cep Final!', 'Alerta', MB_OK or MB_ICONWARNING);
    edtCepFinal.SetFocus;
    Exit;
  end;

  if DM.SalvarDadosCidade(
    StrtoInt(edtCodigo.Text),
    edtNome.Text,
    cboEstado.Text,
    OnlyDigit(edtCepInicial.Text),
    OnlyDigit(edtCepFinal.Text)
    ) then
  begin
    btnConsultar.Click;
    pagPrincipal.ActivePage := tabConsulta;
  end;
end;

end.
