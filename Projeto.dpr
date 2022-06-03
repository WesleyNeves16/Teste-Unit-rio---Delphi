program Projeto;

uses
  Vcl.Forms,
  Projeto.Principal in 'Projeto.Principal.pas' {Form4},
  Pessoa in 'Pessoa.pas',
  PessoaDAO in 'PessoaDAO.pas',
  Conexao in 'Conexao.pas' {DmDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
