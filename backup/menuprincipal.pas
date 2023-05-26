unit menuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls, cadCategoria, cadCliente, cadProduto, cadUsuario, orcamento, relClientes, relCategorias, relOrcamentos, relProdutos, sobre;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    cadCategoria: TMenuItem;
    cadCliente: TMenuItem;
    cadProduto: TMenuItem;
    cadUsuario: TMenuItem;
    Categoria: TMenuItem;
    relOrcamentos: TMenuItem;
    relProdutos: TMenuItem;
    relClientes: TMenuItem;
    vendOrcamento: TMenuItem;
    Separator1: TMenuItem;
    procedure cadCategoriaClick(Sender: TObject);
    procedure cadClienteClick(Sender: TObject);
    procedure cadProdutoClick(Sender: TObject);
    procedure cadUsuarioClick(Sender: TObject);
    procedure CategoriaClick(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure relClientesClick(Sender: TObject);
    procedure relOrcamentosClick(Sender: TObject);
    procedure relProdutosClick(Sender: TObject);
    procedure vendOrcamentoClick(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipalF: TMenuPrincipalF;

implementation

{$R *.lfm}

{ TMenuPrincipalF }

procedure TMenuPrincipalF.cadCategoriaClick(Sender: TObject);
begin
  //aqui será chamado a tela de cadastro de categoria
  cadCategoriaF := TcadCategoriaF.Create(Self);
  cadCategoriaF.ShowModal;

end;

procedure TMenuPrincipalF.cadClienteClick(Sender: TObject);
begin
  cadClienteF := TcadClienteF.Create(Self);
  cadClienteF.ShowModal;
end;

procedure TMenuPrincipalF.cadProdutoClick(Sender: TObject);
begin
  cadProdutoF := TcadProdutoF.Create(Self);
  cadProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.cadUsuarioClick(Sender: TObject);
begin
  cadUsuarioF := TcadUsuarioF.Create(Self);
  cadUsuarioF.ShowModal;
end;

procedure TMenuPrincipalF.CategoriaClick(Sender: TObject);
begin
  relCategoriasF := TrelCategoriasF.Create(Self);
  relCategoriasF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItem4Click(Sender: TObject);
begin
  SobreF := TSobreF.Create(Self);
  SobreF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItem5Click(Sender: TObject);
begin
  Close;
end;

procedure TMenuPrincipalF.relClientesClick(Sender: TObject);
begin
  relClientesF := TrelClientesF.Create(Self);
  relClientesF.ShowModal;
end;

procedure TMenuPrincipalF.relOrcamentosClick(Sender: TObject);
begin
  relOrcamentosF := TrelOrcamentosF.Create(Self);
  relOrcamentosF.ShowModal;
end;

procedure TMenuPrincipalF.relProdutosClick(Sender: TObject);
begin
  relProdutosF := TrelProdutosF.Create(Self);
  relProdutosF.ShowModal;
end;

procedure TMenuPrincipalF.vendOrcamentoClick(Sender: TObject);
begin
  OrcamentoF := TOrcamentoF.Create(Self);
  OrcamentoF.ShowModal;
end;

end.

