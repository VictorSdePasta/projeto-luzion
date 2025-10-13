create database luzion;
use luzion;
create table empresa(
	idEmpresa int primary key auto_increment,
    razaosocial varchar(100) not null,
    nomefantasia varchar (100) default null,
    cnpj char(14) not null,
    contratoativo tinyint(1) not null
);
create table filial(
	idFilial int primary key auto_increment,
    nome varchar(100) not null,
    empresa_idempresa int,
    constraint fkEmpresa foreign key (empresa_idempresa) references empresa(idEmpresa)
);
create table endereco(
	idEndereco int primary key auto_increment,
    logradouro varchar(100) not null,
    numero char(6) not null,
    complemento varchar(100) default null,
    cidade varchar(100),
    uf char(2),
    cep char(9) not null,
    filial_idfilial int,
    constraint fkFilial foreign key (filial_idfilial) references filial(idFilial)
);
create table funcionario(
	idFuncionario int primary key auto_increment,
    nome varchar(100) not null,
    email varchar(70) not null,
    telefone char(11),
    senha varchar(45) not null,
    filial_idfilial int,
    constraint fkFunFilial foreign key (filial_idfilial) references filial(idFilial)
);
create table areas(
	idAreas int primary key auto_increment,
    setor varchar(45),
    filial_idfilial int,
    constraint fkArFilial foreign key (filial_idfilial) references filial(idFilial)
);
create table banheiro(
	idBanheiro int primary key auto_increment,
    nome varchar(45),
    areas_idareas int,
    constraint fkAreas foreign key (areas_idareas) references areas(idAreas)
);
create table estoque(
	idEstoque int primary key auto_increment,
    nome varchar(45)
);
create table sensor(
	idSensor int primary key auto_increment,
    nome varchar(45),
    banheiro_idbanheiro int,
    constraint fkBanheiro foreign key (banheiro_idbanheiro) references banheiro(idBanheiro),
    estoque_idestoque int,
    constraint fkEstoque foreign key (estoque_idestoque) references estoque(idEstoque)
);
create table eventos(
	idEventos int primary key auto_increment,
    registro int,
    dtRegistro datetime,
    sensor_idsensor int,
    constraint fkSensor foreign key (sensor_idsensor) references sensor(idSensor)
);
insert into empresa (razaosocial, cnpj, contratoativo) values
	('sengasLTDA',),
	(),
	(),
	();