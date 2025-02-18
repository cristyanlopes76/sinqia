unit uProjeto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Phys.MSSQL,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmProjeto = class(TForm)
    MainMenu1: TMainMenu;
    Clientes1: TMenuItem;
    Cidades1: TMenuItem;
    Relatorio1: TMenuItem;
    procedure Clientes1Click(Sender: TObject);
    procedure Cidades1Click(Sender: TObject);
    procedure Relatorio1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProjeto: TfrmProjeto;

implementation

uses uDM, uCidades, uClientes, uRelatorio;

{$R *.dfm}

procedure TfrmProjeto.Cidades1Click(Sender: TObject);
var
  Form: TFrmCidades;
begin
  Form := TFrmCidades.Create(Application);

  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure TfrmProjeto.Clientes1Click(Sender: TObject);
var
  Form: TFrmClientes;
begin
  Form := TFrmClientes.Create(Application);

  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure TfrmProjeto.Relatorio1Click(Sender: TObject);
var
  Form: TFrmRelatorio;
begin
  Form := TFrmRelatorio.Create(Application);

  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

end.
