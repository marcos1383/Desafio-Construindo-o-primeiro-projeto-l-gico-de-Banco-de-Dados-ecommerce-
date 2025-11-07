use ecommerce;

-- Persistindo os dados na tabela Cliente
insert into cliente (Pnome, NomeMeio, Sobrenome, Documento, Endereco, DataNascimento) values
('João','de','Oliveira', 070923457 ,'qn 33 conj 2 lt 4', '1943-04-23'),
('Daniel','de','Aparecida', 089323457 ,'qn 12 conj 3 lt 23', '1988-07-27'),
('Felipe','da','Cruz', 339765237 ,'qn 30 conj 13 lt 26', '1995-09-03'),
('Anita','dos','Santos', 089765767 ,'qn 6 conj 23 lt 103', '1987-11-29'),
('Leonardo','de','Caprio', 046923457 ,'qn 86 conj 24 lt 48', '1970-12-13'),
('Davi','de','Oliveira', 089763837 ,'qn 85 conj 53 lt 33', '1956-06-23'),
('Nicolas','de','Aparecida', 086851457 ,'qn 64 conj 83 lt 13', '1980-09-12'),
('Lucas','do','Nascimento', 089668457 ,'qn 54 conj 35 lt 33', '1986-02-14'),
('Thais','de','Oliveira', 089765212 ,'qn 1 conj 22 lt 140', '1994-06-19');
select * from cliente;

update cliente
set documento = documento + 

-- Persistindo os dados na tabela Pedido
insert into pedido (idPedido_cliente, EstatusPedido, descricao, frete) values
(2, 'Enviado', 'Bola de futsal', 54.90),
(5, default, 'Chuteira umbro', 254.90),
(1, 'Processando', 'Luva de Goleiro M', 44.90),
(6, default, 'Bomba d´bola', 24.90);
select * from pedido;

-- Persistindo os dados na tabela Estoque
insert into Estoque (localizacao, quantidade) values
('Brasília', 4),
('Goiania', 2),
('São Paulo', 8),
('Rio de Janeiro', 3);
select * from estoque;

-- Persistindo os dados na tabela Fornecedor
insert into Fornecedor (razaoSocial, cnpj, endereco, contato) values
('DF Atacadista', '12323450000543', 'Asa Sul 503, lote 13', '6133013568'),
('Super atacadao', '12333453000543', 'Asa Norte 710, lote 180', '6122013124');
select * from fornecedor;


-- Persistindo os dados na tabela Produto
insert into Produto (categoria, descricao, valor) values
('Futebol', 'Bola de futsal', 54.90),
('Futebol', 'Chuteira umbro', 254.90),
('Futebol', 'Luva de Goleiro M', 44.90),
('Futebol', 'Luva de Goleiro P', 44.90),
('Futebol', 'Luva de Goleiro M', 44.90),
('Diversos', 'Bomba d´bola', 24.90);
select * from produto;


-- Persistindo os dados na tabela Terceiro_Vendedor
insert into terceiro_vendedor (razaosocial, localidade, nomesocial, cnpj, cpf) values
('Diogo Reis', 'São Paulo', 'Diogo', null , 075422483),
('Fernanda Rodrigues', 'Goiania', 'Fernanda', null , 173987456)
;
select * from terceiro_vendedor;


-- Persistindo na tabela entre Pedido e Produto
insert into produto_pedido(Pedido_idPedido, Produto_idProduto, quantidade, pstatus) values
(2,1, 4, default),
(1,3, 6, default),
(4,2, 2, default),
(2,3, 1, default);
select * from produto_pedido;


-- Persistindo na tabela entre terceiro_vendedor e Produto
insert into produtos_vendedor (Vendedor_idTerceiro, Produto_idproduto, quantidade) values
(1,1,2),
(1,3,1),
(2,2,2),
(1,3,4);
select * from produtos_vendedor;


-- Persistindo na tabela entre fornecedor e Produto
insert into Produto_Fornecedor (Fornecedor_idFornecedor, Produto_idProduto, quantidade) values
(1,1,11),
(1,3,4),
(2,2,7),
(2,3,3);
select * from Produto_Fornecedor;

-- Persistindo na tabela entre Estoque e Produto
insert into Produto_em_Estoque (Estoque_idEstoque, Produto_idProduto,quantidade) values
(1,1,2),
(2,3,4),
(3,2,7),
(4,3,12);
select * from Produto_em_Estoque;