unit cadCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, cadModelo, DB, dataModule;

type

  { TcadCategoriaF }

  TcadCategoriaF = class(TcadModeloF)
    dsCategoria: TDataSource;
    edtID: TDBEdit;
    edtDescricao: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Panel6: TPanel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private

  public

  end;

var
  cadCategoriaF: TcadCategoriaF;

implementation

{$R *.lfm}

//uses
    //menuPrincipal;

{ TcadCategoriaF }

procedure TcadCategoriaF.btnBuscarClick(Sender: TObject);
begin
  DataModuleF.qryCategoria.Close;

  if edtBuscar.Text = '' then
  begin
    //Caso eu não preencha nada no edtpesq todos os produtos serão retornados
    DataModuleF.qryCategoria.SQL.Text := 'SELECT '+
                                         'CATEGORIAPRODUTOID, '+
                                         'DS_CATEGORIA_PRODUTO  '+
                                         'FROM CATEGORIA_PRODUTO';
  end
  else
  begin
    DataModuleF.qryCategoria.SQL.Text := 'SELECT '+
                                         'CATEGORIAPRODUTOID, '+
                                         'DS_CATEGORIA_PRODUTO '+
                                         'FROM CATEGORIA_PRODUTO '+
                                         'WHERE CATEGORIAPRODUTOID = ' + edtBuscar.Text;
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' +  QuotedStr('%'+edtBuscar.Text+'%');
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' + '''' +'%'+edtBuscar.Text+'%'+ '''';


  end;
  DataModuleF.qryCategoria.Open;
end;


procedure TcadCategoriaF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryCategoria.Delete;
  end;
end;

procedure TcadCategoriaF.btnGravarClick(Sender: TObject);
begin
  DataModuleF.qryCategoria.Post;
  DataModuleF.qryCategoria.ApplyUpdates;
  PageControl.TabIndex:= 0;
end;

procedure TcadCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl.TabIndex:= 1;
end;

procedure TcadCategoriaF.FormShow(Sender: TObject);
begin
  inherited;
  DataModuleF.qryCategoria.Open;
end;

procedure TcadCategoriaF.PageControlChange(Sender: TObject);
begin
  inherited;
end;

procedure TcadCategoriaF.btnNovoClick(Sender: TObject);
begin
  inherited;
   DataModuleF.qryCategoria.Insert;
   PageControl.TabIndex:= 1;
   edtID.setfocus;
end;


end.

