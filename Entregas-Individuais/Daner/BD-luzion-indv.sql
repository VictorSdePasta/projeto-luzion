create database luzionindividual;
use luzionindividual;
show tables;

create table facilitie (
	idFacilitie int primary key auto_increment,
    razaoSocial varchar(100),
    nomeFantasia varchar(50),
    cnpj char(14),
    tfCelular char(11),
    tfFixo char(8),
    senha varchar(50),
    fkEndereco int,
    constraint fkFacilitieEndereco
    foreign key (fkEndereco) references endereco(idEndereco)
	);

INSERT INTO facilitie (razaoSocial, nomeFantasia, cnpj, tfCelular, tfFixo, senha, fkEndereco) VALUES
('CleanService LDTA', 'CleanService', '00001999890119', '11990909988', '44448888', 'Cleaner245', 1),
('Lavanda Serviços e Limpezas', 'Lavanda Serviços', '00001985432189', '11909988878', '44669898', 'Lav4nda342', 3),
('Mara Facility', 'Mara Facility', '00000998889821','11975849000', '44229900', 'maraMaravilha', 5);

create table empresa (
	idEmpresa int primary key auto_increment,
	razaoSocial varchar(100),
    cnpj char(14),
    tfFixo char(8),
    tfCelular char(11),
    senha char(15),
    fkFacilitie int,
    constraint fkFacilitieEmpresa
    foreign key (fkFacilitie) references facilitie(idFacilitie),
    fkEndereco int,
    constraint fkEmpresaEndereco
    foreign key (fkEndereco) references endereco(idEndereco)
    );
    
insert into empresa (razaoSocial, cnpj, tfFixo, tfCelular, senha, fkFacilitie, fkEndereco) values
	('TechFood', '00011939217428', '44449111', '11991112123', 'techf00d', 1, 2),
    ('Comércios e Varejos LTDA','00039087654901', '44190129', '11954819202', 'commerce22', 1, 4),
    ('Hospital Alberto', '00000987123451', '88881928', '11902314582', 'hospalb90', 2, 6),
    ('Consultoria Company', '00001243212909', '22221938', '11923467423', 'company8888', 3, 7);
    
create table estoque (
	idEstoque int primary key auto_increment,
    quantidade decimal(5,2),
	fkFacilitie int unique,
    constraint fkFacilitieEstoque
    foreign key (fkFacilitie) references facilitie(idFacilitie)
    );
    
insert into estoque (quantidade, fkFacilitie) values
	('117.6', 1),
    ('68.6', 2),
    ('205.8', 3);
    
create table endereco (
	idEndereco int primary key auto_increment,
    rua varchar(50),
    numero char(3),
    cep char(8),
	bairro varchar(30),
    cidade varchar(50),
    uf char(2)
	);

insert into endereco (rua, numero, cep, bairro, cidade, uf) values
    ('Rua das Palmeiras', '290', '0968123', 'Consolação', 'São Paulo', 'SP'),
    ('Rua Monte Alto', '389', '0123976', 'Santa Cecília', 'São Paulo', 'SP'),
    ('Av. Brasil', '761', '0122284', 'Jardim Vassouras', 'Santo Amâro', 'SP'),
    ('Rua Coronel Renato', '156', '2809283', 'Cabo Branco', 'Perus', 'SP'),
    ('Av. Bandeirantes', '87', '0987215', 'Vila Suiça', 'Itaimbaya', 'SP'),
    ('Rua Liberdade', '45', '0112268', 'Barra Funda', 'Alto Porto', 'SP'),
    ('Rua Queiroz', '123', '0928365', 'Vila Aurora', 'Francisco Morato', 'SP');
    
    
create table banheiro (
	idBanheiro int primary key auto_increment,
    numero char(2),
    fkDispenser int unique,
    constraint fkDispenserBanheiro
    foreign key (fkDispenser) references dispenser(idDispenser),
    fkEmpresa int,
    constraint fkBanheiroEmpresa 
    foreign key (fkEmpresa) references empresa(idEmpresa)
    );
    
insert into banheiro (numero, fkDispenser, fkEmpresa) values
	('1', 1, 5),
    ('2', 2, 5),
    ('3', 3, 5),
    ('1', 4, 6),
    ('1', 5, 7),
    ('2', 6, 7),
    ('1', 7, 8),
    ('2', 8, 8),
    ('3', 9, 8);

    
create table dispenser (
	idDispenser int primary key auto_increment,
    tamanhoPapel decimal(4,2),
	quantidade int
    );
    
insert into dispenser (tamanhoPapel, quantidade) values
	(7.00, 100),
    (7.20, 65),
    (7.00, 82),
    (7.00, 90),
    (7.20, 40),
    (7.20, 16),
    (7.00, 30),
    (7.00, 55),
    (7.20, 76);
create table alerta (
	idAlerta int primary key auto_increment,
	descricao varchar(100),
    fkDispenser int,
    constraint fkDispenserAlerta
    foreign key (fkDispenser) references dispenser(idDispenser)
    );
    
insert into alerta (descricao, fkDispenser) values
	('Nível de papel está na metade', 2),
    ('Nível de papel está na metade', 3),
    ('Nível de papel está acabando', 6),
    ('Nível de papel está acabando', 7),
    ('Nível de papel está na metade', 8);
    
select * from alerta;
