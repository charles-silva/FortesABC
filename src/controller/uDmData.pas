unit uDmData;

interface

uses
  SysUtils, Classes, WideStrings, DB, SqlExpr, DBXFirebird, FMTBcd, Provider,
  DBClient, IniFiles;

type
  TdmData = class(TDataModule)
    qryTanques: TSQLQuery;
    dspTanques: TDataSetProvider;
    cdsTanques: TClientDataSet;
    dbConn: TSQLConnection;
    qryBombas: TSQLQuery;
    dspBombas: TDataSetProvider;
    cdsBombas: TClientDataSet;
    qryAbastecimentos: TSQLQuery;
    dspAbastecimentos: TDataSetProvider;
    cdsAbastecimentos: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure dbConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  dbConn.Connected          :=  True;
end;

procedure TdmData.dbConnBeforeConnect(Sender: TObject);
  var
    s_Config      : TIniFile;
    s_Parametros  : TStringList;
    db_caminho    : string;
begin
  s_Config                  :=  TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  s_Parametros              :=  TStringList.Create;

  try
    db_caminho              :=  s_Config.ReadString('CONFIG', 'db', '');

    with s_Parametros do
    begin
      Clear;
      Add('DriverName=Firebird');
      Add('Database='+ db_caminho);
      Add('User_Name=SYSDBA');
      Add('Password=masterkey');
      Add('ServerCharSet=WIN1252');
      Add('SQLDialect=3');
      Add('isolationlevel=ReadCommitted');
    end;

    with dbConn do
    begin
      try
        Params.Text         :=  s_Parametros.Text;
      except
        raise Exception.Create('N�o foi poss�vel conectar na base de dados.');
      end;
    end;
  finally
    s_Config.Free;
    s_Parametros.Free;
  end;
end;

end.
