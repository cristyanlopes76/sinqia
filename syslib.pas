unit syslib;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

function IsDigit(Campo: String): Boolean;
function OnlyDigit(inString: String): String;
function IsCarac(Campo: String): Boolean;
function OnlyCarac(inString: String): String;
function StrZero(Texto: String; Casas: Integer): String;
function Right(inString: String; NumChars: Byte): String;
function Empty(inString: String): Boolean;
function Upper(inString: String): String;
function Replic(Qtd: Integer; carac: Char): String;

function AllTrim(Texto: String): String;
function RTrim(inString: String): String;
function LTrim(Texto: String): String;
function Len(inString: String): Integer;
function Left(inString: String; NumChars: Byte): String;

function MascaraCnpjCpfCei(vCodigo: String): String;

function ValidarCPF(vNumero: string): Boolean;
function ValidaCPF(vNumero: String): Boolean;
function ValidarCNPJ(vNumero: string): Boolean;
function ValidaCNPJ(vNumero: String): Boolean;
function ValidarCep(Cep, CepInicial, CepFinal: string): Boolean;

function FormataCep(pNumero: TEdit): String;
function FormataTelefone(pNumero: TEdit): String;
function FormataCNPJ(pNumero: TEdit): String;
function FormataCPF(pNumero: TEdit): String;

implementation

{ Retorna NumChars à esquerda de um string }
function Left(inString: String; NumChars: Byte): String;
begin
  Left := Copy(inString, 1, NumChars)
end;

{ Retorna o número de caracteres de um string }
function Len(inString: String): Integer;
begin
  Len := Length(inString);
end;

{ Remove os Espaços em branco à Esquerda da string }
function LTrim(Texto: String): String;
var
  i: Integer;
begin
  i := 0;

  while True do begin
    Inc(i);

    if i > Length(Texto) then
      break;

    if Texto[i] <> #32 then
      break;
  end;

  Result := Copy(Texto, i, Length(Texto));
end;

{ Retira espaços em branco da direita de um string }
function RTrim(inString: String): String;
var
  contador, tamanho: Integer;
begin
  contador := 1;
  tamanho  := Length(inString);

  if tamanho > 0 then begin
    while (inString[Length(inString)] = ' ') and (contador < tamanho) do begin
      Inc(contador);
      inString := Copy(inString, 1, Length(inString) - 1);
    end;
  end;

  RTrim := inString;
end;

{ Retorna uma cadeia de caracteres em caixa alta }
function Upper(inString: String): String;
var
  Index: Byte;
  Temp : String;
begin
  Temp := inString;

  for Index     := 1 to Length(inString) do
    Temp[Index] := UpCase(inString[Index]);

  Upper := Temp;
end;

{ Replica o carac qtd vezes }
function Replic(Qtd: Integer; carac: Char): String;
var
  i: Integer;
  x: String;
begin
  x := '';

  for i := 1 to Qtd do
    x   := x + carac;

  Replic := x;
end;

{ Retira todos os brancos de um string }
function AllTrim(Texto: String): String;
begin
  while Pos(' ', Texto) > 0 do
    Delete(Texto, Pos(' ', Texto), 1);

  Result := Texto;
end;

{ Retorna True se Campo estiver entre 0..9 }
function IsDigit(Campo: String): Boolean;
begin
  if Pos(Campo, '0123456789') > 0 then
    IsDigit := True
  else
    IsDigit := False;
end;

{ Retorna True se Campo estiver entre A..z }
function IsCarac(Campo: String): Boolean;
begin
  if Pos(Campo, ' ABCDEFGHIJKLMNOPQRSTUVXYWZabcdefghijklmnopqrstuvxywz') > 0 then
    IsCarac := True
  else
    IsCarac := False;
end;

{ Retorna somente digitos (0..9) de um string }
function OnlyDigit(inString: String): String;
var
  i  : Integer;
  Tmp: String;
begin
  Tmp := '';

  for i := 1 to Length(inString) do
    if IsDigit(inString[i]) then
      Tmp := Tmp + inString[i];

  OnlyDigit := Tmp;
end;

{ Retorna True se for um CGC válido }
function ValidaCNPJ(vNumero: String): Boolean;
var
  WCgcCalc: String;
  WSomaCgc, WCgcDigit: Integer;
  WSx1: ShortInt;
