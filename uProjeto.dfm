object frmProjeto: TfrmProjeto
  Left = 0
  Top = 0
  Caption = 'Projeto Teste'
  ClientHeight = 631
  ClientWidth = 1054
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poDesktopCenter
  ShowHint = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 520
    Top = 320
    object Clientes1: TMenuItem
      Caption = 'Clientes'
      OnClick = Clientes1Click
    end
    object Cidades1: TMenuItem
      Caption = 'Cidades'
      OnClick = Cidades1Click
    end
    object Relatorio1: TMenuItem
      Caption = 'Relat'#243'rio'
      OnClick = Relatorio1Click
    end
  end
end
