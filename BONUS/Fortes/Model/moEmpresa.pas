unit moEmpresa;

interface

uses uAtributos, uPersistentObject, FireDAC.Comp.Client;

type

  [Tablename('TB_EMPRESA', 'Rela��o de Empresas ', 'Cadastro de Empresas')]
  TEmpresa = class(TPersintentObject)
  private
    // atributos da classe
    FCodigo     : integer;
    FRazaoSocial: string;
    FCNPJ       : string;
  public
    [FieldName('CODIGO', True, True)]
    property Codigo: integer read FCodigo write FCodigo;
    [FieldName('RAZAOSOCIAL')]
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    [FieldName('CNPJ')]
    property CNPJ: string read FCNPJ write FCNPJ;
    // Procedimentos
    function Insert: Boolean; override;
    function Update: Boolean; override;
    function Delete: Boolean; override;
    procedure Load(const AValue: integer); override;
    function GetKeyField: String; override;
    function GetListaDescricao: String; override;
    function GetCadastroDescricao: String; virtual;
    function LoadAll: TFDQuery; override;
  end;

implementation

{ TEmpresa }
function TEmpresa.Delete: Boolean;
begin
 Result := inherited Delete;
end;

function TEmpresa.GetCadastroDescricao: String;
begin
  Result := inherited GetCadastroDescricao;
end;

function TEmpresa.GetKeyField: String;
begin
  Result := inherited GetKeyField;
end;

function TEmpresa.GetListaDescricao: String;
begin
  Result := inherited GetListaDescricao;
end;

function TEmpresa.Insert: Boolean;
begin
  Result := inherited Insert;
end;

procedure TEmpresa.Load(const AValue: integer);
begin
  Codigo := AValue;
  inherited Load;
end;

function TEmpresa.LoadAll: TFDQuery;
begin
  Result := inherited LoadAll;
end;

function TEmpresa.Update: Boolean;
begin
 Result := inherited Update;
end;

end.
