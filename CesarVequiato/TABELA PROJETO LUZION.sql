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
    qtdTotalArduino INT,
	distancia INT,
	dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    localizacao VARCHAR(50),
    empresa VARCHAR (50)
);

CREATE TABLE distribuicaoPapel (
	idDist INT PRIMARY KEY AUTO_INCREMENT,
    reposicao INT,
    estoque INT,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    empresa VARCHAR (50)
);