begin
  vNumero   := StrZero(OnlyDigit(vNumero), 14);

  // Verifica se todos os dígitos são iguais
  if (vNumero = '00000000000000') or (vNumero = '11111111111111') or
     (vNumero = '22222222222222') or (vNumero = '33333333333333') or
     (vNumero = '44444444444444') or (vNumero = '55555555555555') or
     (vNumero = '66666666666666') or (vNumero = '77777777777777') or
     (vNumero = '88888888888888') or (vNumero = '99999999999999') then
  begin
    Application.MessageBox('CNPJ inválido!', 'Atenção', mb_IconStop + MB_OK);
    result := False;
    Exit(False);
  end;

  WSomaCgc := 0;
  WCgcCalc := Copy(vNumero, 1, 12);

  for WSx1   := 1 to 4 do
    WSomaCgc := WSomaCgc + StrToInt(Copy(WCgcCalc, WSx1, 1)) * (6 - WSx1);

  for WSx1   := 1 to 8 do
    WSomaCgc := WSomaCgc + StrToInt(Copy(WCgcCalc, WSx1 + 4, 1)) * (10 - WSx1);

  WCgcDigit := 11 - WSomaCgc Mod 11;

  if WCgcDigit In [10, 11] then
    WCgcCalc := WCgcCalc + '0'
  else
    WCgcCalc := WCgcCalc + IntToStr(WCgcDigit);

  WSomaCgc := 0;

  for WSx1   := 1 to 5 do
    WSomaCgc := WSomaCgc + StrToInt(Copy(WCgcCalc, WSx1, 1)) * (7 - WSx1);

  for WSx1   := 1 to 8 do
    WSomaCgc := WSomaCgc + StrToInt(Copy(WCgcCalc, WSx1 + 5, 1)) * (10 - WSx1);

  WCgcDigit := 11 - WSomaCgc Mod 11;

  if WCgcDigit In [10, 11] then
    WCgcCalc := WCgcCalc + '0'
  else
    WCgcCalc := WCgcCalc + IntToStr(WCgcDigit);

  if vNumero <> WCgcCalc then
  begin
    Application.MessageBox('CNPJ incorreto!', 'Atenção', mb_IconStop + MB_OK);
    Result := False;
  end
  else
    Result := True;
end;

{ Retorna True se for um CPF válido }
function ValidarCPF(vNumero: string): Boolean;
var
  WCpfCalc: String;
  WSomaCpf,
    WCpfDigit: Integer;
  WSx1       : ShortInt;
begin
  vNumero  := StrZero(OnlyDigit(vNumero), 11);

  // Verifica se todos os dígitos são iguais
  if (vNumero = '00000000000') or (vNumero = '11111111111') or
     (vNumero = '22222222222') or (vNumero = '33333333333') or
     (vNumero = '44444444444') or (vNumero = '55555555555') or
     (vNumero = '66666666666') or (vNumero = '77777777777') or
     (vNumero = '88888888888') or (vNumero = '99999999999') then
  begin
    Application.MessageBox('CPF inválido!', 'Atenção', mb_IconStop + MB_OK);
    result := False;
    Exit(False);
  end;

  WSomaCpf := 0;
  WCpfCalc := Copy(vNumero, 1, 9);

  for WSx1   := 1 to 9 do
    WSomaCpf := WSomaCpf + StrToInt(Copy(WCpfCalc, WSx1, 1)) * (11 - WSx1);

  WCpfDigit := 11 - WSomaCpf Mod 11;

  if WCpfDigit In [10, 11] then
    WCpfCalc := WCpfCalc + '0'
  else
    WCpfCalc := WCpfCalc + IntToStr(WCpfDigit);

  WSomaCpf := 0;

  for WSx1   := 1 to 10 do
    WSomaCpf := WSomaCpf + StrToInt(Copy(WCpfCalc, WSx1, 1)) * (12 - WSx1);

  WCpfDigit := 11 - WSomaCpf Mod 11;

  if WCpfDigit In [10, 11] then
    WCpfCalc := WCpfCalc + '0'
  else
    WCpfCalc := WCpfCalc + IntToStr(WCpfDigit);

  if vNumero <> WCpfCalc then
  begin
    Application.MessageBox('CPF inválido!', 'Atenção', mb_IconStop + MB_OK);
    result := False;
  end
  else
    result := True;
end;

function ValidaCPF(vNumero: string): Boolean;
var
  I, Soma, Resto, Digito1, Digito2: Integer;
  Num: array[1..11] of Integer;
