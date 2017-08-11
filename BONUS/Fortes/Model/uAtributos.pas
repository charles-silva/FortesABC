unit uAtributos;

interface

type
  TableName = class(TCustomAttribute)
  private
    FName             : String;
    FListaDescricao   : String;
    FCadastroDescricao: String;
  public
    property Name             : String read FName write FName;
    property ListaDescricao   : String read FListaDescricao write FListaDescricao;
    property CadastroDescricao: String read FCadastroDescricao write FCadastroDescricao;
    constructor Create(const AValue: String; AListaDescricao: string; ACadastroDescricao: String);
  end;

  FieldName = class(TCustomAttribute)
  private
    FName   : String;
    FFK     : Boolean;
    FAutoInc: Boolean;
    FPK     : Boolean;
  public
    property Name   : String read FName write FName;
    property PK     : Boolean read FPK write FPK;
    property AutoInc: Boolean read FAutoInc write FAutoInc;
    property FK     : Boolean read FFK write FFK;
    constructor Create(const AValue: String; const APK: Boolean = False; const AAutoInc: Boolean = False; const AFK: Boolean = False);
  end;

implementation

{ TableName }

constructor TableName.Create(const AValue: String; AListaDescricao: string; ACadastroDescricao: String);
begin
  FName              := AValue;
  FListaDescricao    := AListaDescricao;
  FCadastroDescricao := ACadastroDescricao;
end;

{ FieldName }

constructor FieldName.Create(const AValue: String; const APK, AAutoInc, AFK: Boolean);
begin
  FName    := AValue;
  FPK      := APK;
  FAutoInc := AAutoInc;
  FFK      := AFK;
end;

end.
