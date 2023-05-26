unit relProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, relClientes, LR_DSet;

type

  { TrelProdutosF }

  TrelProdutosF = class(TrelClientesF)
    procedure btnAbrirRelatorioClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure frDBClientesCheckEOF(Sender: TObject; var Eof: Boolean);
  private

  public

  end;

var
  relProdutosF: TrelProdutosF;

implementation

{$R *.lfm}

{ TrelProdutosF }

procedure TrelProdutosF.btnAbrirRelatorioClick(Sender: TObject);
begin
  frReportCliente.LoadFromFile('RelProduto.lrf');
  frReportCliente.PrepareReport;
  frReportCliente.ShowReport;
end;

procedure TrelProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=cafree;
end;

procedure TrelProdutosF.frDBClientesCheckEOF(Sender: TObject; var Eof: Boolean);
begin

end;

end.

