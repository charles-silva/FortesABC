unit uFrmRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, StdCtrls, Mask, uDmData, FMTBcd, DB, SqlExpr, Provider,
  DBClient;

type
  TfrmRelatorio = class(TForm)
    rptPeriodo: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    rllTitulo: TRLLabel;
    RLBand2: TRLBand;
    RLSystemInfo3: TRLSystemInfo;
    RLDraw1: TRLDraw;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    GroupBox1: TGroupBox;
    edInicial: TMaskEdit;
    Label1: TLabel;
    edFinal: TMaskEdit;
    btSair: TButton;
    btOk: TButton;
    qryReport: TSQLQuery;
    dsReport: TDataSource;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLBand4: TRLBand;
    RLLabel8: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    dspReport: TDataSetProvider;
    cdsReport: TClientDataSet;
    qryReportDATA: TDateField;
    qryReportTANQUE: TStringField;
    qryReportBOMBA: TStringField;
    qryReportLITROS: TSingleField;
    qryReportVALOR_ABASTECIMENTO: TSingleField;
    qryReportVALOR_IMPOSTOS: TSingleField;
    cdsReportDATA: TDateField;
    cdsReportTANQUE: TStringField;
    cdsReportBOMBA: TStringField;
    cdsReportLITROS: TSingleField;
    cdsReportVALOR_ABASTECIMENTO: TSingleField;
    cdsReportVALOR_IMPOSTOS: TSingleField;
    procedure btSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

{$R *.dfm}

procedure TfrmRelatorio.btOkClick(Sender: TObject);
begin
  if (edInicial.Text <> '  /  /    ') and (edFinal.Text <> '  /  /    ') then
  begin
    cdsReport.Close;
    qryReport.Params[0].AsDate        :=  StrToDate(edInicial.Text);
    qryReport.Params[1].AsDate        :=  StrToDate(edFinal.Text);
    cdsReport.Open;

    rptPeriodo.Preview;
  end
  else
  begin
    ShowMessage('Preencha o per�odo corretamente!');
    edInicial.SetFocus;
  end;

end;

procedure TfrmRelatorio.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorio.FormCreate(Sender: TObject);
begin
  edInicial.Text            :=  FormatDateTime('dd/mm/yyyy', Date);
  edFinal.Text              :=  FormatDateTime('dd/mm/yyyy', Date);
end;

end.
