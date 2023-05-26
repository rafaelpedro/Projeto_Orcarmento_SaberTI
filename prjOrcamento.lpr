program prjOrcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, cadModelo, menuPrincipal, cadCategoria, dataModule,
  cadCliente, cadProduto, cadUsuario, orcamento, cadItemOrc, pesqProd, pesqCli,
  relClientes, relProdutos, relOrcamentos, relCategorias, impressao, sobre,
  login
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TLoginF, LoginF);
  Application.CreateForm(TMenuPrincipalF, MenuPrincipalF);
  Application.CreateForm(TcadModeloF, cadModeloF);
  Application.CreateForm(TDataModuleF, DataModuleF);
  Application.Run;
end.

