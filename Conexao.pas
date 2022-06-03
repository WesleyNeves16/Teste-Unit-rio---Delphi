unit Conexao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Uni, UniProvider,
  SQLServerUniProvider;

type
  TDmDados = class(TDataModule)
    Conexao: TUniConnection;
    TbUsuario: TUniQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
