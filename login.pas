unit login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, menuPrincipal, datamodule;

type

  { TLoginF }

  TLoginF = class(TForm)
    btnEntrar: TBitBtn;
    btnSair: TBitBtn;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    function ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
  private

  public

  end;

var
  LoginF: TLoginF;

implementation

{$R *.lfm}

{ TLoginF }

procedure TLoginF.btnEntrarClick(Sender: TObject);
begin
  if ValidaUsuario(edtUsuario.Text,edtSenha.Text) = True then
   begin
     MenuPrincipalF:= TMenuPrincipalF.create(Self);
     MenuPrincipalF.ShowModal;
   end;
end;

procedure TLoginF.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

function TLoginF.ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
begin
begin
   if (pUsusario = '') then
   begin
      ShowMessage('Favor Preencha o Usuário!');
      edtUsuario.SetFocus;
      Exit;
   end;

   if (pSenha = '') then
   begin
      ShowMessage('Favor Preencha a Senha!');
      edtSenha.SetFocus;
      Exit;
   end;

   DataModuleF.qryGenerica.Close;
   DataModuleF.qryGenerica.SQL.Clear;
   DataModuleF.qryGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER '+
                                   'FROM USUARIOS '+
                                   'WHERE USUARIO = ' +  QuotedStr(pUsusario) + ' ' +
                                   'AND SENHA = ' + QuotedStr(pSenha));
   DataModuleF.qryGenerica.Open;

   if DataModuleF.qryGenerica.FieldByName('NUMBER').AsInteger = 0 then
   Begin
      ShowMessage('Senha ou Usuário incorretos!');
      edtUsuario.SetFocus;
      Result := False
   end
   else
      Result := True;

end;

end;

end.

