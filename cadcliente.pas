unit cadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, dataModule, cadModelo, DB;

type

  { TcadClienteF }

  TcadClienteF = class(TcadModeloF)
    dsCliente: TDataSource;
    edtIdCliente: TDBEdit;
    edtNomeCliente: TDBEdit;
    edtCpfCnpjCliente: TDBEdit;
    edtTipoCliente: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
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
  cadClienteF: TcadClienteF;

implementation

{$R *.lfm}

{ TcadClienteF }


procedure TcadClienteF.FormShow(Sender: TObject);
begin
  inherited;
  DataModuleF.qryCliente.Open;
end;

procedure TcadClienteF.btnBuscarClick(Sender: TObject);
begin
  DataModuleF.qryCliente.Close;

  if edtBuscar.Text = '' then
  begin
    //Caso eu não preencha nada no edtpesq todos os produtos serão retornados
    DataModuleF.qryCliente.SQL.Text := 'SELECT '+
                                         'CLIENTEID, '+
                                         'TIPO_CLIENTE, '+
                                         'CPF_CNPJ_CLIENTE, '+
                                         'NOME_CLIENTE '+
                                         'FROM CLIENTE';

  end
  else
  begin
    DataModuleF.qryCliente.SQL.Text := 'SELECT '+
                                         'CLIENTEID, '+
                                         'TIPO_CLIENTE, '+
                                         'CPF_CNPJ_CLIENTE, '+
                                         'NOME_CLIENTE '+
                                         'FROM CLIENTE ' +
                                         'WHERE CLIENTEID = ' + edtBuscar.Text;
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' +  QuotedStr('%'+edtBuscar.Text+'%');
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' + '''' +'%'+edtBuscar.Text+'%'+ '''';


  end;
  DataModuleF.qryCliente.Open;
end;

procedure TcadClienteF.BitBtn1Click(Sender: TObject);
begin
  DataModuleF.qryCliente.Edit;
end;

procedure TcadClienteF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryCliente.Delete;
  end;
end;

procedure TcadClienteF.btnGravarClick(Sender: TObject);
begin
  DataModuleF.qryCliente.Post;
  DataModuleF.qryCliente.ApplyUpdates;
  PageControl.TabIndex:= 0;
end;

procedure TcadClienteF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModuleF.qryCliente.Insert;
  edtNomeCliente.setfocus;
end;

procedure TcadClienteF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl.TabIndex:= 1;
end;

end.

