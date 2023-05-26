unit orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, DBCtrls, Buttons, LR_Class, LR_DBSet, cadModelo, DB, dataModule,
  cadItemOrc, pesqCli;

type

  { TorcamentoF }

  TorcamentoF = class(TcadModeloF)
    btnImprimir: TBitBtn;
    btnAdicionarItem: TBitBtn;
    btnExcluirItem: TBitBtn;
    dsOrcamentoItem: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBGrid2: TDBGrid;
    dsOrcamento: TDataSource;
    frDBOrcItens: TfrDBDataSet;
    frReportOrcamento: TfrReport;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblDescrCli: TLabel;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AbreOrcItens(orcamentoid : Integer);
    procedure PageControlChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public
    iditem: integer;

  end;

var
  orcamentoF: TorcamentoF;

implementation

{$R *.lfm}

{ TorcamentoF }
procedure TOrcamentoF.AbreOrcItens(orcamentoid : Integer);
begin
  if orcamentoid <> 0 then
  begin
      DataModuleF.qryOrcamentoItem.Close;
      DataModuleF.qryOrcamentoItem.SQL.Clear;
      DataModuleF.qryOrcamentoItem.SQL.Add(
                      'SELECT '+
                      'ORCAMENTOITEMID, '+
                      'ORCAMENTOID, '+
                      'PRODUTOID, '+
                      'produtodesc, '+
                      'QT_PRODUTO, '+
                      'VL_UNITARIO, '+
                      'VL_TOTAL '+
                      'FROM ORCAMENTO_ITEM ' +
                      'WHERE ORCAMENTOID = '+ inttostr(orcamentoid) + ' ' +
                      'ORDER BY ORCAMENTOID');

       DataModuleF.qryOrcamentoItem.Open;
  end;
end;

procedure TorcamentoF.PageControlChange(Sender: TObject);
begin
  //VERIFICAR O MOTIVO DESTA PROCEDURE - BTN NOVO NÃO FUNCIONA CORRETAMENTE
  inherited;
  if DataModuleF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
     dsOrcamentoItem.DataSet.Cancel;
     btnNovo.Enabled := True;
  end
  else
  begin
    AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
  end;
end;

procedure TorcamentoF.SpeedButton1Click(Sender: TObject);
begin
   pesqCliF:= TpesqCliF.create(Self);
   pesqCliF.ShowModal;
end;

procedure TorcamentoF.btnBuscarClick(Sender: TObject);
begin
  DataModuleF.qryOrcamento.Close;

  if edtBuscar.Text = '' then
  begin
    //Caso eu não preencha nada no edtpesq todos os produtos serão retornados
    DataModuleF.qryOrcamento.SQL.Text := 'SELECT '+
                                         'ORCAMENTOID, '+
                                         'CLIENTEID, '+
                                         'DT_ORCAMENTO, '+
                                         'DT_VALIDADE_ORCAMENTO, '+
                                         'VL_TOTAL_ORCAMENTO '+
                                         'FROM ORCAMENTO';
  end
  else
  begin
    DataModuleF.qryOrcamento.SQL.Text := 'SELECT '+
                                         'ORCAMENTOID, '+
                                         'CLIENTEID, '+
                                         'DT_ORCAMENTO, '+
                                         'DT_VALIDADE_ORCAMENTO, '+
                                         'VL_TOTAL_ORCAMENTO '+
                                         'FROM ORCAMENTO '+
                                         'WHERE ORCAMENTOID = ' + edtBuscar.Text;
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' +  QuotedStr('%'+edtBuscar.Text+'%');
                                         //'WHERE DS_CATEGORIA_PRODUTO LIKE' + '''' +'%'+edtBuscar.Text+'%'+ '''';


  end;
  DataModuleF.qryOrcamento.Open;
end;

procedure TorcamentoF.btnExcluirClick(Sender: TObject);
begin
   if  MessageDlg('Você tem certeza que deseja excluir este orçamento?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    dsOrcamento.DataSet.Delete;
  end;
   pagecontrol.tabIndex:=0;
end;

procedure TorcamentoF.btnExcluirItemClick(Sender: TObject);
begin
  dsOrcamentoItem.DataSet.Delete;
  DataModuleF.SomaItens;
end;

procedure TorcamentoF.btnGravarClick(Sender: TObject);
begin
 DataModuleF.SomaItens;
 DataModuleF.qryOrcamento.Post;
 PageControl.tabIndex:=0;
end;

procedure TorcamentoF.btnImprimirClick(Sender: TObject);
begin
 //corrigir
   frReportOrcamento.LoadFromFile('Modelo_De_Relatorio.lrf');
   frReportOrcamento.PrepareReport;
   frReportOrcamento.ShowReport;
end;

procedure TorcamentoF.btnAdicionarItemClick(Sender: TObject);
var
id : String;
begin
    dsOrcamentoItem.DataSet.Insert;

    //Busca o ultimo código do orçamento atual
    DataModuleF.qryGenerica.close;
    DataModuleF.qryGenerica.SQL.Clear;
    DataModuleF.qryGenerica.SQL.Add('SELECT MAX(orcamentoitemid) + 1 PROXCODIGO '+
                                    'FROM orcamento_item' +
                                    ' WHERE ORCAMENTOID = ' + IntToStr(DataModuleF.qryOrcamentoorcamentoid.AsInteger));
    //ShowMessage(DataModule1.qryGenerica.SQL.Text);
    DataModuleF.qryGenerica.Open;

    id := DataModuleF.qryGenerica.FieldByName('PROXCODIGO').AsString;

    if id = '' then
       DataModuleF.qryOrcamentoItemorcamentoitemid.AsInteger := 1
    else
       DataModuleF.qryOrcamentoItemorcamentoitemid.AsInteger := StrToInt(id);

    //Passando o código do orçamentoid
    DataModuleF.qryOrcamentoItemorcamentoid.AsInteger := DataModuleF.qryOrcamentoorcamentoid.AsInteger;

    //abre a tela de que permita fazer a busca do produto
    cadItemOrcF:= TcadItemOrcF.create(Self);
    cadItemOrcF.ShowModal;

end;


procedure TorcamentoF.btnNovoClick(Sender: TObject);
begin
  inherited;
  lblDescrCli.Caption := '';
  if DataModuleF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    dsOrcamento.DataSet.Post;
    dsOrcamento.DataSet.Insert;
    AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
  end
  else
  begin
    dsOrcamento.DataSet.Insert;
    AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
  end;

  DBEdit2.SetFocus;
end;

procedure TorcamentoF.DBGrid1DblClick(Sender: TObject);
begin
   PageControl.TabIndex:=1;
   AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
end;

procedure TorcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
end;


procedure TorcamentoF.FormShow(Sender: TObject);
begin
  inherited;
  DataModuleF.qryOrcamento.Open;
  lblDescrCli.Caption := '';
end;

end.

