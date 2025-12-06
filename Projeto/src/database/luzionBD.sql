create database luzion;
use luzion;

create table Empresa (
  idEmpresa int primary key auto_increment,
  razaoSocial varchar(100) not null unique,
  nomeFantasia varchar(100) not null,
  cnpj char(14) not null unique,
  contrato tinyint,
  fkCliente int,
  constraint fkEmpresaCliente foreign key (fkCliente) references Empresa(idEmpresa)
);

insert into Empresa (razaoSocial,nomeFantasia,cnpj,contrato, fkCliente) values
('facilitariamos a sua vida LTDA','Facilitariamos TUDO','00300300300',2, null),
('facilitando serviços LTDA','Facilitadores Impecaveis','00100100100',0, null),
('servicos felicity LTDA','Felicity em te ajudar','00200200200',1,null),
('SenGases LTDA','SenGas','00900900900',3,1),
('SmartsBeefs LTDA','SmartBeef','00400400400',3,1),
('Vegetal Temperature Transformation Technology LTDA','V3T','00500500500',3,2),
('Armory Safe LTDA','Armory Safe','00600600600',3,2),
('Neoguard LTDA','NeoGuard','00700700700',3,1),
('Shopping do bairro LTDA','Shopping do bairro','00800800800',3,2);

create table Endereco (
  idEndereco int primary key auto_increment,
  logradouro varchar(200),
  numero varchar(5),
  cep char(8),
  estado varchar(35),
  uf char(2)
);

insert into Endereco (logradouro,numero,cep,estado,uf) values
('Rua Fácil','235','07070700','São Paulo','SP'),
('Rua Facilidade','128','08080800','São Paulo','SP'),
('Rua Facilimo','980','09090900','São Paulo','SP'),
('Rua Sem Gas','412','01010100','São Paulo','SP'),
('Rua do gado','2450','02020200','São Paulo','SP'),
('Avenida Vegetal','120','03030300','São Paulo','SP'),
('Rua Armada','300','04040400','São Paulo','SP'),
('Avenida Segura','216','05050500','São Paulo','SP'),
('Avenida do Bairro','123','06060600','São Paulo','SP');

create table Filial (
  idFilial int primary key auto_increment,
  titulo varchar(100),
  fkEmpresa int,
  constraint fkFilialEmpresa foreign key (fkEmpresa) references Empresa(idEmpresa),
  fkEndereco int,
  constraint fkFilialEndereco foreign key (fkEndereco) references Endereco(idEndereco)
);

insert into Filial (titulo,fkEmpresa,fkEndereco) values
('Sede Facilitariamos TUDO',1,1),
('Sede Facilitadores Impecaveis',2,2),
('Sede Felicity em te ajudar',3,3),
('Sede SenGas',4,4),
('Sede SmartBeef',5,5),
('Sede V3T',6,6),
('Sede Armory Safe',7,7),
('Sede NeoGuard',8,8),
('Shopping do Bairro',9,9);

create table Funcionario (
  idFuncionario int primary key auto_increment,
  nome varchar(100) not null,
  email varchar(100) not null unique,
  senha varchar(255) not null,
  telefone varchar(11),
  fkFilial int not null,
  constraint fkFuncionarioFilial foreign key (fkFilial) references Filial(idFilial)
);




insert into Funcionario (nome,email,senha,telefone,fkFilial) values
('Ana Luiza','ana.lu@facilitando.com','analu123','11010101000',1),
('Daner Quispe','daner.qu@facilitando.com','danerqu123','11020202000',1),
('Igor Dias','igor.di@facilitando.com','igordi123','11030303000',3,1),
('Reginaldo De Souza','reginaldo.so@felicity.com','reginaldoso123','11040404000',2),
('Victor David','victor.da@felicity.com','victorda123','11050505000',2),
('Victor Silva','victor.si@felicity.com','victorsi123','11060606000',2);

create table PapelHigienico (
  idPapelHigienico int primary key auto_increment,
  modelo varchar(45),
  diametroExternoMM int,
  diametroInternoMM int,
  larguraMM int
);

insert into PapelHigienico (modelo, diametroExternoMM, diametroInternoMM, larguraMM) values
('Comum', 135, 40, 100),
('Jumbo', 200, 60, 110),
('Folha Dupla', 110, 40, 100);

create table Banheiro (
  idBanheiro int primary key auto_increment,
  titulo varchar(100),
  setor varchar(100),
  fkFilial int,
  constraint fkBanheiroFilial foreign key (fkFilial) references Filial(idFilial)
);

