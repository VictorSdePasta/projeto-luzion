CREATE DATABASE Luzion;

USE luzion;
SHOW TABLES;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeFantasia VARCHAR(45),
CNPJ CHAR (18)
);


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
    REFERENCES filial(idFilial),
nivelPermissao INT
);

CREATE TABLE estoque (
idEstoque INT PRIMARY KEY AUTO_INCREMENT,
fkFilial INT,
	CONSTRAINT fkEstoqueEmpresa
		FOREIGN KEY (fkFilial)
		REFERENCES filial (idFilial),
titulo VARCHAR (45)
);

CREATE TABLE banheiro(
idBanheiro INT PRIMARY KEY AUTO_INCREMENT,
fkFilial INT,
	CONSTRAINT fkBanheiroFilial
    FOREIGN KEY (fkFilial)
    REFERENCES filial(idFilial),
titulo VARCHAR(45),
setor VARCHAR(45)
);

CREATE TABLE sensorArduino(
idSensorArduino INT PRIMARY KEY AUTO_INCREMENT,
dataInstalacao DATETIME,
nome VARCHAR(45),
fkEstoque INT,
	CONSTRAINT fkEstoqueSensorArduino
		FOREIGN KEY (fkEstoque)
        REFERENCES estoque(idEstoque),
fkBanheiro INT,
	CONSTRAINT fkBanheiroSensorArduino
		FOREIGN KEY (fkBanheiro)
        REFERENCES banheiro(idBanheiro)
);


CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
dataRegistro DATETIME,
fkSensorArduino INT,
	CONSTRAINT fkRegistroSensorArduino
    FOREIGN KEY (fkSensorArduino)
    REFERENCES sensorArduino(idSensorArduino),
qtdPapel INT
)AUTO_INCREMENT = 1;


INSERT INTO empresa (nomeFantasia,CNPJ) VALUES
('Luxion','123456789123456789'),
('Neoguard','111111111111111111'),
('V3T','222222222222222222');

SELECT * FROM empresa;

INSERT INTO filial (nome,fkEmpresa,logradouro,cep,cidade,estado) VALUES
('Unidade SP-Luz',1,'praça',120120903,'São Paulo','SP'),
('Neoguard U-3',2,'Viaduto','111111111','Florianópolis','SC'),
('V3T Leste-1',3,'Jardim','222222222','Belo Horizonte','MG');

INSERT INTO adminEmpresa (nomeAdminEmpresa,emailAdminEmpresa,senhaAdminEmpresa,fkFilial,nivelPermissao) VALUES
('Julio','julio@gmail.com','222a',1,1),
('Carlos','carlos@gmail.com','225a',1,2),
('Bruno','bruno@gmail.com','223b',2,3);


INSERT INTO banheiro (fkFilial,titulo,setor) VALUES
(1,'BanheiroA','Setor-A'),
(2,'BanheiroB','Setor-B'),
(3,'BanheiroC','Setor-C');


SELECT * FROM  sensorArduino;
SHOW TABLES;
DESC banheiro;


INSERT INTO registro (dataRegistro,qtdPapel,fkSensorArduino) VALUES
('2025-10-10 8:00:00',40,4),
('2025-10-10 9:00:00',30,5),
('2025-10-10 10:00:00',50,6);



INSERT INTO sensorArduino (dataInstalacao,nome,fkEstoque,fkBanheiro) VALUES
('2020-01-01','A354',1,null),
('2025-01-01','B346',null,1),
('2025-05-05','C456',null,2);



INSERT INTO estoque (fkFilial,titulo) VALUES 
(default,'Setor-A'),
(default,'Setor-B'),
(default,'Setor-C');


DESC banheiro;
SELECT * FROM empresa;

SELECT b.titulo, s.nome AS 'Modelo Sensor', concat(r.qtdPapel, '%') AS Percentual, CASE 
WHEN r.qtdPapel < 40 THEN 'Precisa Trocar'
ELSE 'Quantidade Adequada'
END AS 'Situação',
 r.dataRegistro FROM registro AS r JOIN sensorArduino AS s ON r.fkSensorArduino = s.idSensorArduino  JOIN banheiro AS b ON s.fkBanheiro = b.idBanheiro;

SELECT e.titulo, s.nome AS 'Modelo Sensor', concat(r.qtdPapel, '%') AS Percentual, CASE
WHEN r.qtdPapel < 40 THEN 'Precisa Trocar'
ELSE 'Quantidade Adequada'
END AS 'Situação',
	r.dataRegistro FROM registro AS r JOIN sensorArduino AS s ON r.fkSensorArduino = s.idSensorArduino JOIN estoque AS e ON s.fkEstoque = e.idEstoque;

SELECT a.nomeAdminEmpresa, a.emailAdminEmpresa, f.nome, f.estado, e.nomeFantasia FROM empresa AS e JOIN filial AS f ON f.fkEmpresa = e.idEmpresa JOIN adminEmpresa AS a ON a.fkFilial = f.idFilial;