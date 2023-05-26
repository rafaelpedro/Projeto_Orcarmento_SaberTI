unit cadItemOrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, pesqProd, dataModule;

type

  { TcadItemOrcF }

  TcadItemOrcF = class(TForm)
    btnInserir: TBitBtn;
    btnCancelar: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
    procedure DBEdit4Change(Sender: TObject);
    procedure DBEdit5Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

var
  cadItemOrcF: TcadItemOrcF;

implementation

{$R *.lfm}

uses
  orcamento;

{ TcadItemOrcF }

procedure TcadItemOrcF.btnCancelarClick(Sender: TObject);
begin
  orcamentoF.dsOrcamentoItem.DataSet.Cancel;
  Close;
end;

procedure TcadItemOrcF.btnInserirClick(Sender: TObject);
begin
  if DataModuleF.qryOrcamentoItemqt_produto.AsFloat = 0 then
  begin
    ShowMessage('Quantidade deve ser preenchida!');
    Exit;
  end;
  //OrcamentoF.dsOrcamentoItem.DataSet.Post;
  close;
end;

procedure TcadItemOrcF.DBEdit3Change(Sender: TObject);
begin

end;

procedure TcadItemOrcF.DBEdit4Change(Sender: TObject);
begin
  DBEdit4.MaxLength:=6;
end;

procedure TcadItemOrcF.DBEdit5Change(Sender: TObject);
begin

end;

procedure TcadItemOrcF.FormShow(Sender: TObject);
begin
  {DataModuleF.qryProduto.Open;
  DataModuleF.qryOrcamento.Open;
  DataModuleF.qryOrcamentoItem.Open;}
end;


procedure TcadItemOrcF.SpeedButton1Click(Sender: TObject);
begin
  pesqProdF := TpesqProdF.Create(Self);
  pesqProdF.ShowModal;
end;

end.