insert into Banheiro (titulo, setor, fkFilial) values
('Ala Sul','Terreo',1),
('Ala Sul','Terreo',2),
('Ala Sul','Terreo',3),
('Ala Sul','Terreo',4),
('Ala Sul','Terreo',5),
('Ala Sul','Terreo',6),
('Ala Norte','Terreo',1),
('Ala Norte','Terreo',2),
('Ala Norte','Terreo',3),
('Ala Norte','Terreo',4),
('Ala Norte','Terreo',5),
('Ala Norte','Terreo',6),
('Ala Leste','Terreo',1),
('Ala Leste','Terreo',2),
('Ala Leste','Terreo',3),
('Ala Leste','Terreo',4),
('Ala Leste','Terreo',5),
('Ala Leste','Terreo',6),
('Ala Oeste','Terreo',6),
('1','Andar 1',1),
('2','Andar 1',2),
('3','Andar 1',3),
('1','Andar 2',2),
('1','Andar 2',3),
('1','Andar 2 - Funcionarios',6),
('2','Andar 2 - Publico',6),
('1','Andar 3',6);

create table Dispenser (
  idDispenser int primary key auto_increment,
  identificacao varchar(100),
  fkBanheiro int,
  constraint fkDispenserBanheiro foreign key (fkBanheiro) references Banheiro(idBanheiro),
  fkPapelHigienico int,
    constraint fkPapelDispenser foreign key (fkPapelHigienico) references PapelHigienico(idPapelHigienico)
);

insert into Dispenser (identificacao,fkBanheiro,fkPapelHigienico) values
('Cabine 1',1,1),
('Cabine 2',1,1),
('Cabine 3',1,1),
('Cabine 1',2,1),
('Cabine 2',2,1),
('Cabine 3',2,1),
('Cabine 4',2,1),
('Banheiro 1',3,2),
('Banheiro 2',3,2),
('Banheiro 3',3,2),
('Banheiro 4',3,2),
('Banheiro 5',3,2),
('Cabine 1',4,2),
('Cabine 2',4,2),
('Dispenser Geral',5,2),
('Cabine 1',6,2),
('Cabine 2',6,2),
('Cabine 3',6,2),
('Cabine 4',6,2),
('Cabine 5',6,2),
('Cabine 1',7,2),
('Cabine 2',7,2),
('Cabine 3',7,2),
('Cabine 4',7,2),
('Cabine 5',7,2),
('Cabine 1',8,2),
('Cabine 2',8,2),
('Cabine 3',8,2),
('Cabine 4',8,2),
('Cabine 5',8,2),
('Cabine 1',9,2),
('Cabine 2',9,2),
('Cabine 3',9,2),
('Cabine 1',10,2),
('Cabine 2',10,2),
('Banheiro 1',11,3),
('Banheiro 2',11,3),
('Banheiro 3',11,3),
('Cabine 1',12,1),
('Cabine 2',12,1),
('Banheiro 1',13,3),
('Banheiro 2',13,3),
('Banheiro 3',13,3),
('Cabine 1',14,2),
('Cabine 2',14,2),
('Cabine 3',14,2),
('Cabine 4',14,2),
('Cabine 1',15,2),
('Cabine 2',15,2),
('Cabine 3',15,2),
('Cabine 4',15,2),
('Cabine 5',15,2),
('Cabine 1',16,2),
('Cabine 2',16,2),
('Cabine 3',16,2),
('Cabine 4',16,2),
('Cabine 1',17,2),
('Cabine 2',17,2),
('Cabine 1',18,2),
('Cabine 2',18,2),
('Cabine 1',19,2),
('Cabine 2',19,2),
('Cabine 1',20,2),
('Cabine 2',20,2),
('Cabine 1',21,2),
('Cabine 2',21,2),
('Cabine 1',22,2),
('Cabine 2',22,2),
('Cabine 1',23,2),
('Cabine 2',23,2),
('Cabine 1',24,2),
('Cabine 2',24,2),
('Cabine 1',25,2),
('Cabine 2',25,2),
('Cabine 2',26,2),
('Cabine 1',26,2);

create table Registro (
  idRegistro int primary key auto_increment,
  valor int,
  dtRegistro datetime default current_timestamp,
  fkDispenser int,
  constraint fkRegistroDispenser foreign key (fkDispenser) references Dispenser(idDispenser)
);