begin
  vNumero := AllTrim(OnlyDigit(vNumero));

  // Verifica se todos os dígitos são iguais
  if (vNumero = '00000000000') or (vNumero = '11111111111') or
     (vNumero = '22222222222') or (vNumero = '33333333333') or
     (vNumero = '44444444444') or (vNumero = '55555555555') or
     (vNumero = '66666666666') or (vNumero = '77777777777') or
     (vNumero = '88888888888') or (vNumero = '99999999999') then
  begin
    Application.MessageBox('CPF inválido!', 'Atenção', mb_IconStop + MB_OK);
    result := False;
    Exit(False);
  end;

  if Length(vNumero) <> 11 then
    Exit(False);

  for I := 1 to 11 do
    Num[I] := StrToIntDef(vNumero[I], -1);

  if (Num[1] = Num[2]) and (Num[2] = Num[3]) and (Num[3] = Num[4]) and
     (Num[4] = Num[5]) and (Num[5] = Num[6]) and (Num[6] = Num[7]) and
     (Num[7] = Num[8]) and (Num[8] = Num[9]) and (Num[9] = Num[10]) and
     (Num[10] = Num[11]) then
    Exit(False);

  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + (Num[I] * (10 - I));

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  if Digito1 <> Num[10] then
    Exit(False);

  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + (Num[I] * (11 - I));

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  Result := Digito2 = Num[11];
end;

