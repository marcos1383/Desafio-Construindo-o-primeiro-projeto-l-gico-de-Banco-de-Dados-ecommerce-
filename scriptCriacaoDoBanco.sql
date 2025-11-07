create schema if not exists ecommerce;
use ecommerce;

-- criação da tabela cliente
show tables ;
create table Cliente(
	idCliente int auto_increment not null,
    Pnome varchar(10) not null,
    NomeMeio varchar(3),
    Sobrenome varchar(20),
    Documento varchar(14) not null,
    Endereco varchar(45),
    DataNascimento date not null,
    primary key (idCliente),
    constraint unique_cliente_cpf unique (CPF)
);
select * from cliente;
    
-- criação da tabela pedido
create table Pedido(
	idPedido int auto_increment not null,
    idPedido_cliente int,
    EstatusPedido ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
    Descricao varchar(45),
    Frete Float,
    FormaPagamento enum('Dinheiro', 'Pix', 'Crédito', 'Débito') default'Pix',
    Primary key (idPedido) ,
    constraint fk_pedido foreign key (idPedido_cliente) references Cliente(idCliente)
);
select * from pedido;


-- criação da tabela produto
create table Produto(
	idProduto int auto_increment not null,
    Categoria varchar(45) not null,
    Descricao varchar(45),
    Valor float not null,
    primary key (idProduto)    
);
select * from produto;

-- criação da tabela terceiro_vendedor
create table Terceiro_Vendedor(
	idTerceiroVendedor int auto_increment not null,
    RazaoSocial varchar(45) not null,
    Localidade varchar(45),
    NomeSocial varchar(45),
	CNPJ char(11),
    CPF char(9),
    primary key (idTerceiroVendedor),
    constraint unique_TerceiroVendedor_Razao unique (RazaoSocial),
    constraint unique_TerceiroVendedor_CNPJ unique (CNPJ),
    constraint unique_TerceiroVendedor_CPF unique (CPF)
);

-- criação da tabela fornecedor 
create table Fornecedor(
	idFornecedor int auto_increment not null,
	RazaoSocial varchar(45) not null,
    CNPJ char(45) not null,
	Endereco varchar(45) not null,
    Contato char(11) not null,
    primary key(idFornecedor),
    constraint unique_Fornecedor unique (CNPJ)
);
select * from fornecedor;

-- criação da tabela estoque
create table estoque(
	idEstoque int auto_increment not null,
    Localizacao varchar(45),
    Quantidade int,
    primary key(idEstoque)
);
select * from estoque;

-- Ligação entre Pedido e Produto
create table Produto_Pedido(
	Pedido_idPedido int,
	Produto_idProduto int,
	Quantidade int not null,
    Pstatus ENUM('Disponivel', 'Sem estoque') default 'Disponível',
    constraint fk_Produto_Pedido_idPedido foreign key (Pedido_idPedido) references Pedido(idPedido),
    constraint fk_Produto_Pedido_idProduto foreign key (Produto_idProduto) references Produto(idProduto)
);
select * from produto_pedido;

-- Ligação entre terceiro_vendedor e Produto
create table Produtos_Vendedor(
	Vendedor_idTerceiro int ,
	Produto_idProduto int,
    Quantidade int not null,
    constraint fk_ProdutosVendedor_Vendedor foreign key (Vendedor_idTerceiro) references Terceiro_Vendedor(idTerceiroVendedor),
    constraint fk_ProdutosVendedor_Produto foreign key (Produto_idProduto) references Produto(idProduto)
);

-- Ligação entre fornecedor e Produto
create table Produto_Fornecedor(
	Fornecedor_idFornecedor int,
	Produto_idProduto int,
    Quantidade int not null,
    constraint fk_ProdutoFornecedor_Fornecedor foreign key (Fornecedor_idFornecedor) references Fornecedor(idFornecedor),
    constraint fk_ProdutoFornecedor_Produto foreign key (Produto_idProduto) references Produto(idProduto)
);
select * from produto_fornecedor;

-- Ligação entre Estoque e Produto
create table Produto_em_Estoque(
	Estoque_idEstoque int,
	Produto_idProduto int,
    Quantidade int not null,
    constraint fk_ProdutoEmEstoque_Estoque foreign key (Estoque_idEstoque) references Estoque(idEstoque),
    constraint fk_ProdutoEmEstoque_Produto foreign key (Produto_idProduto) references Produto(idProduto)
);



--- --- -- DESAFIO --- --- ---

--- --- OBJETIVO 1: Refinamento, Através da primeira linha de codigo, alteramos o tipo de dados que a coluna pode receber, limitando ao tamanho máximo que seria CNPJ. ---
--- O statement a seguir, define através da clausula casee a condição para definir se o documento inserido corresponde a CPF ou CPNJ. ---

Alter table Cliente modify Documento char(14) ;

SELECT
    Documento, 
    CASE
        WHEN Documento < 10 THEN 'CNPJ'
        WHEN Documento > 9 THEN 'CPF'
        ELSE NULL
    END AS Documento
FROM
    Cliente;
    
--- OBJETIVO 2: Permitir as formas de pagamento, podendo ser dinheiro, pix, crédito ou débito --- 

alter table pedido add column FormaPagamento enum('Dinheiro', 'Pix', 'Crédito', 'Débito') default'Pix';
select * from pedido;


--- ------------------ PERGUNTAS --------------------- ---

--- Pedidos feitos pelos clientes ---
use ecommerce;
show tables;

select c.idcliente, (concat(pnome, ' ', sobrenome)) as cliente,documento, idPedido_cliente, estatuspedido, formapagamento, 
categoria, pro.descricao, valor
from cliente as c 
inner join pedido as p on c.idcliente = idPedido_cliente
inner join produto as pro 
order by cliente 
;


--- Algum vendedor também é fornecedor? ---
--- RESPOSTA: através do codigo abaixo, notamos que não há registro iguais em ambas as tabela---
select tv.razaosocial, tv.nomesocial, tv.cpf, f.cnpj 
from terceiro_vendedor as tv
inner join fornecedor as f on tv.razaosocial = f.razaosocial;


--- Relação de produtos_fornecedores e estoque ---
select pf.quantidade, e.idestoque, e.localizacao, e.quantidade from produto_fornecedor as pf
inner join estoque as e 
;


--- Relação de nomes dos fornecedores e nomes dos produtos ---
select idfornecedor, razaosocial, cnpj, quantidade, categoria, descricao, valor
from fornecedor inner join produto_fornecedor on idfornecedor = fornecedor_idfornecedor
inner join produto on fornecedor_idfornecedor = idproduto
order by idfornecedor;

