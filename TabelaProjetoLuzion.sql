CREATE DATABASE projetoLuzion;
USE projetoLuzion;

CREATE TABLE cadastro (
idCadastro INT PRIMARY KEY AUTO_INCREMENT,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
representante VARCHAR (50),
email VARCHAR(80),
senha VARCHAR(30),
cnpj CHAR(14),
empresa VARCHAR (50),
cep CHAR (8),
telefone VARCHAR(15)
);

CREATE TABLE historicoSensor (
	idHistorico INT PRIMARY KEY AUTO_INCREMENT,
	arduino INT,
	distancia INT,
	dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    localizacao VARCHAR(50),
    empresa VARCHAR (50)
);
INSERT INTO historicoSensor(arduino, distancia, localizacao, empresa) VALUES
	(1, 100, 'São Paulo', 'Kimberly-Clark');
	

CREATE TABLE distribuicaoPapel (
	idDist INT PRIMARY KEY AUTO_INCREMENT,
    reposicao INT,
    estoque INT,
	qtdTotalArduino INT,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    empresa VARCHAR (50)
);
INSERT INTO distribuicaoPapel(reposicao, estoque,qtdTotalArduino ,empresa) VALUES
	(4, 200, 20, 'Kimberly-Clark');