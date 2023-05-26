unit cadModelo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  DBGrids, StdCtrls, Buttons, dataModule;

type

  { TcadModeloF }

  TcadModeloF = class(TForm)
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    btnNovo: TBitBtn;
    btnBuscar: TBitBtn;
    DBGrid1: TDBGrid;
    edtBuscar: TEdit;
    Label1: TLabel;
    PageControl: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    tabPesquisa: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    tabCadastro: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private

  public

  end;

var
  cadModeloF: TcadModeloF;

implementation

{$R *.lfm}

{ TcadModeloF }

procedure TcadModeloF.PageControlChange(Sender: TObject);
begin

end;

procedure TcadModeloF.btnNovoClick(Sender: TObject);
begin
   PageControl.TabIndex:= 1;
end;

procedure TcadModeloF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TcadModeloF.FormShow(Sender: TObject);
begin
  PageControl.TabIndex:= 0;
end;

procedure TcadModeloF.btnCancelarClick(Sender: TObject);
begin
  PageControl.TabIndex:= 0;
end;

procedure TcadModeloF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.

