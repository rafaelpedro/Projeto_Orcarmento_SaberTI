unit relCategorias;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, relProdutos;

type

  { TrelCategoriasF }

  TrelCategoriasF = class(TrelProdutosF)
    procedure btnAbrirRelatorioClick(Sender: TObject);
  private

  public

  end;

var
  relCategoriasF: TrelCategoriasF;

implementation

{$R *.lfm}

{ TrelCategoriasF }

procedure TrelCategoriasF.btnAbrirRelatorioClick(Sender: TObject);
begin
  frReportCliente.LoadFromFile('RelCategoria.lrf');
  frReportCliente.PrepareReport;
  frReportCliente.ShowReport;
end;

end.

