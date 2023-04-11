CREATE SCHEMA matriz;

-- Criando a tabela de clientes
CREATE TABLE matriz.tb_cliente (
  id_cliente 	INTEGER,
  titulo 	CHAR(4),
  nome 		VARCHAR(32) 	CONSTRAINT nn_nome 		 NOT NULL,
  sobrenome 	VARCHAR(32) CONSTRAINT nn_sobrenome  NOT NULL,
  endereco	VARCHAR(62) 	CONSTRAINT nn_endereco 	 NOT NULL,
  numero	VARCHAR(5)  	CONSTRAINT nn_numero 	 NOT NULL, 
  complemento	VARCHAR(62),
  cep		VARCHAR(10),
  cidade	VARCHAR(62) 	CONSTRAINT nn_cidade 	 NOT NULL,
  estado	CHAR(2)     	CONSTRAINT nn_estado 	 NOT NULL,
  fone_fixo	VARCHAR(15) 	CONSTRAINT nn_fone_fixo  NOT NULL,
  fone_movel	VARCHAR(15) CONSTRAINT nn_fone_movel NOT NULL,
  fg_ativo 	INTEGER,
  CONSTRAINT pk_id_cliente PRIMARY KEY(id_cliente)
);

INSERT INTO matriz.tb_cliente(id_cliente, titulo, nome, sobrenome, endereco, numero, complemento, cep, cidade, 
							  estado, fone_fixo, fone_movel, fg_ativo) 
VALUES
(1, 'Sra', 'Jessica', 'Mendes', 'Avenida Acelino de Leao', '89', NULL, '68900 300', 'Macapá', 'AP', 
 '3565 1243', '8765 8999' ,1)
 
INSERT INTO matriz.tb_cliente VALUES(2, 'Sr', 'Andrei', 'Junqueira', 'Rua Tabaiares', '1024', NULL, 
									 '30150 040', 'Belo Horizonte', 'BH', '3676 1209', '8876 4543', 1)

INSERT INTO matriz.tb_cliente (titulo, id_cliente, nome, sobrenome, endereco, numero, complemento, cep, cidade, 
							  estado, fone_fixo, fg_ativo, fone_movel)
VALUES 
('Sr', 3, 'Alex', 'Matheus', 'Rua Eva Terpins', 's/n', NULL, '05327 030', 'São Paulo', 'SP', 
 '6576 0099', 1, '9358 7676')
 
 
INSERT INTO matriz.tb_cliente(id_cliente, titulo, nome, sobrenome, endereco, numero, complemento, cep, cidade, 
							 estado, fone_fixo, fone_movel, fg_ativo) 
VALUES 
(4, 'Sr', 'Andre', 'Lopes', 'Rua Fortaleza', '552', NULL, '11436 360', 'Guarujá', 'SP', 
 '5654 4343', '9821 4321', 1),

(5, 'Sr', 'Vitor', 'Silva', 'Estrada Aguá Chata', 's/n', 'Rodovia 356', '07251 000', 'Guarulhos', 'SP', 
 '4343 6712', '831 3411', 1),

(6, 'Sr', 'Claudinei', 'Safra', 'Avenida José Osvaldo Marques', '1562', NULL, '14173 010', 
 'Sertãozinho', 'SP', '3698 8100', '8131 6409', 1),

(7, 'Sr', 'Ricardo', 'Ferreira', 'Alameda Assunta Barizani Tienghi', '88', NULL, '18046 705', 
 'Sorocaba', 'SP', '6534 7099', '9988 1251', 1);
 
 -- Atualizar um campo
 UPDATE matriz.tb_cliente SET cidade = 'Guarulhos' WHERE id_cliente = 2
 
 SELECT * FROM matriz.tb_cliente;
 
 -- Remover um registro
 DELETE FROM matriz.tb_cliente WHERE id_cliente = 7;
 
 -- Criando a tabela de pedidos
 
 CREATE TABLE matriz.tb_pedido (
  id_pedido 		INTEGER ,
  id_cliente 		INTEGER CONSTRAINT nn_id_cliente NOT NULL,
  dt_compra 		TIMESTAMP,
  dt_entrega 		TIMESTAMP,
  valor 			NUMERIC(7,2),
  fg_ativo 			INTEGER ,
  CONSTRAINT pk_id_pedido PRIMARY KEY(id_pedido),
  CONSTRAINT fk_ped_id_cliente FOREIGN KEY(id_cliente) 
    REFERENCES matriz.tb_cliente(id_cliente));

-- se o cliente não existir na tb_cliente, o insert do tb_pedido não funciona
INSERT INTO matriz.tb_pedido(id_pedido, id_cliente, dt_compra, dt_entrega, valor, fg_ativo)
VALUES
(2, 5,'06-23-2023','06-24-2023', 0.00, 1),
(3, 4,'02-09-2023','12-09-2023', 3.99, 1),
(4, 3,'03-09-2023','10-09-2023', 2.99, 1),
(5, 2,'07-21-2023','07-21-2023', 0.00, 1);

SELECT * FROM matriz.tb_cliente;
 

-- Criando a tabela de itens
CREATE TABLE matriz.tb_item (
  id_item 	INTEGER,
  ds_item 	VARCHAR(64) CONSTRAINT nn_ds_item NOT NULL,
  preco_custo 	NUMERIC(7,2),
  preco_venda 	NUMERIC(7,2),
  fg_ativo 	INTEGER,
  CONSTRAINT pk_id_item PRIMARY KEY(id_item)
);

-- Inserindo tuplas: tb_item
INSERT INTO matriz.tb_item(id_item, ds_item, preco_custo, preco_venda, fg_ativo) 
VALUES
(1, 'Quebra-cabeça de Madeira', 15.23, 21.95, 1),
(2, 'Cubo X', 7.45, 11.49, 1),
(3, 'CD Linux', 1.99, 2.49, 1),
(4, 'Tecidos', 2.11, 3.99, 1),
(5, 'Moldura', 7.54, 9.95, 1),
(6, 'Ventilador Pequeno', 9.23, 15.75, 1);

INSERT INTO aulas.tb_item(id_item, ds_item, preco_custo, preco_venda, fg_ativo) 
VALUES
(7, 'Ventilador Grande', 13.36, 19.95, 1),
(8, 'Escova de Dentes', 0.75, 1.45, 1),
(9, 'Papel A4', 2.34, 2.45, 1),
(10, 'Saco de Transporte', 0.01, 0.0, 1),
(11, 'Alto-Falantes', 19.73, 25.32, 1);


 
 CREATE TABLE matriz.tb_item_pedido (
  id_item 				INTEGER,
  id_pedido 			INTEGER,
  quantidade 			INTEGER,
  CONSTRAINT pk_item_pedido PRIMARY KEY(id_item, id_pedido),
  CONSTRAINT fk_ped_id_item FOREIGN KEY(id_item) 
    		REFERENCES matriz.tb_item(id_item),
  CONSTRAINT fk_ped_id_pedido FOREIGN KEY(id_pedido) 
    		REFERENCES matriz.tb_pedido(id_pedido));
 
INSERT INTO matriz.tb_item_pedido(id_pedido, id_item, quantidade) 
VALUES
(1, 4, 1),
(1, 2, 1),
(1, 5, 1),
(2, 1, 1),
(2, 6, 1)
 
CREATE TABLE matriz.tb_transportadora (

);



 
 