insert into Registro (valor,dtRegistro,fkDispenser) values
(12, '2025-09-20 08:00:00', 1),
(18, '2025-09-20 12:00:00', 1),
(22, '2025-09-20 16:00:00', 1),
(17, '2025-09-20 20:00:00', 1),
(25, '2025-09-21 08:00:00', 1),
(14, '2025-09-21 08:00:00', 2),
(21, '2025-09-21 12:00:00', 2),
(33, '2025-09-21 16:00:00', 2),
(28, '2025-09-21 20:00:00', 2),
(31, '2025-09-22 08:00:00', 2),
(19, '2025-09-22 08:00:00', 3),
(27, '2025-09-22 12:00:00', 3),
(35, '2025-09-22 16:00:00', 3),
(29, '2025-09-22 20:00:00', 3),
(41, '2025-09-23 08:00:00', 3),
(24, '2025-09-23 08:00:00', 4),
(30, '2025-09-23 12:00:00', 4),
(38, '2025-09-23 16:00:00', 4),
(22, '2025-09-23 20:00:00', 4),
(37, '2025-09-24 08:00:00', 4),
(26, '2025-09-24 08:00:00', 5),
(32, '2025-09-24 12:00:00', 5),
(44, '2025-09-24 16:00:00', 5),
(40, '2025-09-24 20:00:00', 5),
(34, '2025-09-25 08:00:00', 5),
(23, '2025-09-25 08:00:00', 6),
(29, '2025-09-25 12:00:00', 6),
(36, '2025-09-25 16:00:00', 6),
(45, '2025-09-25 20:00:00', 6),
(33, '2025-09-26 08:00:00', 6),
(20, '2025-09-26 08:00:00', 7),
(28, '2025-09-26 12:00:00', 7),
(42, '2025-09-26 16:00:00', 7),
(38, '2025-09-26 20:00:00', 7),
(35, '2025-09-27 08:00:00', 7),
(17, '2025-09-27 08:00:00', 8),
(22, '2025-09-27 12:00:00', 8),
(30, '2025-09-27 16:00:00', 8),
(43, '2025-09-27 20:00:00', 8),
(39, '2025-09-28 08:00:00', 8),
(16, '2025-09-28 08:00:00', 9),
(23, '2025-09-28 12:00:00', 9),
(37, '2025-09-28 16:00:00', 9),
(41, '2025-09-28 20:00:00', 9),
(34, '2025-09-29 08:00:00', 9),
(15, '2025-09-29 08:00:00', 10),
(28, '2025-09-29 12:00:00', 10),
(33, '2025-09-29 16:00:00', 10),
(47, '2025-09-29 20:00:00', 10),
(40, '2025-09-30 08:00:00', 10),
(18, '2025-09-30 08:00:00', 11),
(25, '2025-09-30 12:00:00', 11),
(31, '2025-09-30 16:00:00', 11),
(45, '2025-09-30 20:00:00', 11),
(37, '2025-10-01 08:00:00', 11),
(22, '2025-10-01 08:00:00', 12),
(30, '2025-10-01 12:00:00', 12),
(39, '2025-10-01 16:00:00', 12),
(44, '2025-10-01 20:00:00', 12),
(33, '2025-10-02 08:00:00', 12),
(21, '2025-10-02 08:00:00', 13),
(26, '2025-10-02 12:00:00', 13),
(34, '2025-10-02 16:00:00', 13),
(42, '2025-10-02 20:00:00', 13),
(36, '2025-10-03 08:00:00', 13),
(20, '2025-10-03 08:00:00', 14),
(28, '2025-10-03 12:00:00', 14),
(33, '2025-10-03 16:00:00', 14),
(46, '2025-10-03 20:00:00', 14),
(38, '2025-10-04 08:00:00', 14),
(17, '2025-10-04 08:00:00', 15),
(29, '2025-10-04 12:00:00', 15),
(35, '2025-10-04 16:00:00', 15),
(43, '2025-10-04 20:00:00', 15),
(31, '2025-10-05 08:00:00', 15),
(23, '2025-10-05 08:00:00', 16),
(27, '2025-10-05 12:00:00', 16),
(36, '2025-10-05 16:00:00', 16),
(41, '2025-10-05 20:00:00', 16),
(38, '2025-10-06 08:00:00', 16),
(16, '2025-10-06 08:00:00', 17),
(25, '2025-10-06 12:00:00', 17),
(33, '2025-10-06 16:00:00', 17),
(44, '2025-10-06 20:00:00', 17),
(31, '2025-10-07 08:00:00', 17),
(14, '2025-10-07 08:00:00', 18),
(22, '2025-10-07 12:00:00', 18),
(37, '2025-10-07 16:00:00', 18),
(49, '2025-10-07 20:00:00', 18),
(42, '2025-10-08 08:00:00', 18),
(18, '2025-10-08 08:00:00', 19),
(29, '2025-10-08 12:00:00', 19),
(35, '2025-10-08 16:00:00', 19),
(48, '2025-10-08 20:00:00', 19),
(37, '2025-10-09 08:00:00', 19),
(12, '2025-10-09 08:00:00', 20),
(20, '2025-10-09 12:00:00', 20),
(28, '2025-10-09 16:00:00', 20),
(39, '2025-10-09 20:00:00', 20),
(33, '2025-10-10 08:00:00', 20),
(17, '2025-10-10 08:00:00', 21),
(26, '2025-10-10 12:00:00', 21),
(34, '2025-10-10 16:00:00', 21),
(46, '2025-10-10 20:00:00', 21),
(40, '2025-10-11 08:00:00', 21),
(15, '2025-10-11 08:00:00', 22),
(22, '2025-10-11 12:00:00', 22),
(37, '2025-10-11 16:00:00', 22),
(41, '2025-10-11 20:00:00', 22),
(32, '2025-10-12 08:00:00', 22),
(19, '2025-10-12 08:00:00', 23),
(27, '2025-10-12 12:00:00', 23),
(34, '2025-10-12 16:00:00', 23),
(43, '2025-10-12 20:00:00', 23),
(36, '2025-10-13 08:00:00', 23),
(22, '2025-10-13 08:00:00', 24),
(29, '2025-10-13 12:00:00', 24),
(33, '2025-10-13 16:00:00', 24),
(45, '2025-10-13 20:00:00', 24),
(39, '2025-10-14 08:00:00', 24),
(18, '2025-10-14 08:00:00', 25),
(26, '2025-10-14 12:00:00', 25),
(37, '2025-10-14 16:00:00', 25),
(41, '2025-10-14 20:00:00', 25),
(32, '2025-10-15 08:00:00', 25),
(20, '2025-10-15 08:00:00', 26),
(28, '2025-10-15 12:00:00', 26),
(36, '2025-10-15 16:00:00', 26),
(49, '2025-10-15 20:00:00', 26),
(41, '2025-10-16 08:00:00', 26),
(17, '2025-10-16 08:00:00', 27),
(22, '2025-10-16 12:00:00', 27),
(34, '2025-10-16 16:00:00', 27),
(45, '2025-10-16 20:00:00', 27),
(36, '2025-10-17 08:00:00', 27),
(19, '2025-10-17 08:00:00', 28),
(28, '2025-10-17 12:00:00', 28),
(35, '2025-10-17 16:00:00', 28),
(42, '2025-10-17 20:00:00', 28),
(33, '2025-10-18 08:00:00', 28),
(16, '2025-10-18 08:00:00', 29),
(25, '2025-10-18 12:00:00', 29),
(34, '2025-10-18 16:00:00', 29),
(47, '2025-10-18 20:00:00', 29),
(38, '2025-10-19 08:00:00', 29),
(21, '2025-10-19 08:00:00', 30),
(30, '2025-10-19 12:00:00', 30),
(37, '2025-10-19 16:00:00', 30),
(44, '2025-10-19 20:00:00', 30),
(33, '2025-10-20 08:00:00', 30),
(18, '2025-10-20 08:00:00', 31),
(27, '2025-10-20 12:00:00', 31),
(34, '2025-10-20 16:00:00', 31),
(42, '2025-10-20 20:00:00', 31),
(35, '2025-10-21 08:00:00', 31),
(19, '2025-10-21 08:00:00', 32),
(28, '2025-10-21 12:00:00', 32),
(36, '2025-10-21 16:00:00', 32),
(44, '2025-10-21 20:00:00', 32),
(40, '2025-10-22 08:00:00', 32),
(17, '2025-10-22 08:00:00', 33),
(26, '2025-10-22 12:00:00', 33),
(35, '2025-10-22 16:00:00', 33),
(49, '2025-10-22 20:00:00', 33),
(38, '2025-10-23 08:00:00', 33),
(21, '2025-10-23 08:00:00', 34),
(29, '2025-10-23 12:00:00', 34),
(37, '2025-10-23 16:00:00', 34),
(45, '2025-10-23 20:00:00', 34),
(40, '2025-10-24 08:00:00', 34),
(15, '2025-10-24 08:00:00', 35),
(25, '2025-10-24 12:00:00', 35),
(34, '2025-10-24 16:00:00', 35),
(46, '2025-10-24 20:00:00', 35),
(37, '2025-10-25 08:00:00', 35),
(22, '2025-10-25 08:00:00', 36),
(30, '2025-10-25 12:00:00', 36),
(36, '2025-10-25 16:00:00', 36),
(44, '2025-10-25 20:00:00', 36),
(39, '2025-10-26 08:00:00', 36),
(21, '2025-10-26 08:00:00', 37),
(28, '2025-10-26 12:00:00', 37),
(34, '2025-10-26 16:00:00', 37),
(47, '2025-10-26 20:00:00', 37),
(41, '2025-10-27 08:00:00', 37),
(19, '2025-10-27 08:00:00', 38),
(26, '2025-10-27 12:00:00', 38),
(33, '2025-10-27 16:00:00', 38),
(48, '2025-10-27 20:00:00', 38),
(36, '2025-10-28 08:00:00', 38),
(17, '2025-10-28 08:00:00', 39),
(24, '2025-10-28 12:00:00', 39),
(35, '2025-10-28 16:00:00', 39),
(49, '2025-10-28 20:00:00', 39),
(42, '2025-10-29 08:00:00', 39),
(18, '2025-10-29 08:00:00', 40),
(27, '2025-10-29 12:00:00', 40),
(36, '2025-10-29 16:00:00', 40),
(44, '2025-10-29 20:00:00', 40),
(38, '2025-10-30 08:00:00', 40),
(19, '2025-10-30 08:00:00', 41),
(28, '2025-10-30 12:00:00', 41),
(33, '2025-10-30 16:00:00', 41),
(48, '2025-10-30 20:00:00', 41),
(37, '2025-10-31 08:00:00', 41),
(22, '2025-10-31 08:00:00', 42),
(30, '2025-10-31 12:00:00', 42),
(39, '2025-10-31 16:00:00', 42),
(46, '2025-10-31 20:00:00', 42),
(33, '2025-11-01 08:00:00', 42),
(18, '2025-11-01 08:00:00', 43),
(25, '2025-11-01 12:00:00', 43),
(34, '2025-11-01 16:00:00', 43),
(47, '2025-11-01 20:00:00', 43),
(39, '2025-11-02 08:00:00', 43),
(21, '2025-11-02 08:00:00', 44),
(30, '2025-11-02 12:00:00', 44),
(37, '2025-11-02 16:00:00', 44),
(48, '2025-11-02 20:00:00', 44),
(41, '2025-11-03 08:00:00', 44),
(20, '2025-11-03 08:00:00', 45),
(28, '2025-11-03 12:00:00', 45),
(34, '2025-11-03 16:00:00', 45),
(49, '2025-11-03 20:00:00', 45),
(38, '2025-11-04 08:00:00', 45),
(22, '2025-11-04 08:00:00', 46),
(29, '2025-11-04 12:00:00', 46),
(35, '2025-11-04 16:00:00', 46),
(47, '2025-11-04 20:00:00', 46),
(32, '2025-11-05 08:00:00', 46),
(19, '2025-11-05 08:00:00', 47),
(27, '2025-11-05 12:00:00', 47),
(36, '2025-11-05 16:00:00', 47),
(44, '2025-11-05 20:00:00', 47),
(39, '2025-11-06 08:00:00', 47),
(18, '2025-11-06 08:00:00', 48),
(26, '2025-11-06 12:00:00', 48),
(33, '2025-11-06 16:00:00', 48),
(46, '2025-11-06 20:00:00', 48),
(8, '2025-11-07 08:00:00', 48),
(19, '2025-11-07 08:00:00', 49),
(25, '2025-11-07 12:00:00', 49),
(22, '2025-11-07 16:00:00', 49),
(30, '2025-11-07 20:00:00', 49),
(18, '2025-11-08 08:00:00', 49),
(16, '2025-11-07 08:00:00', 50),
(23, '2025-11-07 12:00:00', 50),
(29, '2025-11-07 16:00:00', 50),
(34, '2025-11-07 20:00:00', 50),
(27, '2025-11-08 08:00:00', 50),
(12, '2025-11-08 08:00:00', 51),
(20, '2025-11-08 12:00:00', 51),
(26, '2025-11-08 16:00:00', 51),
(31, '2025-11-08 20:00:00', 51),
(15, '2025-11-09 08:00:00', 51),
(21, '2025-11-09 08:00:00', 52),
(28, '2025-11-09 12:00:00', 52),
(33, '2025-11-09 16:00:00', 52),
(39, '2025-11-09 20:00:00', 52),
(24, '2025-11-10 08:00:00', 52),
(17, '2025-11-10 08:00:00', 53),
(22, '2025-11-10 12:00:00', 53),
(30, '2025-11-10 16:00:00', 53),
(35, '2025-11-10 20:00:00', 53),
(14, '2025-11-11 08:00:00', 53),
(13, '2025-11-11 08:00:00', 54),
(19, '2025-11-11 12:00:00', 54),
(26, '2025-11-11 16:00:00', 54),
(32, '2025-11-11 20:00:00', 54),
(20, '2025-11-12 08:00:00', 54),
(11, '2025-11-12 08:00:00', 55),
(18, '2025-11-12 12:00:00', 55),
(24, '2025-11-12 16:00:00', 55),
(29, '2025-11-12 20:00:00', 55),
(16, '2025-11-13 08:00:00', 55),
(15, '2025-11-13 08:00:00', 56),
(21, '2025-11-13 12:00:00', 56),
(27, '2025-11-13 16:00:00', 56),
(33, '2025-11-13 20:00:00', 56),
(19, '2025-11-14 08:00:00', 56),
(10, '2025-11-14 08:00:00', 57),
(14, '2025-11-14 12:00:00', 57),
(18, '2025-11-14 16:00:00', 57),
(23, '2025-11-14 20:00:00', 57),
(12, '2025-11-15 08:00:00', 57),
(9,  '2025-09-20 08:00:00', 58),
(13, '2025-09-20 12:00:00', 58),
(17, '2025-09-20 16:00:00', 58),
(21, '2025-09-20 20:00:00', 58),
(11, '2025-09-21 08:00:00', 58),
(8,  '2025-09-20 08:00:00', 59),
(12, '2025-09-20 12:00:00', 59),
(16, '2025-09-20 16:00:00', 59),
(20, '2025-09-20 20:00:00', 59),
(10, '2025-09-21 08:00:00', 59),
(7,  '2025-09-20 08:00:00', 60),
(11, '2025-09-20 12:00:00', 60),
(15, '2025-09-20 16:00:00', 60),
(19, '2025-09-20 20:00:00', 60),
(9,  '2025-09-21 08:00:00', 60),
(6,  '2025-09-20 08:00:00', 61),
(10, '2025-09-20 12:00:00', 61),
(14, '2025-09-20 16:00:00', 61),
(18, '2025-09-20 20:00:00', 61),
(8,  '2025-09-21 08:00:00', 61),
(5,  '2025-09-20 08:00:00', 62),
(9,  '2025-09-20 12:00:00', 62),
(13, '2025-09-20 16:00:00', 62),
(17, '2025-09-20 20:00:00', 62),
(7,  '2025-09-21 08:00:00', 62),
(46, '2025-09-20 08:00:00', 63),
(40, '2025-09-20 12:00:00', 63),
(32, '2025-09-20 16:00:00', 63),
(34, '2025-09-20 20:00:00', 63),
(40, '2025-09-21 08:00:00', 63),
(27, '2025-09-20 08:00:00', 64),
(12, '2025-09-20 12:00:00', 64),
(8,  '2025-09-20 16:00:00', 64),
(8,  '2025-09-20 20:00:00', 64),
(40, '2025-09-21 08:00:00', 64),
(8,  '2025-09-20 08:00:00', 65),
(35, '2025-09-20 12:00:00', 65),
(8,  '2025-09-20 16:00:00', 65),
(8,  '2025-09-20 20:00:00', 65),
(8,  '2025-09-21 08:00:00', 65),
(8,  '2025-09-20 08:00:00', 66),
(8,  '2025-09-20 12:00:00', 66),
(8,  '2025-09-20 16:00:00', 66),
(8,  '2025-09-20 20:00:00', 66),
(8,  '2025-09-21 08:00:00', 66),
(8,  '2025-09-20 08:00:00', 67),
(8,  '2025-09-20 12:00:00', 67),
(8,  '2025-09-20 16:00:00', 67),
(8,  '2025-09-20 20:00:00', 67),
(8,  '2025-09-21 08:00:00', 67),
(8,  '2025-09-20 08:00:00', 68),
(8,  '2025-09-20 12:00:00', 68),
(8,  '2025-09-20 16:00:00', 68),
(8,  '2025-09-20 20:00:00', 68),
(8,  '2025-09-21 08:00:00', 68),
(8,  '2025-09-20 08:00:00', 69),
(8,  '2025-09-20 12:00:00', 69),
(8,  '2025-09-20 16:00:00', 69),
(8,  '2025-09-20 20:00:00', 69),
(37, '2025-09-21 08:00:00', 69),
(8,  '2025-09-20 08:00:00', 70),
(8,  '2025-09-20 12:00:00', 70),
(8,  '2025-09-20 16:00:00', 70),
(8,  '2025-09-20 20:00:00', 70),
(8,  '2025-09-21 08:00:00', 70),
(8,  '2025-09-20 08:00:00', 71),
(8,  '2025-09-20 12:00:00', 71),
(8,  '2025-09-20 16:00:00', 71),
(8,  '2025-09-20 20:00:00', 71),
(8,  '2025-09-21 08:00:00', 71),
(8,  '2025-09-20 08:00:00', 72),
(8,  '2025-09-20 12:00:00', 72),
(8,  '2025-09-20 16:00:00', 72),
(8,  '2025-09-20 20:00:00', 72),
(8,  '2025-09-21 08:00:00', 72),
(8,  '2025-09-20 08:00:00', 73),
(8,  '2025-09-20 12:00:00', 73),
(8,  '2025-09-20 16:00:00', 73),
(8,  '2025-09-20 20:00:00', 73),
(8,  '2025-09-21 08:00:00', 73),
(8,  '2025-09-20 08:00:00', 74),
(8,  '2025-09-20 12:00:00', 74),
(8,  '2025-09-20 16:00:00', 74),
(8,  '2025-09-20 20:00:00', 74),
(8,  '2025-09-21 08:00:00', 74),
(8,  '2025-09-20 08:00:00', 75),
(8,  '2025-09-20 12:00:00', 75),
(8,  '2025-09-20 16:00:00', 75),
(33, '2025-09-20 20:00:00', 75),
(40, '2025-09-21 08:00:00', 75),
(40, '2025-09-20 08:00:00', 76),
(24, '2025-09-20 12:00:00', 76),
(23, '2025-09-20 16:00:00', 76),
(32, '2025-09-20 20:00:00', 76),
(15, '2025-09-21 08:00:00', 76);

