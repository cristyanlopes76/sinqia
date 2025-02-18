unit uRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  ppBands, ppCache, ppClass, ppDesignLayer, ppParameter, ppComm, ppRelatv,
  ppProd, ppReport, ppDB, ppDBPipe, ppCtrls, ppPrnabl, ppTypes, ppForms, ppViewr;

type
  TfrmRelatorio = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnImprimir: TBitBtn;
    btnSair: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    edtClienteIni: TEdit;
    edtClienteFim: TEdit;
    Label2: TLabel;
    cboEstado: TComboBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    edtCidadeIni: TEdit;
    edtCidadeFim: TEdit;
    rbRelatorioGrupo: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBRelatorio: TppDBPipeline;
    ppLabel1: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    chkAgruparCid: TCheckBox;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLine2: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    rbRelatorioSimples: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel5: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppLine3: TppLine;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLine5: TppLine;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    procedure btnImprimirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure rbRelatorioGrupoPreviewFormCreate(Sender: TObject);
    procedure rbRelatorioSimplesPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

uses uDM, syslib;

{$R *.dfm}

procedure TfrmRelatorio.btnImprimirClick(Sender: TObject);
var vEstado: String;
begin
  vEstado := '';
  if cboEstado.Text <> 'NENHUM' then
    vEstado := cboEstado.Text;

  with dm.fdRelatorio do
  begin
    Close;
    SQL.Clear;

    SQL.Add('SELECT Cli.Codigo_Cliente, Cli.Nome, Cli.Codigo_Cidade, CID.Nome as Cidade, CID.Estado ' +
            'FROM Clientes Cli ' +
            'INNER JOIN Cidades CID ON CID.Codigo_Cidade = Cli.Codigo_Cidade ' +
            'WHERE (:Codigo_Cliente_Inicial = 0 OR Cli.Codigo_Cliente >= :Codigo_Cliente_Inicial) ' +
            '  AND (:Codigo_Cliente_Final = 0 OR Cli.Codigo_Cliente <= :Codigo_Cliente_Final) ' +
            '  AND (:Codigo_Cidade_Inicial = 0 OR Cli.Codigo_Cidade >= :Codigo_Cidade_Inicial) ' +
            '  AND (:Codigo_Cidade_Final = 0 OR Cli.Codigo_Cidade <= :Codigo_Cidade_Final) ' +
            '  AND (:Estado = '''' OR CID.Estado = :Estado) ' +
            'ORDER BY CID.Nome, Cli.Nome; ');
    ParamByName('Codigo_Cliente_Inicial').AsInteger := StrToIntDef(edtClienteIni.Text, 0);
    ParamByName('Codigo_Cliente_Final').AsInteger := StrToIntDef(edtClienteFim.Text, 0);
    ParamByName('Codigo_Cidade_Inicial').AsInteger := StrToIntDef(edtCidadeIni.Text, 0);
    ParamByName('Codigo_Cidade_Final').AsInteger := StrToIntDef(edtCidadeFim.Text, 0);
    ParamByName('Estado').AsString := vEstado;
    Open;
  end;
  if chkAgruparCid.Checked then
    rbRelatorioGrupo.Print
  else
    rbRelatorioSimples.Print;
end;

procedure TfrmRelatorio.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorio.rbRelatorioGrupoPreviewFormCreate(Sender: TObject);
begin
  TppViewer(rbRelatorioGrupo.PreviewForm.Viewer).ZoomSetting := zsWholePage;
  rbRelatorioGrupo.PreviewForm.WindowState := wsMaximized;
end;

procedure TfrmRelatorio.rbRelatorioSimplesPreviewFormCreate(Sender: TObject);
begin
  TppViewer(rbRelatorioSimples.PreviewForm.Viewer).ZoomSetting := zsWholePage;
  rbRelatorioSimples.PreviewForm.WindowState := wsMaximized;
end;

end.
