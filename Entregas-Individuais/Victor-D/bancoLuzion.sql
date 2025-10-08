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

INSERT INTO empresa (nomeFantasia,CNPJ) VALUES
('Luxion','123456789123456789'),
('Neoguard','111111111111111111'),
('V3T','222222222222222222');

SELECT * FROM empresa;

INSERT INTO filial (nome,fkEmpresa,logradouro,cep,cidade,estado) VALUES
('Unidade SP-Luz',1,'praça',120120903,'São Paulo','SP'),
('Neoguard U-3',2,'Viaduto','111111111','Florianópolis','SC'),
('V3T Leste-1',3,'Jardim','222222222','Belo Horizonte','MG');

INSERT INTO adminEmpresa (nomeAdminEmpresa,emailAdminEmpresa,senhaAdminEmpresa,fkFilial) VALUES
('Julio','julio@gmail.com','222a',default),
('Carlos','carlos@gmail.com','225a',default),
('Bruno','bruno@gmail.com','223b',default);

INSERT INTO estoque (fkFilial,qtdPapel) VALUES 
(default,90),
(default,70),
(default,80);


ALTER TABLE banheiro ADD COLUMN andar VARCHAR(45);
INSERT INTO banheiro (fkFilial,andar) VALUES
(default,'2º Andar'),
(default,'3º Andar'),
(default,'1º Andar');

INSERT INTO dispenser (qtdPapel,fkBanheiro) VALUES
(100,default),
(50,default),
(70,default);

CREATE TABLE sensorArduino(
idSensorArduino INT PRIMARY KEY AUTO_INCREMENT,
dataInstalacao DATETIME,
fkDispenser INT,
	CONSTRAINT fkSensorArduinoDispenser
    FOREIGN KEY (fkDispenser)
    REFERENCES dispenser(idDispenser),
fkEstoque INT,
	CONSTRAINT fkSensorArduinoEstoque
    FOREIGN KEY (fkEstoque)
    REFERENCES estoque(idEstoque)
);

INSERT INTO registro (dataRegistro,fkFuncionario,fkDispenser) VALUES
('2025-10-10 8:00:00',default,default),
('2025-10-10 9:00:00',default,default),
('2025-10-10 10:00:00',default,default);

INSERT INTO funcionario (nome) VALUES
('Julio Marques'),
('Alan Vicente'),
('Jorge Matos');