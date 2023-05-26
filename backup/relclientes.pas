unit relClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet, dataModule, DB;

type

  { TrelClientesF }

  TrelClientesF = class(TForm)
    btnAbrirRelatorio: TBitBtn;
    frDBClientes: TfrDBDataSet;
    frReportCliente: TfrReport;
    procedure btnAbrirRelatorioClick(Sender: TObject);
  private

  public

  end;

var
  relClientesF: TrelClientesF;

implementation

{$R *.lfm}

{ TrelClientesF }

procedure TrelClientesF.btnAbrirRelatorioClick(Sender: TObject);
begin
   frReportCliente.LoadFromFile('RelCliente.lrf');
   frReportCliente.PrepareReport;
   frReportCliente.ShowReport;
end;

end.

