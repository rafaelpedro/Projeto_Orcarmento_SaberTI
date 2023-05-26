unit cadUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  cadModelo, DB, dataModule;

type

  { TcadUsuarioF }

  TcadUsuarioF = class(TcadModeloF)
    dsUsuario: TDataSource;
    edtIdUsuario: TDBEdit;
    edtUsuario: TDBEdit;
    edtSenhaUsuario: TDBEdit;
    edtNomeUsuario: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  cadUsuarioF: TcadUsuarioF;

implementation

{$R *.lfm}

{ TcadUsuarioF }

procedure TcadUsuarioF.btnBuscarClick(Sender: TObject);
begin
  DataModuleF.qryUsuario.Close;

  if edtBuscar.Text = '' then
  begin
    //Caso eu não preencha nada no edtpesq todos os produtos serão retornados
    DataModuleF.qryUsuario.SQL.Text := 'SELECT '+
                                         'ID, '+
                                         'USUARIO, '+
                                         'NOME_COMPLETO, '+
                                         'SENHA '+
                                         'FROM USUARIOS';

  end
  else
  begin
    DataModuleF.qryUsuario.SQL.Text := 'SELECT '+
                                         'ID, '+
                                         'USUARIO, '+
                                         'NOME_COMPLETO, '+
                                         'SENHA '+
                                         'FROM USUARIOS '+
                                         'WHERE ID = ' + edtBuscar.Text;
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' +  QuotedStr('%'+edtBuscar.Text+'%');
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' + '''' +'%'+edtBuscar.Text+'%'+ '''';


  end;
  DataModuleF.qryUsuario.Open;
end;

procedure TcadUsuarioF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryUsuario.Delete;
  end;
end;

procedure TcadUsuarioF.btnGravarClick(Sender: TObject);
begin
  DataModuleF.qryUsuario.Post;
  DataModuleF.qryUsuario.ApplyUpdates;
  PageControl.TabIndex:= 0;
end;

procedure TcadUsuarioF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModuleF.qryUsuario.Insert;
  edtUsuario.setfocus;

end;

procedure TcadUsuarioF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl.TabIndex:=1;
end;

procedure TcadUsuarioF.FormShow(Sender: TObject);
begin
  inherited;
  DataModuleF.qryUsuario.Open;
end;

end.

