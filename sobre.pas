unit sobre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TSobreF }

  TSobreF = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  SobreF: TSobreF;

implementation

{$R *.lfm}

{ TSobreF }

procedure TSobreF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=cafree;
end;

end.

