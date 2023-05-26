unit pesqCli;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, StdCtrls, dataModule;

type

  { TPesqCliF }

  TPesqCliF = class(TForm)
    BitBtn1: TBitBtn;
    dsPesqCli: TDataSource;
    DBGrid1: TDBGrid;
    edtBuscar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  PesqCliF: TPesqCliF;

implementation

{$R *.lfm}

uses
  orcamento;

{ TPesqCliF }

procedure TPesqCliF.BitBtn1Click(Sender: TObject);
var
  AuxWhere : String;
begin
  if edtBuscar.Text = '' then
    AuxWhere := '1 = 1'
  else
    AuxWhere := 'clienteid = '+edtBuscar.Text;

  DataModuleF.qryCliente.Close;
  DataModuleF.qryCliente.SQL.Text :=
               'SELECT '+
               'clienteid, '+
               'tipo_cliente, '+
               'cpf_cnpj_cliente, '+
               'nome_cliente '+
               'FROM CLIENTE '+
               'WHERE '+AuxWhere+' '+
               'ORDER BY clienteid';
  DataModuleF.qryCliente.Open;
end;

procedure TPesqCliF.DBGrid1DblClick(Sender: TObject);
begin
  //aqui vai puxar para o orçamento
  DataModuleF.qryOrcamentoclienteid.AsInteger:=DataModuleF.qryClienteclienteid.AsInteger;
  orcamentoF.lblDescrCli.Caption := DataModuleF.qryClientenome_cliente.AsString;

  Close;
end;

procedure TPesqCliF.FormShow(Sender: TObject);
begin
  DataModuleF.qryCliente.Open;
end;

end.

