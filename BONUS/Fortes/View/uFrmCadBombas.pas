unit uFrmCadBombas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmCadDefault, System.ImageList,
  Vcl.ImgList, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmCadDefault1 = class(TFrmCadDefault)
    Label2: TLabel;
    Label4: TLabel;
    edtCodigo: TEdit;
    edtRazaoSocial: TEdit;
    cbbTanque: TComboBox;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadDefault1: TFrmCadDefault1;

implementation

{$R *.dfm}

end.
