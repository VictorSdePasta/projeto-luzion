CREATE DATABASE Luzion;

USE Luzion;

CREATE TABLE facilite (
idFacilite INT PRIMARY KEY,
razaoSoacial VARCHAR(45),
CNPJ CHAR(15));

CREATE TABLE cliente (
idempresa INT PRIMARY KEY AUTO_INCREMENT,
razaoSoacial VARCHAR(45),
CNPJ CHAR(15) UNIQUE,
fkidFacilite INT,
CONSTRAINT fkidFacilite
	FOREIGN KEY (fkidFacilite) 
		REFERENCEs facilite (idFacilite)
);


CREATE TABLE filial (
idfilial INT PRIMARY KEY AUTO_INCREMENT,
razaoSoacial VARCHAR(45),
CNPJ CHAR(15) UNIQUE,
fkidcliente INT,
CONSTRAINT fkidcliente
	FOREIGN KEY (fkidcliente)
    REFERENCES cliente (idempresa)
    );
    
CREATE TABLE banheiro (
idbanheiro INT PRIMARY KEY AUTO_INCREMENT,
cabines INT, 
setor VARCHAR(45),
andar CHAR(5),
fkidfilial INT,
CONSTRAINT fkidfilial
FOREIGN KEY (fkidfilial)
REFERENCES filial (idfilial)
);

CREATE TABLE dispenser (
iddispenser INT,
marca VARCHAR(45),
tamanho VARCHAR(45),
fkidbanheiro INT,
CONSTRAINT fkidbanheiro
FOREIGN KEY (fkidbanheiro)
	REFERENCES banheiro(idbanheiro),
fksensor INT,
CONSTRAINT fksensor 
FOREIGN KEY (fksensor)
	REFERENCES sensor (idsensor),
fkpapel INT,
CONSTRAINT fkpapel
	FOREIGN KEY (fkpapel)
    REFERENCES papel(idpapel)
    );
    
CREATE TABLE sensor (
idsensor INT PRIMARY KEY AUTO_INCREMENT,
captura VARCHAR(45),
capturaData DATETIME
);

CREATE TABLE papel (
idpapel INT PRIMARY KEY AUTO_INCREMENT,
marca VARCHAR(45),
lote VARCHAR(45),
vencimento DATE,
tamanho VARCHAR(45),
tipo VARCHAR(45),
fkestoque INT,
CONSTRAINT fkestoque
	FOREIGN KEY (fkestoque)
		REFERENCES estoque (idestoque)
);

CREATE TABLE endereco (
idendereco INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(45),
numero INT,
cidade VARCHAR(45),
estado VARCHAR(45),
CEP CHAR(11),
fkidFacilite INT,
CONSTRAINT fkidFaciliteEndereco
FOREIGN KEY (fkidFacilite)
REFERENCES facilite (idFacilite),
fkidempresa INT,
CONSTRAINT fkidempresaEndereco
FOREIGN KEY (fkidempresa)
REFERENCES cliente (idempresa)
);

CREATE TABLE estoque (
idestoque INT PRIMARY KEY AUTO_INCREMENT,
capacidade VARCHAR(45),
fksensorEstoque INT,
CONSTRAINT fksensorEstoque
FOREIGN KEY (fksensorEstoque)
	REFERENCES sensor (idsensor)
);

CREATE TABLE responsavel (
idresponsavel INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cargo VARCHAR(45),
cpf VARCHAR(20),
dtNascimento VARCHAR(45),
telefone VARCHAR (45),
email VARCHAR (45),
fkFacilite INT,
CONSTRAINT fkFaciliteResponsavel
FOREIGN KEY (fkFacilite)
	REFERENCES facilite (idFacilite),
fkempresa INT,
CONSTRAINT fkempresaResponsavel
FOREIGN KEY (fkempresa)
	REFERENCES cliente (idempresa)
    );

INSERT INTO facilite (idFacilite, razaoSoacial, CNPJ) 
VALUES
(1, 'Facilidade São Paulo', '12.345.678/2591-99'),
(2, 'Facilidade Rio de Janeiro', '23.456.789/6581-88');

