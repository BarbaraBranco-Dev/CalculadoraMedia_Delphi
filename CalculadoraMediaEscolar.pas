unit CalculadoraMediaEscolar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList;

type
  TForm1 = class(TForm)
    edtNota1: TEdit;
    edtNota2: TEdit;
    edtNota3: TEdit;
    btnCalcMedia: TButton;
    lblNota1: TLabel;
    lblNota2: TLabel;
    lblNota3: TLabel;
    lblInformativo: TLabel;
    lblNome: TLabel;
    edtNome: TEdit;
    lblMediaFinal: TLabel;
    mmInformacao: TMemo;
    ImageList1: TImageList;
    lblResultado: TLabel;
    procedure edtNota1Change(Sender: TObject);
    procedure edtNota2Change(Sender: TObject);
    procedure edtNota3Change(Sender: TObject);
    procedure btnCalcMediaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNomeExit(Sender: TObject);
    procedure edtNota1Exit(Sender: TObject);
    procedure edtNota2Exit(Sender: TObject);
    procedure edtNota3Exit(Sender: TObject);

  private
    function ValidarEditFaixa(pEdit: TEdit; pMin, pMax: Double): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function Tform1.ValidarEditFaixa(pEdit: TEdit; pMin, pMax: Double): Boolean;
var
  Valor: Double;
  Texto: String;
  PosVirgula: Integer;
begin
  Result := False;

  Texto := Trim(pEdit.Text);

  if Texto = '' then
  begin
    ShowMessage('O campo n�o pode ficar vazio.');
    pEdit.SetFocus;
    Exit;
  end;

  // Substitui ponto por v�rgula para aceitar os dois
  Texto := StringReplace(Texto, '.', ',', [rfReplaceAll]);

  // Tenta converter para n�mero
  if not TryStrToFloat(Texto, Valor) then
  begin
    ShowMessage('Digite apenas n�meros v�lidos (ex: 7,5 ou 8.25).');
    pEdit.SetFocus;
    Exit;
  end;

  // Verifica se est� dentro da faixa
  if (Valor < pMin) or (Valor > pMax) then
  begin
    ShowMessage('O valor deve estar entre ' + FormatFloat('0.00', pMin) + ' e ' + FormatFloat('0.00', pMax) + '.');
    pEdit.SetFocus;
    Exit;
  end;

  // Verifica se tem no m�ximo duas casas decimais
  PosVirgula := Pos(',', Texto);
  if (PosVirgula > 0) and (Length(Texto) - PosVirgula > 2) then
  begin
    ShowMessage('S� s�o permitidas duas casas decimais.');
    pEdit.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TForm1.edtNomeExit(Sender: TObject);
begin
 if (edtNome.Text = '')then
    begin
     ShowMessage('Nome n�o pode ser Nulo');
    Abort;
    end;
end;

procedure TForm1.edtNota1Change(Sender: TObject);
begin
  ValidarEditFaixa(edtNota1, 0, 10);
end;

procedure TForm1.edtNota1Exit(Sender: TObject);
begin
  ValidarEditFaixa(edtNota1, 0, 10);
end;

procedure TForm1.edtNota2Change(Sender: TObject);
begin
  ValidarEditFaixa(edtNota2, 0, 10);
end;

procedure TForm1.edtNota2Exit(Sender: TObject);
begin
  ValidarEditFaixa(edtNota2, 0, 10);
end;

procedure TForm1.edtNota3Change(Sender: TObject);
begin
  ValidarEditFaixa(edtNota3, 0, 10);
end;

procedure TForm1.edtNota3Exit(Sender: TObject);
begin
  ValidarEditFaixa(edtNota3, 0, 10);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0; // evita beep
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TForm1.btnCalcMediaClick(Sender: TObject);
var
  Nota1, Nota2, Nota3, Media: Double;
  Nome: string;
begin

  // Converter os textos para valores num�ricos
  TryStrToFloat(StringReplace(edtNota1.Text, '.', ',', [rfReplaceAll]), Nota1);
  TryStrToFloat(StringReplace(edtNota2.Text, '.', ',', [rfReplaceAll]), Nota2);
  TryStrToFloat(StringReplace(edtNota3.Text, '.', ',', [rfReplaceAll]), Nota3);

  // Calcular m�dia
  Media := (Nota1 + Nota2 + Nota3) / 3;

  // Pegar o nome do aluno
  Nome := edtNome.Text;

  // Exibir o resultado
  lblMediaFinal.Visible := True;  //deixar visivel assim que calcular m�dia
  lblMediaFinal.Caption := Nome + ' ficou com seguinte m�dia: ' + FormatFloat('0.00', Media);

  lblResultado.Visible := True;
  if Media < 5.0 then
  begin
    lblResultado.Caption := 'REPROVADO';
    lblResultado.Font.Color := clRed;
  end
  else
    if (Media >= 5.0) and (Media <= 6.9 ) then
    begin
      lblResultado.Caption := 'RECUPERA��O';
      lblResultado.Font.Color := clPurple;
    end
    else
    begin
      lblResultado.Caption := 'APROVADO';
      lblResultado.Font.Color := clGreen;
    end;
end;

end.