select e.nomeFantasia as Empresa,
  c.nomeFantasia as 'Empresa Cliente',
  fl.titulo as Filial,
  fun.nome as Funcionario,
  fun.email as 'E-mail',
  fun.telefone as Contato
from Empresa as e join Empresa as c on c.fkCliente = e.idEmpresa
join Filial as fl on e.idEmpresa = fl.fkEmpresa
join Funcionario as fun on fl.idFilial = fun.fkFilial;

select e.nomeFantasia as Empresa,
  c.nomeFantasia as 'Empresa Cliente',
  fl.titulo as 'Filial'
from Empresa as e join Empresa as c on e.idEmpresa = c.fkCliente join Filial as fl on fkEmpresa = c.idEmpresa;

select titulo, concat(logradouro, ' ', numero, ' - CEP: ', cep) as Endereço from Filial join Endereco on fkEndereco = idEndereco;

select identificacao as Dispenser,
b.titulo as 'Banheiro',
b.setor as 'Setor',
Filial.titulo as 'Empresa contratante',   
valor as 'Percentual de consumo', 
dtRegistro as 'Data de registro' 
from Registro
	join Dispenser on fkDispenser = idDispenser
    join Banheiro as b on fkFilial = idBanheiro
    join Filial on fkfilial = idFilial
    join Empresa on fkEmpresa = idEmpresa
  where Empresa.nomeFantasia = 'Facilitariamos TUDO';


