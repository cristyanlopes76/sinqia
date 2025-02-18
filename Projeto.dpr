program Projeto;

uses
  Vcl.Forms,
  uProjeto in 'uProjeto.pas' {frmProjeto},
  uCidades in 'uCidades.pas' {frmCidades},
  uClientes in 'uClientes.pas' {frmClientes},
  uRelatorio in 'uRelatorio.pas' {frmRelatorio},
  uDM in 'uDM.pas' {DM: TDataModule},
  syslib in 'syslib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProjeto, frmProjeto);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
