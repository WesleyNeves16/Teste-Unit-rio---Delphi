unit Pessoa;

interface

uses
  System.SysUtils;

type
  TPessoa = class
  private
    FNome: String;
    FGUUID: String;
    FSenha: String;
    FDataAlteracao: TDateTime;
    FStatus: Integer;
    FDataCadastro: TDateTime;
    FTipo: Integer;
    procedure SetNome(const Value: String);
    procedure SetGUUID(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetDataAlteracao(const Value: TDateTime);
    procedure SetDataCadastro(const Value: TDateTime);
    procedure SetStatus(const Value: Integer);
    procedure SetTipo(const Value: Integer);
  public
    procedure ValidarCampos();
  published
    function TratarCPFCNPJ (aValue: String): String;
    property Nome: String read FNome write SetNome;
    property GUUID: String read FGUUID write SetGUUID;
    property Senha: String read FSenha write SetSenha;
    property Tipo: Integer read FTipo write SetTipo;
    property Status: Integer read FStatus write SetStatus;
    property DataCadastro: TDateTime read FDataCadastro write SetDataCadastro;
    property DataAlteracao: TDateTime read FDataAlteracao write SetDataAlteracao;
  end;

implementation

{ TPessoa }

procedure TPessoa.SetDataAlteracao(const Value: TDateTime);
begin
  FDataAlteracao := Value;
end;

procedure TPessoa.SetDataCadastro(const Value: TDateTime);
begin
  FDataCadastro := Value;
end;

procedure TPessoa.SetGUUID(const Value: String);
begin
  FGUUID := Value;
end;

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TPessoa.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TPessoa.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

procedure TPessoa.SetTipo(const Value: Integer);
begin
  FTipo := Value;
end;

function TPessoa.TratarCPFCNPJ(aValue: String): String;
var
  I: Integer;
begin
  for I := 1 to Length(aValue) do
  begin
    if aValue[I] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
      Result := Result +  aValue[I];
  end;
end;

procedure TPessoa.ValidarCampos;
begin
  if FNome = '' then
    raise Exception.Create('Nome não pode ser vazio');
end;

end.