CREATE VIEW vw_dash_banheiros AS
SELECT 
    b.idBanheiro,
    b.titulo as banheiro,
    b.setor,
    b.fkFilial,
    f.titulo as filial,
    emp.nomeFantasia as empresa,
    COUNT(d.idDispenser) as qtd_dispensers
FROM Banheiro b
JOIN Filial f ON b.fkFilial = f.idFilial
JOIN Empresa emp ON f.fkEmpresa = emp.idEmpresa
JOIN Dispenser d ON b.idBanheiro = d.fkBanheiro
GROUP BY b.idBanheiro, b.titulo, b.setor, b.fkFilial, f.titulo, emp.nomeFantasia
ORDER BY b.setor, b.titulo;

SELECT * FROM vw_dash_banheiros;

CREATE VIEW vw_dash_setores AS
SELECT 
    b.setor,
    b.fkFilial,
    f.titulo as filial,
    emp.nomeFantasia as empresa,
    COUNT(DISTINCT b.idBanheiro) as total_banheiros,
    COUNT(DISTINCT d.idDispenser) as total_dispensers
FROM Banheiro b
JOIN Filial f ON b.fkFilial = f.idFilial
JOIN Empresa emp ON f.fkEmpresa = emp.idEmpresa
JOIN Dispenser d ON b.idBanheiro = d.fkBanheiro
GROUP BY b.setor, b.fkFilial, f.titulo, emp.nomeFantasia
ORDER BY b.setor;

