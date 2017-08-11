unit uFrmAbastecimentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBase, DB, Grids, DBGrids, StdCtrls, ExtCtrls,
  uAbastecimentoController, uAbastecimentoModel, uDmData, Mask, uFrmBombas;

type
  TFrmAbastecimentos = class(TfrmBase)
    Label1: TLabel;
    edId: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edBomba: TEdit;
    btLocalizar: TButton;
    edData: TMaskEdit;
    edLitros: TEdit;
    Label4: TLabel;
    edValor: TEdit;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btIncluirClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure edDataExit(Sender: TObject);
    procedure edLitrosExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Manutencao(Habilita : boolean = False); override;
    function  ValidaDados : boolean; override;
    procedure Limpa;    override;
    procedure Incluir;  override;
    procedure Editar;   override;
    procedure Excluir;  override;
    procedure Gravar;   override;
    procedure Cancelar; override;
    procedure CarregaDados; override;
  end;

var
  FrmAbastecimentos: TFrmAbastecimentos;
  am        : TAbastecimentoModel;
  ac        : TAbastecimentoController;

implementation

{$R *.dfm}

{ TFrmAbastecimentos }

procedure TFrmAbastecimentos.btIncluirClick(Sender: TObject);
begin
  inherited;

  am.ClearClass;
  edData.SetFocus;
  edData.Text     :=  FormatDateTime('dd/mm/yyyy', Date);
end;

procedure TFrmAbastecimentos.btLocalizarClick(Sender: TObject);
  var
    formBomba : TfrmBombas;
begin
  inherited;

  try
    formBomba              :=  TfrmBombas.Create(nil);
    formBomba.FormStyle    :=  fsNormal;
    formBomba.Visible      :=  False;
    formBomba.pnlBotoes.Visible  :=  False;
    formBomba.Caption      :=  'Duplo click para selecionar';
    formBomba.ShowModal;
  finally
    if (formBomba.ModalResult = mrOk) then
    begin
      edBomba.Text         :=  formBomba.dsDados.DataSet.FieldByName('Descricao').AsString;
      edBomba.Tag          :=  formBomba.dsDados.DataSet.FieldByName('Id').AsInteger;
    end;

    formBomba.Release;
    formBomba              :=  nil;
  end;
end;

procedure TFrmAbastecimentos.Cancelar;
begin
  inherited;

  Manutencao(False);
  Limpa;
  am.ClearClass;
  am.ID           :=  dsDados.DataSet.FieldByName('ID').AsInteger;
  am.DATA         :=  dsDados.DataSet.FieldByName('DATA').AsDateTime;

  ac.Select(am);

  if am.ID > 0 then
    CarregaDados;
end;

procedure TFrmAbastecimentos.CarregaDados;
begin
  inherited;

  edId.Text                 :=  IntToStr(am.ID);
  edData.Text               :=  FormatDateTime('dd/mm/yyyy', am.DATA);
  edBomba.Text              :=  dsDados.DataSet.FieldByName('Bomba').AsString;
  edBomba.Tag               :=  am.ID_BOMBA;
  edLitros.Text             :=  FormatFloat('0.000', am.LITROS);
  edValor.Text              :=  FormatFloat('#,##0.00', am.VLR_ABASTECE);
end;

procedure TFrmAbastecimentos.dsDadosDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  Limpa;

  if
    (dsDados.DataSet.Active) and
    (dsDados.DataSet.RecordCount > 0)
  then
  begin
    am.ID           :=  dsDados.DataSet.FieldByName('ID').AsInteger;
    am.DATA         :=  dsDados.DataSet.FieldByName('DATA').AsDateTime;
    ac.Select(am);
    CarregaDados;
  end;
end;

procedure TFrmAbastecimentos.edDataExit(Sender: TObject);
begin
  inherited;

  if (edData.Text <> '  /  /    ') then
  try
    StrToDate(edData.Text);
  except
    ShowMessage('Data inv�lida');
    edData.SetFocus;
  end;
end;

procedure TFrmAbastecimentos.Editar;
begin
  inherited;

  edData.SetFocus;
end;

procedure TFrmAbastecimentos.edLitrosExit(Sender: TObject);
begin
  inherited;

  edLitros.Text   :=  FormatFloat('0.000', StrToFloatDef(edLitros.Text, 0));
end;

procedure TFrmAbastecimentos.edValorExit(Sender: TObject);
begin
  inherited;

  edValor.Text   :=
    FormatFloat('#,##0.00', StrToFloatDef(StringReplace(edValor.Text, '.', '', [rfReplaceAll]), 0));
end;

procedure TFrmAbastecimentos.Excluir;
begin
  inherited;

  ac.Delete(am);
  dsDados.DataSet.Refresh;
end;

procedure TFrmAbastecimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Action  :=  caFree;
  FrmAbastecimentos       :=  nil;
end;

procedure TFrmAbastecimentos.FormCreate(Sender: TObject);
begin
  inherited;

  am              :=  TAbastecimentoModel.Create;
  ac              :=  TAbastecimentoController.Create(dmData.dbConn);
end;

procedure TFrmAbastecimentos.FormShow(Sender: TObject);
begin
  inherited;

  dmData.cdsAbastecimentos.Close;
  dmData.cdsAbastecimentos.Open;
end;

procedure TFrmAbastecimentos.Gravar;
begin
  am.DATA              :=  StrToDate(edData.Text);
  am.ID_BOMBA          :=  edBomba.Tag;
  am.LITROS            :=  StrToFloat(edLitros.Text);
  am.VLR_ABASTECE       :=  StrToFloat(StringReplace(edValor.Text, '.', '', [rfReplaceAll]));

  if am.ID = 0 then
    ac.Insert(am)
  else
    ac.Update(am);

  dsDados.DataSet.Refresh;

  inherited;

end;

procedure TFrmAbastecimentos.Incluir;
begin
  inherited;

end;

procedure TFrmAbastecimentos.Limpa;
begin
  inherited;

  edId.Text                 :=  '';
  edData.Text               :=  '';
  edBomba.Text              :=  '';
  edBomba.Tag               :=  0;
  edLitros.Text             :=  '';
  edValor.Text              :=  '';
end;

procedure TFrmAbastecimentos.Manutencao(Habilita: boolean);
begin
  inherited;

end;

function TFrmAbastecimentos.ValidaDados: boolean;
begin
  Result          :=
    (edData.Text <> '  /  /    ')         and
    (edBomba.Tag > 0)                     and
    (StrToFloatDef(edLitros.Text, 0) > 0) and
    (StrToFloatDef(StringReplace(edValor.Text, '.', '', [rfReplaceAll]), 0) > 0);
end;

end.
