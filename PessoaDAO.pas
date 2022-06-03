unit PessoaDAO;

interface

uses
  Pessoa, Uni;

type
  TPessoaDAO = class
    private
      FPessoa: TPessoa;
    strict private
      FQuery: TUniQuery;
    public
      constructor Create;
      destructor Destroy; override;
      function Entidade: TPessoa;
      procedure ValidarCampos();
      procedure Insert();
      procedure Update();
      procedure Delete();
      procedure BuscarId(aId: String);
  end;

implementation

uses
  System.SysUtils, Conexao;

{ TPessoaDAO }

procedure TPessoaDAO.BuscarId(aId: String);
begin
  FQuery.SQL.Clear();
  FQuery.SQL.Add('SELECT * FROM USUARIO WHERE GUUID = '+ QuotedStr(aId));
  FQuery.Open();
  FPessoa.GUUID := FQuery.FieldByName('GUUID').AsString;
  FPessoa.Nome := FQuery.FieldByName('Nome').AsString;
  FPessoa.Senha := FQuery.FieldByName('Senha').AsString;
  FPessoa.Tipo := FQuery.FieldByName('Tipo').AsInteger;
  FPessoa.Status := FQuery.FieldByName('Status').AsInteger;
  FPessoa.DataCadastro := FQuery.FieldByName('DataCadastro').AsDateTime;
  FPessoa.DataAlteracao := FQuery.FieldByName('DataAlteracao').AsDateTime;
end;

constructor TPessoaDAO.Create;
begin
  FPessoa := TPessoa.Create;

  if not Assigned(DmDados) then
    DmDados := TDmDados.Create(nil);

  FQuery := DmDados.TbUsuario;
end;

procedure TPessoaDAO.Delete;
begin
  FQuery.SQL.Clear();
  FQuery.SQL.Add('SELECT * FROM USUARIO WHERE GUUID = '+ QuotedStr(FPessoa.GUUID));
  FQuery.Open();
  FQuery.Delete();
end;

destructor TPessoaDAO.Destroy;
begin
  FreeAndNil(FPessoa);
  inherited;
end;

function TPessoaDAO.Entidade: TPessoa;
begin
  Result := FPessoa;
end;

procedure TPessoaDAO.Insert;
begin
//  ValidarCampos();
  FQuery.SQL.Clear();
  FQuery.SQL.Add('SELECT * FROM USUARIO WHERE 1 = -1');
  FQuery.Open();
  FQuery.Append();
  FQuery.FieldByName('GUUID').AsString := FPessoa.GUUID;
  FQuery.FieldByName('Nome').AsString := FPessoa.Nome;
  FQuery.FieldByName('Senha').AsString := FPessoa.Senha;
  FQuery.FieldByName('Tipo').AsInteger := FPessoa.Tipo;
  FQuery.FieldByName('Status').AsInteger := FPessoa.Status;
  FQuery.FieldByName('DataCadastro').AsDateTime := FPessoa.DataCadastro;
  FQuery.FieldByName('DataAlteracao').AsDateTime := FPessoa.DataAlteracao;
  FQuery.Post();
  //Thulio usa FDB, então, ele faz um append, post e applyupdates(0) - Verificar com o Gil o porquê disso, e se é melhor ou não
end;

procedure TPessoaDAO.Update;
begin
  FQuery.SQL.Clear();
  FQuery.SQL.Add('SELECT * FROM USUARIO WHERE GUUID = '+ QuotedStr(FPessoa.GUUID));
  FQuery.Open();
  FQuery.Edit();
  FQuery.FieldByName('GUUID').AsString := FPessoa.GUUID;
  FQuery.FieldByName('Nome').AsString := FPessoa.Nome;
  FQuery.FieldByName('Senha').AsString := FPessoa.Senha;
  FQuery.FieldByName('Tipo').AsInteger := FPessoa.Tipo;
  FQuery.FieldByName('Status').AsInteger := FPessoa.Status;
  FQuery.FieldByName('DataCadastro').AsDateTime := FPessoa.DataCadastro;
  FQuery.FieldByName('DataAlteracao').AsDateTime := FPessoa.DataAlteracao;
  FQuery.Post();
end;

procedure TPessoaDAO.ValidarCampos;
begin
  if FPessoa.Nome = '' then
    raise Exception.Create('Nome nao pode ser vazio');
end;

end.