SELECT * FROM vw_dash_setores;

CREATE VIEW vw_dash_dispensadores AS
SELECT 
    d.idDispenser,
    d.identificacao AS dispenser,
    b.idBanheiro,
    b.titulo AS banheiro,
    b.setor AS setor,
    b.fkFilial,
    f.titulo AS filial,
    emp.nomeFantasia AS empresa,
    r.valor AS distancia_sensor_mm,
    r.dtRegistro AS ultima_medicao,
    r.idRegistro,
    CASE
        WHEN (( (ph.diametroExternoMM - ph.diametroInternoMM)/2 - r.valor) / ((ph.diametroExternoMM - ph.diametroInternoMM)/2) ) * 100 < 0 THEN 0
        ELSE ROUND((( (ph.diametroExternoMM - ph.diametroInternoMM)/2 - r.valor) / ((ph.diametroExternoMM - ph.diametroInternoMM)/2) ) * 100)
    END AS porcentagem_uso,
    CASE 
        WHEN (( (ph.diametroExternoMM - ph.diametroInternoMM)/2 - r.valor) / ((ph.diametroExternoMM - ph.diametroInternoMM)/2) ) * 100 <= 20 THEN 'critico'
        WHEN (( (ph.diametroExternoMM - ph.diametroInternoMM)/2 - r.valor) / ((ph.diametroExternoMM - ph.diametroInternoMM)/2) ) * 100 <= 40 THEN 'atencao'
        ELSE 'ideal'
    END AS estado
