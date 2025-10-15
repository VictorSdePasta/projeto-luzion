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











    