function ValidarCNPJ(vNumero: string): Boolean;
const
  Pesos1: array[1..12] of Integer = (5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  Pesos2: array[1..13] of Integer = (6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
var
  I, Soma, Resto, Digito1, Digito2: Integer;
  Num: array[1..14] of Integer;
begin
  vNumero := AllTrim(OnlyDigit(vNumero));

  // Verifica se todos os dígitos são iguais
  if (vNumero = '00000000000000') or (vNumero = '11111111111111') or
     (vNumero = '22222222222222') or (vNumero = '33333333333333') or
     (vNumero = '44444444444444') or (vNumero = '55555555555555') or
     (vNumero = '66666666666666') or (vNumero = '77777777777777') or
     (vNumero = '88888888888888') or (vNumero = '99999999999999') then
  begin
    Application.MessageBox('CNPJ inválido!', 'Atenção', mb_IconStop + MB_OK);
    result := False;
    Exit(False);
  end;

  if Length(vNumero) <> 14 then
    Exit(False);

  for I := 1 to 14 do
    Num[I] := StrToIntDef(vNumero[I], -1);

  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + (Num[I] * Pesos1[I]);

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  if Digito1 <> Num[13] then
    Exit(False);

  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + (Num[I] * Pesos2[I]);

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  Result := Digito2 = Num[14];
end;

function MascaraCnpjCpfCei(vCodigo: String): String;
var vNumeros: String;
begin
  vNumeros := Trim(OnlyDigit(vCodigo));

  if Length(vNumeros) = 14 then // CNPJ
    Result := Copy(vNumeros, 1, 2) + '.' +
      Copy(vNumeros, 3, 3) + '.' +
      Copy(vNumeros, 6, 3) + '/' +
      Copy(vNumeros, 9, 4) + '-' +
      Copy(vNumeros, 13, 2)
  else if Length(vNumeros) = 12 then // ##.###.#####/## .. CEI
    Result := Copy(vNumeros, 1, 2) + '.' +
      Copy(vNumeros, 3, 3) + '.' +
      Copy(vNumeros, 6, 5) + '-' +
      Copy(vNumeros, 11, 2)
  else if Length(vNumeros) = 11 then // CPF
    Result := Copy(vNumeros, 1, 3) + '.' +
      Copy(vNumeros, 4, 3) + '.' +
      Copy(vNumeros, 7, 3) + '-' +
      Copy(vNumeros, 10, 2)
  else
    Result := vNumeros;
end;

{ Retorna somente digitos (A..z) de um string }
function OnlyCarac(inString: String): String;
var
  i  : Integer;
  Tmp: String;
begin
  Tmp := '';

  for i := 1 to Length(inString) do
    if (IsCarac(inString[i])) or (IsDigit(inString[i])) then
      Tmp := Tmp + inString[i]
    else
      Tmp := Tmp + ' ';

  inString := Tmp;
  Tmp      := '';

  for i := 1 to Length(inString) do
    if Pos(Copy(inString, i, 1), '0123456789') = 0 then
      Tmp := Tmp + Copy(inString, i, 1);

  Tmp       := Tmp + ' ';
  OnlyCarac := Tmp;
end;

{ Devolve um texto com zeros à esquerda com tamanho especificado }
function StrZero(Texto: String; Casas: Integer): String;
var
  Work: String;
  i   : Integer;
begin
  Work := '';

  for i := 1 to Length(Texto) do begin
    if IsDigit(Texto[i]) then
      Work := Work + Texto[i];
  end;

  StrZero := Right((Replic((Casas - Length(Work)), '0') + Work), Casas);
end;

{ Retorna NumChars à direita de um string }
function Right(inString: String; NumChars: Byte): String;
var
  Index: Byte;
begin
  if NumChars >= Length(inString) then
    Right := inString
  else begin
    Index := Length(inString) - NumChars + 1;
    Right := Copy(inString, Index, NumChars)
  end;
end;

{ Verifica se um string está vazio }
function Empty(inString: String): Boolean;
var
  Index: Byte;
begin
  Index := 1;
  Empty := True;

  if Length(inString) > 0 then begin
    while (Index <= Length(inString)) and (Index <> 0) do begin
      if inString[Index] = ' ' then
        Inc(Index)
      else begin
        Empty := False;
        Index := 0;
      end;
    end;
  end;
end;

function ValidarCep(Cep, CepInicial, CepFinal: string): Boolean;
begin
  Cep := StringReplace(Cep, '-', '', [rfReplaceAll]);
  Cep := StringReplace(Cep, ' ', '', [rfReplaceAll]);

  Result := (StrToIntDef(Cep, 0) >= StrToIntDef(CepInicial, 0)) and
            (StrToIntDef(Cep, 0) <= StrToIntDef(CepFinal, 0));
end;

function FormataCep(pNumero: TEdit): String;
var
  Texto: string;
begin
  Texto := pNumero.Text;

  // Remove caracteres não numéricos
  Texto := AllTrim(OnlyDigit(Texto));

  // Aplica a máscara
  if Length(Texto) > 5 then
    Texto := Copy(Texto, 1, 5) + '-' + Copy(Texto, 6, 3);

  // Atualiza o texto do Edit
  pNumero.Text := Texto;

  // Move o cursor para o final
  pNumero.SelStart := Length(pNumero.Text);
end;

function FormataTelefone(pNumero: TEdit): String;
var
  Texto: string;
begin
  Texto := pNumero.Text;

  // Remove caracteres não numéricos
  Texto := AllTrim(OnlyDigit(Texto));

  // Aplica a máscara
  if Length(Texto) > 0 then
  begin
    Texto := '(' + Copy(Texto, 1, 2) + ') ' + Copy(Texto, 3, 5) + '-' + Copy(Texto, 8, 4);
  end;

  // Atualiza o texto do Edit
  pNumero.Text := Texto;

  // Move o cursor para o final
  pNumero.SelStart := Length(pNumero.Text);
end;

function FormataCNPJ(pNumero: TEdit): String;
var
  Texto: string;
begin
  Texto := pNumero.Text;

  // Remove caracteres não numéricos
  Texto := AllTrim(OnlyDigit(Texto));

  // Aplica a máscara
  if Length(Texto) > 0 then
  begin
    Texto := Copy(Texto, 1, 2) + '.' + Copy(Texto, 3, 3) + '.' + Copy(Texto, 6, 3) + '/' + Copy(Texto, 9, 4) + '-' + Copy(Texto, 13, 2);
  end;

  // Atualiza o texto do Edit
  pNumero.Text := Texto;

  // Move o cursor para o final
  pNumero.SelStart := Length(pNumero.Text);
end;

function FormataCPF(pNumero: TEdit): String;
var
  Texto: string;
begin
  Texto := pNumero.Text;

  // Remove caracteres não numéricos
  Texto := AllTrim(OnlyDigit(Texto));

  // Aplica a máscara
  if Length(Texto) > 0 then
  begin
    Texto := Copy(Texto, 1, 3) + '.' + Copy(Texto, 4, 3) + '.' + Copy(Texto, 7, 3) + '-' + Copy(Texto, 10, 2);
  end;

  // Atualiza o texto do Edit
  pNumero.Text := Texto;

  // Move o cursor para o final
  pNumero.SelStart := Length(pNumero.Text);
end;

end.
