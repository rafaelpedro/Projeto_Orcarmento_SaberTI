unit cadProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls, dataModule,
  Buttons, DBExtCtrls, cadModelo, DB;

type

  { TcadProdutoF }

  TcadProdutoF = class(TcadModeloF)
    DBComboBox1: TDBComboBox;
    DBDateEdit1: TDBDateEdit;
    dsProduto: TDataSource;
    edtIDProduto: TDBEdit;
    edtCategoriaProduto: TDBEdit;
    edtDescricaoProduto: TDBEdit;
    edtObservacaoProduto: TDBEdit;
    edtValorProduto: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtIDProdutoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  cadProdutoF: TcadProdutoF;

implementation

{$R *.lfm}

{ TcadProdutoF }

procedure TcadProdutoF.Label2Click(Sender: TObject);
begin

end;

procedure TcadProdutoF.edtIDProdutoChange(Sender: TObject);
begin

end;

procedure TcadProdutoF.FormShow(Sender: TObject);
begin
  inherited;
  DataModuleF.qryProduto.Open;
end;

procedure TcadProdutoF.btnBuscarClick(Sender: TObject);
begin
  DataModuleF.qryProduto.Close;

  if edtBuscar.Text = '' then
  begin
    //Caso eu não preencha nada no edtpesq todos os produtos serão retornados
    DataModuleF.qryProduto.SQL.Text := 'SELECT '+
                                         'PRODUTOID, '+
                                         'CATEGORIAPRODUTOID, '+
                                         'DS_PRODUTO, '+
                                         'OBS_PRODUTO, '+
                                         'VL_VENDA_PRODUTO, '+
                                         'DT_CADASTRO_PRODUTO, '+
                                         'STATUS_PRODUTO '+
                                         'FROM PRODUTO';








  end
  else
  begin
    DataModuleF.qryProduto.SQL.Text := 'SELECT '+
                                         'PRODUTOID, '+
                                         'CATEGORIAPRODUTOID, '+
                                         'DS_PRODUTO, '+
                                         'OBS_PRODUTO, '+
                                         'VL_VENDA_PRODUTO, '+
                                         'DT_CADASTRO_PRODUTO, '+
                                         'STATUS_PRODUTO '+
                                         'FROM PRODUTO '+
                                         'WHERE PRODUTOID = ' + edtBuscar.Text;
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' +  QuotedStr('%'+edtBuscar.Text+'%');
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' + '''' +'%'+edtBuscar.Text+'%'+ '''';


  end;
  DataModuleF.qryProduto.Open;
end;

procedure TcadProdutoF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryProduto.Delete;
  end;
end;

procedure TcadProdutoF.btnGravarClick(Sender: TObject);
begin
  DataModuleF.qryProduto.Post;
  DataModuleF.qryProduto.ApplyUpdates;
  PageControl.tabindex:=0;
end;

procedure TcadProdutoF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModuleF.qryProduto.Insert;
  edtDescricaoProduto.setfocus;
end;

procedure TcadProdutoF.DBComboBox1Change(Sender: TObject);
begin

end;

procedure TcadProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl.TabIndex:= 1;
end;

end.

