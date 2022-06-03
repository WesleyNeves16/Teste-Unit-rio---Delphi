unit ProjetoTeste.Principal;

interface
uses
  DUnitX.TestFramework, Pessoa, PessoaDAO, ActiveX;

type

  [TestFixture]
  TMyTestObject = class(TObject)
  private
      FPessoa: TPessoa;
      FPessoaDAO: TPessoaDAO;
  public
    [Setup]
    procedure Setup; //Create
    [TearDown]
    procedure TearDown; //Destroy
    [Test]
    procedure TesteTratarCPFCNPJ();

    [Test]
    [TestCase('CaseCPF', '123.123.123-12,12312312312')] //O primeiro é o valor que entra, o segundo é o valor esperado pelo retorno
    [TestCase('CaseCNPJ', '12.123.123/0001-12,12123123000112')]//Não pode ter espaço antes ou depois da vírgula
    procedure TratarCPFCNPJ(aValue: String; aResult: String);//Quando eu chamar essa procedure, ele irá executar os dois casos de cima para mim

    [Test]
    procedure ValidaNome();

    [Test]
    procedure ValidarCampos();

    [Test]
    procedure Insert();
  end;

implementation

uses
  System.SysUtils;//, Delphi.Mocks;

procedure TMyTestObject.Insert;
begin
  try
    FPessoaDAO.Entidade.GUUID := '999999';
    FPessoaDAO.Entidade.Nome := '999999';
    FPessoaDAO.Entidade.Senha := '999999';
    FPessoaDAO.Entidade.Tipo := 9;
    FPessoaDAO.Entidade.Status := 9;
    FPessoaDAO.Entidade.DataCadastro := Now();
    FPessoaDAO.Entidade.DataAlteracao := Now();
    FPessoaDAO.Insert();

    FPessoaDAO.BuscarId('999999');

    Assert.IsTrue(FPessoaDAO.Entidade.GUUID = '999999', 'TPessoaDAO.Insert: erro no inserir GUUID');
    Assert.IsTrue(FPessoaDAO.Entidade.Nome = '999999', 'TPessoaDAO.Insert: erro no inserir Nome');
    Assert.IsTrue(FPessoaDAO.Entidade.Senha = '999999', 'TPessoaDAO.Insert: erro no inserir Senha');
    Assert.IsTrue(FPessoaDAO.Entidade.Tipo = 9, 'TPessoaDAO.Insert: erro no inserir Tipo');
    Assert.IsTrue(FPessoaDAO.Entidade.Status = 9, 'TPessoaDAO.Insert: erro no inserir Status');
    Assert.IsNotNull(FPessoaDAO.Entidade.DataCadastro, 'TPessoaDAO.Insert: erro no inserir DataCadastro');
    Assert.IsNotNull(FPessoaDAO.Entidade.DataAlteracao, 'TPessoaDAO.Insert: erro no inserir DataAlteracao');
  finally
//    FPessoaDAO.Entidade.GUUID := '999999';
    FPessoaDAO.Delete();
  end;
end;

procedure TMyTestObject.Setup;
begin
  Coinitialize(0);
  FPessoa := TPessoa.Create();
  FPessoaDAO := TPessoaDAO.Create();
end;

procedure TMyTestObject.TearDown;
begin
  Fpessoa.Free();
  FPessoaDAO.Free();
end;


procedure TMyTestObject.TesteTratarCPFCNPJ;
var
  Resultado: string; //Ctrl + Shift + V -> Declara a variável automaticamente
begin
  Resultado := FPessoa.TratarCPFCNPJ('123.123.123-12');
  Assert.IsTrue(Resultado = '12312312312', 'TPessoa.TratarCPFCNPJ retornou um erro '+
    '- Esperado: 12312312312 - Resultado: '+ Resultado);//Dolphins - Sempre mostrar qual deveria ser o resultado e o que recebeu na verdade
end;

procedure TMyTestObject.TratarCPFCNPJ(aValue, aResult: String);
var
  Resultado: String;
begin
  Resultado := FPessoa.TratarCPFCNPJ(aValue);
//  Assert.IsTrue(Resultado = aResult, 'TPessoa.TratarCPFCNPJ retornou um erro '+
//    '- Esperado: '+ aResult +' - Resultado: '+ Resultado);
  Assert.AreEqual(aResult, Resultado); //Dolphins - O AreEqual já nos traz o resultado obtido e o esperado na mensagem de erro por padrão. Acho mais válido usarmos este para comparações
end;

procedure TMyTestObject.ValidaNome;
begin
  FPessoa.Nome := 'Wesley';
  Assert.IsNotEmpty(FPessoa.Nome, 'TPessoa.Nome está retornando vazio');
end;

procedure TMyTestObject.ValidarCampos;
begin
  FPessoa.Nome := '';
  Assert.WillRaise(FPessoa.ValidarCampos, nil, 'TPessoa.ValidarCampos');//Serve para validar se um raise exception está realmente dando erro
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.
