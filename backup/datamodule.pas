unit dataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset, ZSqlUpdate;

type

  { TDataModuleF }

  TDataModuleF = class(TDataModule)
    qryCategoriacategoriaprodutoid: TLongintField;
    qryCategoriads_categoria_produto: TStringField;
    qryClienteclienteid: TLongintField;
    qryClientecpf_cnpj_cliente: TStringField;
    qryClientenome_cliente: TStringField;
    qryClientetipo_cliente: TStringField;
    qryOrcamentoclienteid: TLongintField;
    qryOrcamentodt_orcamento: TDateTimeField;
    qryOrcamentodt_validade_orcamento: TDateTimeField;
    qryOrcamentoItemorcamentoid: TLongintField;
    qryOrcamentoItemorcamentoitemid: TLongintField;
    qryOrcamentoItemprodutodesc: TStringField;
    qryOrcamentoItemprodutoid: TLongintField;
    qryOrcamentoItemqt_produto: TFloatField;
    qryOrcamentoItemvl_total: TFloatField;
    qryOrcamentoItemvl_unitario: TFloatField;
    qryOrcamentoorcamentoid: TLongintField;
    qryOrcamentovl_total_orcamento: TFloatField;
    qryProdutocategoriaprodutoid: TLongintField;
    qryProdutods_produto: TStringField;
    qryProdutodt_cadastro_produto: TDateTimeField;
    qryProdutoobs_produto: TStringField;
    qryProdutoprodutoid: TLongintField;
    qryProdutostatus_produto: TStringField;
    qryProdutovl_venda_produto: TFloatField;
    qryUsuarioid: TLongintField;
    qryUsuarionome_completo: TStringField;
    qryUsuariosenha: TStringField;
    qryUsuariousuario: TStringField;
    ZConnection1: TZConnection;
    qryCategoria: TZQuery;
    updtCategoria: TZUpdateSQL;
    qryGenerica: TZQuery;
    qryCliente: TZQuery;
    updtCliente: TZUpdateSQL;
    qryProduto: TZQuery;
    updtProduto: TZUpdateSQL;
    qryUsuario: TZQuery;
    updtUsuario: TZUpdateSQL;
    qryOrcamento: TZQuery;
    updtOrcamento: TZUpdateSQL;
    qryOrcamentoItem: TZQuery;
    updtOrcamentoItem: TZUpdateSQL;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryCategoriaNewRecord(DataSet: TDataSet);
    procedure qryClienteNewRecord(DataSet: TDataSet);
    procedure qryOrcamentoAfterInsert(DataSet: TDataSet);
    procedure qryOrcamentoAfterOpen(DataSet: TDataSet);
    procedure qryOrcamentoAfterPost(DataSet: TDataSet);
    procedure qryProdutoNewRecord(DataSet: TDataSet);
    procedure qryUsuarioNewRecord(DataSet: TDataSet);
    procedure qryOrcamentoItemqt_produtoChange(Sender: TField);
    function GetProximoCodigo(const pNomeChave, pNomeTabela, pOrcamento: String): String;
  private

  public
     function getSequence(const pNomeSequence: String): String;
     procedure SomaItens;
  end;

var
  DataModuleF: TDataModuleF;

implementation

{$R *.lfm}

{ TDataModuleF }

function TDataModuleF.GetProximoCodigo(const pNomeChave, pNomeTabela, pOrcamento: String): String;
begin
    Result := '';
  try
    qryGenerica.close;
    qryGenerica.SQL.Clear;
    qryGenerica.SQL.Text :=
      'SELECT MAX('+pNomeChave+') + 1 PROXCODIGO '+
      'FROM ' + pNomeTabela +
      ' WHERE ORCAMENTOID = ' + pOrcamento;
    qryGenerica.Open;

    Result := qryGenerica.FieldByName('PROXCODIGO').AsString;
  finally
    qryGenerica.Close;
  end;
end;


function TDataModuleF.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     qryGenerica.close;
     qryGenerica.SQL.Clear;
     qryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     qryGenerica.Open;
     Result := qryGenerica.FieldByName('CODIGO').AsString;
 finally
   qryGenerica.Close;
 end;
end;

procedure TDataModuleF.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase := 'postgres';
  ZConnection1.User     := 'postgres';
  ZConnection1.Password := '1234';
  ZConnection1.Port     := 5432;
  ZConnection1.Protocol := 'postgresql';
  ZConnection1.Connected := True;
end;

procedure TDataModuleF.qryCategoriaNewRecord(DataSet: TDataSet);
begin
  qryCategoriacategoriaprodutoid.AsString:= getSequence('orcamento_orcamentoid_seq');
end;

procedure TDataModuleF.qryClienteNewRecord(DataSet: TDataSet);
begin
  qryClienteclienteid.AsString:= getSequence('cliente_clienteid');
end;

procedure TDataModuleF.qryOrcamentoAfterInsert(DataSet: TDataSet);
begin
  qryOrcamentoorcamentoid.AsInteger   := StrToInt(getSequence('orcamento_orcamentoid_seq'));
  qryOrcamentodt_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
  qryOrcamentodt_validade_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now + 15));
end;

procedure TDataModuleF.qryOrcamentoAfterOpen(DataSet: TDataSet);
begin
 {if qryOrcamentoorcamentoid.AsString <> '' then
 begin
      qryOrcamentoItem.Close;
      //Verificar pq este parametro não esta funcionando
      qryOrcamentoItem.ParamByName('orcamentoid').AsString := qryOrcamentoorcamentoid.AsString;
      qryOrcamentoItem.Open;
 end;}
end;

procedure TDataModuleF.qryOrcamentoAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TDataModuleF.qryProdutoNewRecord(DataSet: TDataSet);
begin
  qryProdutodt_cadastro_produto.AsDateTime := now;
  qryProdutostatus_produto.AsString := 'Ativo';
  qryProdutoprodutoid.AsString:= getSequence('produto_produtoid');
end;

procedure TDataModuleF.qryUsuarioNewRecord(DataSet: TDataSet);
begin
  qryUsuarioid.AsString:= getSequence('usuario_id_seq');
end;

procedure TDataModuleF.SomaItens;
begin

  if not (DataModuleF.qryOrcamento.State in [dsEdit, dsInsert]) then
     DataModuleF.qryOrcamento.Edit;

  if not (DataModuleF.qryOrcamentoItem.State in [dsEdit, dsInsert]) then
     DataModuleF.qryOrcamentoItem.Edit;

  //Vai pro Primeiro
  DataModuleF.qryOrcamentoItem.First;
  DataModuleF.qryOrcamentovl_total_orcamento.AsFloat := 0;
  while not DataModuleF.qryOrcamentoItem.Eof do
  begin
    DataModuleF.qryOrcamentovl_total_orcamento.AsFloat := DataModuleF.qryOrcamentovl_total_orcamento.AsFloat + DataModuleF.qryOrcamentoItemvl_total.AsFloat;
    DataModuleF.qryOrcamentoItem.next;
  end;
end;

procedure TDataModuleF.qryOrcamentoItemqt_produtoChange(Sender: TField);
var  xQtde, xVlrUnit, xVlrTotal : double;
begin
  xQtde     := qryOrcamentoItemqt_produto.AsFloat;
  xVlrUnit  := qryOrcamentoItemvl_unitario.AsFloat;

  if  xQtde > 0  then
  begin
    xVlrTotal := xQtde * xVlrUnit;
    qryOrcamentoItemvl_total.AsFloat := xVlrTotal;
  end;
end;

end.

