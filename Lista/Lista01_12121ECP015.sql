-- Bancos de Dados - FEELT - Engenharia de Computação
-- Aluno: Pedro Henrique Fujinami Nishida
-- Matrícula: 12111ECP002
-- 11/04/2023

-- QUESTÃO 1:
-- connlimit já é imilitado por padrão
-- CREATE DATABASE LISTA_01;

-- QUESTÃO 2:
CREATE SCHEMA empresa;

-- QUESTÃO 3:
-- ANALISANDO O MODELO TB_FUNCIONARIOS DEPENDE DE TB_DEPARTAMENTO ENTÃO COMEÇA POR:
CREATE TABLE empresa.tb_departamentos(
	id_departamento INT,
	
	nome 			VARCHAR(60)   CONSTRAINT nn_nome_dpto 	 NOT NULL,
	cidade 			VARCHAR(40)   CONSTRAINT nn_cidade_dpto  NOT NULL,
	fg_ativo 		INTEGER,	  --anotação de estudante:
	CONSTRAINT pk_tb_departamentos_id_departamento PRIMARY KEY(id_departamento)
);

CREATE TABLE empresa.tb_funcionarios(
	id_funcionario INT,
	
	nome 	       VARCHAR(60) CONSTRAINT nn_nome_funcionario NOT NULL,
	id_gerente	   INT,        -- Um gerente não tem gerente -> pode ser NULL
	id_departamento INT		   CONSTRAINT nn_id_departamento_func     NOT NULL,
	dt_nascimento  DATE 	   CONSTRAINT nn_data_nascimento_func   NOT NULL,
	salario		   NUMERIC     CONSTRAINT nn_salario_func 	  NOT NULL,
	cargo 		   VARCHAR(60) CONSTRAINT nn_cargo_func 	  NOT NULL,
	fg_ativo 	   INT,
	CONSTRAINT pk_tb_funcionarios_id_funcionario PRIMARY KEY(id_funcionario),
	CONSTRAINT fk_tb_funcionarios_id_gerente 	 FOREIGN KEY(id_gerente)
		REFERENCES empresa.tb_funcionarios(id_funcionario),
	CONSTRAINT fk_tb_funcionarios_id_departamento FOREIGN KEY(id_departamento)
		REFERENCES empresa.tb_departamentos(id_departamento)
);

CREATE TABLE empresa.tb_grade_salario(
	id_salario 	INT,
	
	min_salario NUMERIC CONSTRAINT nn_min_salario NOT NULL,
	max_salario NUMERIC CONSTRAINT nn_max_salario NOT NULL,
	fg_ativo 	INT,
	CONSTRAINT pk_tb_grade_salario_id_salario PRIMARY KEY(id_salario)
);

-- QUESTÃO  3:
INSERT INTO empresa.tb_departamentos(id_departamento, nome, cidade, fg_ativo) --mesmo opcional, coloquei os parametros como metodo de engenharia de software.
VALUES
(1, 'Recursos Humanos', 'São Paulo', 1),
(2, 'Finanças', 'Rio de Janeiro', 1),
(3, 'Tecnologia da Informação', 'Belo Horizonte', 1),
(4, 'Marketing', 'Porto Alegre', 1),
(5, 'Vendas', 'Curitiba', 0),
(6, 'Logística', 'Salvador', 1),
(7, 'Atendimento ao Cliente', 'Recife', 1),
(8, 'Compras', 'Fortaleza', 1),
(9, 'Engenharia', 'Manaus', 1),
(10, 'Pesquisa e Desenvolvimento', 'Brasília', 1),
(11, 'Jurídico', 'Florianópolis', 1),
(12, 'Administrativo', 'Vitória', 1),
(13, 'Qualidade', 'Natal', 1),
(14, 'Segurança', 'Goiânia', 1),
(15, 'Produção', 'Maceió', 1);

-- inserindo os funcionários e gerentes
INSERT INTO empresa.tb_funcionarios(id_funcionario, nome, id_gerente, id_departamento, dt_nascimento, salario, cargo, fg_ativo)
VALUES

(1, 'João Silva', NULL, 1, '1975-06-20', 10500, 'Gerente de Recursos Humanos', 1), -- gerente
(2, 'Maria Pereira', 1, 1, '1990-08-15', 7000, 'Analista de RH', 1),
(3, 'Roberto Souza', 1, 1, '1987-12-07', 6500, 'Analista de RH', 1),
(4, 'Carla Oliveira', NULL, 2, '1980-01-30', 12000, 'Gerente Financeiro', 1), -- gerente
(5, 'Ricardo Santos', 4, 2, '1992-06-25', 8500, 'Analista Financeiro', 1),
(6, 'Patrícia Lima', 4, 2, '1993-11-10', 8500, 'Analista Financeiro', 1),
(7, 'Fernando Gomes', NULL, 3, '1979-04-12', 15000, 'Gerente de TI', 1), -- gerente
(8, 'Beatriz Almeida', 7, 3, '1995-09-22', 9500, 'Desenvolvedor', 1),
(9, 'Lucas Costa', 7, 3, '1998-02-14', 9000, 'Desenvolvedor', 1),
(10, 'Ana Paula Dias', NULL, 4, '1986-05-28', 11000, 'Gerente de Marketing', 1), --gerente
(11, 'Pedro Fernandes', 10, 4, '1991-10-03', 7500, 'Especialista em Marketing', 1),
(12, 'Aline Ribeiro', 10, 4, '1994-03-15', 7000, 'Especialista em Marketing', 1),
(13, 'Eduardo Araújo', NULL, 5, '1982-07-21', 9000, 'Gerente de Vendas', 0), --gerente
(14, 'Mariana Castro', 13, 5, '1996-12-05', 5000, 'Vendedor', 0),
(15, 'Bruno Martins', 13, 5, '1997-01-19', 5000, 'Vendedor', 0),
(16, 'Pedro Nishida', 7, 10, '2004-01-06', 1501, 'estagiario TI', 1);

-- salario por cargo	
INSERT INTO empresa.tb_grade_salario(id_salario, min_salario, max_salario, fg_ativo)
VALUES
(1, 4500, 5999.99, 1), -- Vendedor
(2, 6000, 7499.99, 1), -- Especialista em Marketing, Analista Financeiro, Analista de RH
(3, 7500, 8999.99, 1), -- Desenvolvedor
(4, 9000, 10499.99, 1), -- Gerente de Vendas
(5, 10500, 11999.99, 1), -- Gerente de Recursos Humanos, Gerente de Marketing, Gerente Financeiro
(6, 12000, 15000, 1); -- Gerente de TI

-- Questão 4:
SELECT (id_funcionario, id_departamento, nome, cargo, dt_nascimento, salario, fg_ativo) AS SAÍDA FROM empresa.tb_funcionarios;

-- Questão 5:
SELECT * FROM empresa.tb_funcionarios
WHERE salario < 1500 OR salario > 2850;

-- Questão 6:
SELECT nome AS "Funcionário", salario AS "Salário Mensal"
FROM empresa.tb_funcionarios
WHERE salario > 1500 AND (id_departamento = 10 OR id_departamento = 30); -- apesar de não ter montato id_departamento ate 30

-- Questão 7:
SELECT nome
FROM empresa.tb_funcionarios
WHERE (id_departamento = 30 AND LENGTH(nome) - LENGTH(REPLACE(UPPER(nome), 'A', '')) = 2) OR id_gerente = 7782;
-- apesar dos registros feitos não chegar a isso