FROM Dispenser d
JOIN Banheiro b ON d.fkBanheiro = b.idBanheiro
JOIN Filial f ON b.fkFilial = f.idFilial
JOIN Empresa emp ON f.fkEmpresa = emp.idEmpresa
JOIN PapelHigienico ph ON d.fkPapelHigienico = ph.idPapelHigienico
JOIN Registro r ON d.idDispenser = r.fkDispenser
WHERE r.dtRegistro = (
    SELECT MAX(dtRegistro) 
    FROM Registro 
    WHERE fkDispenser = d.idDispenser
)
ORDER BY setor, 
    banheiro, 
	fkFilial,
    porcentagem_uso ASC;

SELECT * FROM vw_dash_dispensadores;

CREATE VIEW vw_dash_banheiros_estados AS
SELECT
    b.idBanheiro,
    b.titulo AS banheiro,
    b.setor,
    b.fkFilial,
    f.titulo AS filial,
    emp.nomeFantasia AS empresa,
    COUNT(vd.idDispenser) AS total_dispensadores,
    SUM(CASE WHEN vd.estado = 'critico' THEN 1 ELSE 0 END) AS dispensadorCritico,
    SUM(CASE WHEN vd.estado = 'atencao' THEN 1 ELSE 0 END) AS dispensadorAtencao,
    SUM(CASE WHEN vd.estado = 'ideal' THEN 1 ELSE 0 END) AS dispensadorOk,
    ((SUM(CASE WHEN vd.estado = 'ideal' THEN 4 ELSE 0 END) +
         SUM(CASE WHEN vd.estado = 'atencao' THEN 2 ELSE 0 END)) / (COUNT(vd.idDispenser) * 4) * 100
    ) AS situacao_banheiro,
    CASE
        WHEN (
            (SUM(CASE WHEN vd.estado = 'ideal' THEN 3 ELSE 0 END) +
             SUM(CASE WHEN vd.estado = 'atencao' THEN 2 ELSE 0 END)) / (COUNT(vd.idDispenser) * 4) * 100) >= 85 THEN 'ideal'
        WHEN (
            (SUM(CASE WHEN vd.estado = 'ideal' THEN 4 ELSE 0 END) +
             SUM(CASE WHEN vd.estado = 'atencao' THEN 2 ELSE 0 END)) / (COUNT(vd.idDispenser) * 4) * 100) >= 40 THEN 'atencao'
        ELSE 'critico'
    END AS classificacao_banheiro
