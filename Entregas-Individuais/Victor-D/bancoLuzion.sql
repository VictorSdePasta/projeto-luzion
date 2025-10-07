CREATE DATABASE Luzion;

USE Luzion;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeFantasia VARCHAR(45),
CNPJ CHAR (14)
);

ALTER TABLE empresa MODIFY COLUMN CNPJ CHAR (18);

CREATE TABLE filial (
idFilial INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
fkEmpresa INT,
	CONSTRAINT fkFilialEmpresa
		FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idEmpresa),
logradouro VARCHAR(45),
cep VARCHAR(9),
cidade VARCHAR(40),
estado CHAR(2)
);

CREATE TABLE adminEmpresa(
idAdminEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeAdminEmpresa VARCHAR(100),
emailAdminEmpresa VARCHAR(100),
senhaAdminEmpresa  VARCHAR(40),
fkFilial INT,
	CONSTRAINT fkAdminEmpresa
    FOREIGN KEY (fkFilial)
    REFERENCES filial(idFilial)
);

CREATE TABLE estoque (
idEstoque INT PRIMARY KEY AUTO_INCREMENT,
fkFilial INT,
	CONSTRAINT fkEstoqueEmpresa
		FOREIGN KEY (fkFilial)
		REFERENCES filial (idFilial),
qtdPapel INT
);

CREATE TABLE banheiro(
idBanheiro INT PRIMARY KEY AUTO_INCREMENT,
fkFilial INT,
	CONSTRAINT fkBanheiroFilial
    FOREIGN KEY (fkFilial)
    REFERENCES filial(idFilial)
);

CREATE TABLE dispenser(
idDispenser INT PRIMARY KEY AUTO_INCREMENT,
qtdPapel INT,
fkBanheiro INT,
	CONSTRAINT fkDispenserBanheiro
    FOREIGN KEY (fkBanheiro)
    REFERENCES banheiro(idBanheiro)
);

CREATE TABLE sensorArduino(
idSensorArduino INT PRIMARY KEY AUTO_INCREMENT,
dataInstalacao DATETIME,
fkEstoque INT,
	CONSTRAINT fkEstoqueSensorArduino
		FOREIGN KEY (fkEstoque)
        REFERENCES estoque(idEstoque),
fkDispenser INT,
	CONSTRAINT fkDispenserSensorArduino
		FOREIGN KEY (fkDispenser)
        REFERENCES dispenser(idDispenser)
);

CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
dataRegistro DATETIME,
fkFuncionario INT,
	CONSTRAINT fkRegistroFuncionario
    FOREIGN KEY (fkFuncionario)
    REFERENCES funcionario(idFuncionario),
fkDispenser INT,
	CONSTRAINT fkRegistroDispenser
    FOREIGN KEY (fkDispenser)
    REFERENCES dispenser(idDispenser) 
);

CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100)
);
