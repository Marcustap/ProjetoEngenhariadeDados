SET DATESTYLE TO PostgreSQL,European;

CREATE SCHEMA Relacional;

CREATE SEQUENCE Relacional.IDveiculo;
CREATE TABLE Relacional.Veiculos(
	IDveiculo int default nextval('Relacional.IDveiculo'::regclass) PRIMARY KEY,
	DataAquisicao date,
	Ano int,
	Modelo varchar(50),
	Placa varchar(10),
	Status varchar(20),
	ValorDiaria numeric(10,2)
);

CREATE  SEQUENCE Relacional.IDcliente;
CREATE TABLE Relacional.Clientes(
	IDcliente int default nextval('Relacional.IDcliente'::regclass) PRIMARY KEY,
	Nome varchar(50),
	DataNascimento date,
	Telefone varchar(20),
	Status varchar(15),
	CPF varchar(20),
	NumeroCNH varchar(20)
);

CREATE SEQUENCE Relacional.IDdespachante;
CREATE TABLE Relacional.Despachantes(
	IDdespachante int default nextval('Relacional.IDdespachante'::regclass) PRIMARY KEY,
	Nome varchar(50),
	Status varchar(15),
	Filial varchar(20)
);

CREATE SEQUENCE Relacional.IDlocacao;
CREATE TABLE Relacional.Locacao(
	IDlocacao int default nextval('Relacional.IDlocacao'::regclass) PRIMARY KEY,
	IDveiculo int references Relacional.Veiculos (IDveiculo),
	IDcliente int references Relacional.Clientes (IDcliente),
	IDdespachante int references Relacional.Despachantes (IDdespachante),
	DataLocacao date,
	DataEntrega date,
	ValorTotal numeric(10,2)
);