FROM Banheiro b
JOIN Filial f ON b.fkFilial = f.idFilial
JOIN Empresa emp ON f.fkEmpresa = emp.idEmpresa
JOIN vw_dash_dispensadores vd ON vd.idBanheiro = b.idBanheiro

GROUP BY b.idBanheiro, b.titulo, b.setor, b.fkFilial, f.titulo, emp.nomeFantasia
ORDER BY situacao_banheiro ASC;

select * from vw_dash_banheiros_estados;

CREATE VIEW vw_dash_setores_estados AS
SELECT
    b.setor,
    b.fkFilial,
    f.titulo AS filial,
    emp.nomeFantasia AS empresa,
    COUNT(DISTINCT b.idBanheiro) AS total_banheiros,
    SUM(CASE WHEN vb.classificacao_banheiro = 'critico' THEN 1 ELSE 0 END) AS banheiroCritico,
    SUM(CASE WHEN vb.classificacao_banheiro = 'atencao' THEN 1 ELSE 0 END) AS banheiroAtencao,
    SUM(CASE WHEN vb.classificacao_banheiro = 'ideal' THEN 1 ELSE 0 END) AS banheiroOk,
    ROUND((SUM(CASE WHEN vb.classificacao_banheiro = 'ideal' THEN 4 ELSE 0 END) +
	      SUM(CASE WHEN vb.classificacao_banheiro = 'atencao' THEN 2 ELSE 0 END)) / (COUNT(DISTINCT b.idBanheiro) * 4) * 100) AS situacao_setor,
    CASE
        WHEN ((SUM(CASE WHEN vb.classificacao_banheiro = 'ideal' THEN 4 ELSE 0 END) +
             SUM(CASE WHEN vb.classificacao_banheiro = 'atencao' THEN 2 ELSE 0 END)) / (COUNT(DISTINCT b.idBanheiro) * 4) * 100) >= 85 THEN 'ideal'
        WHEN (
            (SUM(CASE WHEN vb.classificacao_banheiro = 'ideal' THEN 4 ELSE 0 END) +
             SUM(CASE WHEN vb.classificacao_banheiro = 'atencao' THEN 2 ELSE 0 END)) / (COUNT(DISTINCT b.idBanheiro) * 4) * 100) >= 40 THEN 'atencao'
        ELSE 'critico'
    END AS classificacao_setor
FROM Banheiro b
JOIN Filial f ON b.fkFilial = f.idFilial
JOIN Empresa emp ON f.fkEmpresa = emp.idEmpresa
JOIN vw_dash_banheiros_estados vb ON vb.idBanheiro = b.idBanheiro
GROUP BY b.setor, b.fkFilial, f.titulo, emp.nomeFantasia
ORDER BY situacao_setor ASC;

select * from vw_dash_setores_estados;