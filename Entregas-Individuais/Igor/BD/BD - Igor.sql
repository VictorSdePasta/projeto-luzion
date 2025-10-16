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
    nome varchar(45),
    filial_idfilial int,
    constraint fkEsFilial foreign key (filial_idfilial) references filial(idFilial)
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
	('Facilidade LTDA', '00000000000011', 1),
	('Facilitando LTDA', '00000000000022', 0),
	('Extremamente Facil LTDA', '00000000000033', 2),
	('Mais facilidade LTDA', '00000000000044', 1);
insert into filial (nome, empresa_idempresa) values
	('Sengas', 4),
    ('Smart Beef', 1),
    ('Armory Safe', 1),
    ('Neo Guard', 4);
insert into endereco (logradouro, numero, cidade, uf, cep, filial_idfilial) values
	('Rua das Laranjas', '1001', 'São Paulo', 'SP', '00000-000', 1),
	('Rua dos Limões', '2002', 'Recife', 'PE', '00000-001', 2),
	('Rua das Ameixas', '3003', 'Tatuí', 'SP', '00000-002', 3),
	('Rua das Peras', '4004', 'São Paulo', 'SP', '00000-003', 4);
insert into funcionario (nome, email, telefone, senha, filial_idfilial) values
	('João', 'joao@facilidade.com', '11999999999', 'senha123', 1),
	('Paulo', 'paulo@facilitando.com', '81999998888', 'senha123', 2),
	('Maria', 'maria@extremamentefacil.com', '15999997777', 'senha123', 3),
	('Marta', 'marta@maisfacilidade.com', '11999996666', 'senha123', 4);
insert into areas (setor, filial_idfilial) values
	('Administrativo', 1),
	('Administrativo', 2),
	('Administrativo', 3),
	('Administrativo', 4),
	('Recepção', 1),
	('Recepção', 2),
	('Recepção', 3),
	('Recepção', 4),
	('Produção', 1),
	('Armazenamento', 2),
	('Armazenamento', 3),
	('Berçario', 4);
insert into banheiro (nome, areas_idareas) values
	('Banheiro1', 1),
	('Banheiro1', 2),
	('Banheiro1', 3),
	('Banheiro1', 4),
	('Banheiro1', 5),
	('Banheiro1', 6),
	('Banheiro1', 7),
	('Banheiro1', 8),
	('Banheiro1', 9),
	('Banheiro1', 10),
	('Banheiro1', 11),
	('Banheiro1', 12),
	('Banheiro2', 1),
	('Banheiro2', 2),
	('Banheiro2', 3),
	('Banheiro2', 4),
	('Banheiro2', 5),
	('Banheiro2', 6),
	('Banheiro2', 7),
	('Banheiro2', 8),
	('Banheiro2', 9),
	('Banheiro2', 10),
	('Banheiro2', 11),
	('Banheiro2', 12),
	('Banheiro3', 9),
	('Banheiro4', 9),
	('Banheiro5', 9);
insert into estoque (nome, filial_idfilial) values
	('Estoque Sengas', 1),
	('Estoque Smart Beef', 2),
	('Estoque Armory Safe', 3),
	('Estoque Neo Guard', 4);
