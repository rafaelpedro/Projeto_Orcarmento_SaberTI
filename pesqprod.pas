unit pesqProd;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, Buttons, DBGrids, dataModule;

type

  { TpesqProdF }

  TpesqProdF = class(TForm)
    btnBuscar: TBitBtn;
    dsPesqProd: TDataSource;
    DBGrid1: TDBGrid;
    edtBuscar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    procedure btnBuscarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  pesqProdF: TpesqProdF;

implementation

{$R *.lfm}

{ TpesqProdF }

procedure TpesqProdF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TpesqProdF.FormShow(Sender: TObject);
begin
  DataModuleF.qryProduto.Open;
end;

procedure TpesqProdF.btnBuscarClick(Sender: TObject);
var
  AuxWhere : String;
begin
  //Esta procedure irá executar a pesquisa do produto
  if edtBuscar.Text = '' then
    AuxWhere := '1 = 1'
  else
    AuxWhere := 'PRODUTOID = '+edtBuscar.Text;

  DataModuleF.qryProduto.Close;
  DataModuleF.qryProduto.SQL.Text :=
            'SELECT '+
            'PRODUTOID, '+
            'CATEGORIAPRODUTOID, '+
            'DS_PRODUTO, '+
            'OBS_PRODUTO, '+
            'VL_VENDA_PRODUTO, '+
            'DT_CADASTRO_PRODUTO, '+
            'STATUS_PRODUTO '+
            'FROM PRODUTO '+
            'WHERE '+AuxWhere+' '+
            'ORDER BY PRODUTOID';
  DataModuleF.qryProduto.Open;
end;

procedure TpesqProdF.DBGrid1DblClick(Sender: TObject);
begin
    DataModuleF.qryOrcamentoItemprodutoid.AsInteger  := DataModuleF.qryProdutoprodutoid.AsInteger;
    DataModuleF.qryOrcamentoItemprodutodesc.AsString := DataModuleF.qryProdutods_produto.AsString;
    DataModuleF.qryOrcamentoItemvl_unitario.AsFloat  := DataModuleF.qryProdutovl_venda_produto.AsFloat;
    Close;
end;

end.