INSERT INTO cliente (idempresa, razaoSoacial, CNPJ, fkidFacilite) 
VALUES
(1, 'Cliente João', '34.567.890/0001-77', 1),
(2, 'Cliente Maria', '45.678.901/0001-66', 2);

INSERT INTO filial (idfilial, razaoSoacial, CNPJ, fkidcliente) 
VALUES
(1, 'Filial João SP', '56.789.012/0001-55', 1),
(2, 'Filial Maria RJ', '67.890.123/0001-44', 2);

INSERT INTO banheiro (idbanheiro, cabines, setor, andar, fkidfilial) 
VALUES
(1, 3, 'Administração', '1º', 1),
(2, 4, 'Vendas', '2º', 2);

INSERT INTO sensor (idsensor, captura, capturaData) 
VALUES
(1, '50', '2025-10-25 10:00:00'),
(2, '10', '2025-10-25 10:30:00');

INSERT INTO papel (idpapel, marca, lote, vencimento, tamanho, tipo, fkestoque) 
VALUES
(1, 'Papel neve', 'Lote 526', '2026-12-01', 'Grande', 'Higiênico', 1),
(2, 'Papel personal', 'Lote 458', '2026-06-01', 'Médio', 'Higiênico', 2);

INSERT INTO estoque (idestoque, capacidade, fksensorEstoque) 
VALUES
(1, '1000 unidades', 1),
(2, '500 unidades', 2);

INSERT INTO responsavel (idresponsavel, nome, cargo, cpf, dtNascimento, telefone, email, fkFacilite, fkempresa) 
VALUES
(1, 'João Silva', 'Gerente', '123.456.789-00', '1985-06-15', '(11) 99999-9999', 'joao@empresa.com', 1, 1),
(2, 'Maria Silva', 'Coordenadora', '987.654.321-00', '1990-03-20', '(21) 99999-9999', 'maria@empresa.com', 2, 2);

INSERT INTO endereco (idendereco, rua, numero, cidade, estado, CEP, fkidFacilite, fkidempresa) 
VALUES
(1, 'Rua Joao sila', 02, 'São Paulo', 'SP', '01000-000', 1, 1),
(2, 'Rua Jose maria', 05, 'Rio de Janeiro', 'RJ', '20000-000', 2, 2);




SELECT c.idempresa, c.razaoSoacial AS nome_cliente, c.CNPJ AS cnpj_cliente,
       f.razaoSoacial AS nome_facilite, f.CNPJ AS cnpj_facilite
FROM cliente c
JOIN facilite f ON c.fkidFacilite = f.idFacilite;


SELECT fi.idfilial, fi.razaoSoacial AS nome_filial, fi.CNPJ AS cnpj_filial,
       c.razaoSoacial AS nome_cliente, c.CNPJ AS cnpj_cliente, 
       f.razaoSoacial AS nome_facilite, f.CNPJ AS cnpj_facilite
FROM filial fi
JOIN cliente c ON fi.fkidcliente = c.idempresa
JOIN facilite f ON c.fkidFacilite = f.idFacilite;


SELECT b.idbanheiro, b.setor, b.andar, b.cabines, 
       fi.razaoSoacial AS nome_filial, c.razaoSoacial AS nome_cliente
FROM banheiro b
JOIN filial fi ON b.fkidfilial = fi.idfilial
JOIN cliente c ON fi.fkidcliente = c.idempresa;


SELECT d.iddispenser, d.marca AS dispenser_marca, d.tamanho AS dispenser_tamanho,
       b.setor AS banheiro_setor, s.captura AS sensor_captura, p.marca AS papel_marca
FROM dispenser d
JOIN banheiro b ON d.fkidbanheiro = b.idbanheiro
JOIN sensor s ON d.fksensor = s.idsensor
JOIN papel p ON d.fkpapel = p.idpapel;


SELECT r.nome AS nome_responsavel, r.cargo, r.cpf, r.telefone, 
       c.razaoSoacial AS nome_cliente, f.razaoSoacial AS nome_facilite
FROM responsavel r
JOIN cliente c ON r.fkempresa = c.idempresa
JOIN facilite f ON r.fkFacilite = f.idFacilite;










    




