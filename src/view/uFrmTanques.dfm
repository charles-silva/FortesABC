inherited frmTanques: TfrmTanques
  Caption = 'Cadastro de Tanques'
  ClientHeight = 329
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 572
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 288
    ExplicitTop = 204
  end
  inherited pnlDados: TPanel
    Left = 0
    Width = 566
    Height = 137
    Align = alTop
    ExplicitLeft = 0
    ExplicitWidth = 566
    ExplicitHeight = 137
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 59
      Height = 13
      Caption = 'DESCRI'#199#195'O'
    end
    object edId: TEdit
      Left = 16
      Top = 32
      Width = 65
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edDescricao: TEdit
      Left = 16
      Top = 88
      Width = 241
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object rgCombustivel: TRadioGroup
      Left = 272
      Top = 24
      Width = 241
      Height = 57
      Caption = 'COMBUSTIVEL'
      Columns = 2
      Items.Strings = (
        'GASOLINA'
        'OLEO DIESEL')
      TabOrder = 2
    end
  end
  inherited pnlGrid: TPanel
    Top = 137
    Width = 566
    Height = 151
    Align = alClient
    ExplicitTop = 137
    ExplicitWidth = 566
    ExplicitHeight = 151
    inherited gridDados: TDBGrid
      Width = 564
      Height = 149
      OnDblClick = gridDadosDblClick
    end
  end
  inherited dsDados: TDataSource
    DataSet = dmData.cdsTanques
    OnDataChange = dsDadosDataChange
    Left = 88
    Top = 120
  end
end
