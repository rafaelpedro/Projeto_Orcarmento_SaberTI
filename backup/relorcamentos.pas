unit relOrcamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, relProdutos;

type

  { TrelOrcamentosF }

  TrelOrcamentosF = class(TrelProdutosF)
    procedure btnAbrirRelatorioClick(Sender: TObject);
  private

  public

  end;

var
  relOrcamentosF: TrelOrcamentosF;

implementation

{$R *.lfm}

{ TrelOrcamentosF }

procedure TrelOrcamentosF.btnAbrirRelatorioClick(Sender: TObject);
begin
  frReportCliente.LoadFromFile('RelOrcamento.lrf');
  frReportCliente.PrepareReport;
  frReportCliente.ShowReport;
end;

end.

