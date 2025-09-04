CREATE TABLE usuario(
id INT PRIMARY KEY AUTO_INCREMENT,
nomeGestor VARCHAR(30),
nomeEmpresa VARCHAR(30) NOT NULL,
email VARCHAR(50),
senha VARCHAR(20),
cnpj VARCHAR(1) NOT NULL,
cidade VARCHAR(30),
estado VARCHAR(25));

CREATE TABLE relatorio( 
idDispenser INT PRIMARY KEY AUTO_INCREMENT,
distancia INT,
roloHora INT,
dtHora DATETIME DEFAULT current_timestamp,
estoqueGeral INT NOT NULL,
plano VARCHAR(15));

CREATE TABLE historico(
idArduino INT PRIMARY KEY AUTO_INCREMENT,
arduino INT,
statusPapel CHAR(8) NOT NULL,
distancia INT,
dtHora  DATETIME,
tpPapel VARCHAR(15));

CREATE TABLE statuss(
Id_arduino INT PRIMARY KEY AUTO_INCREMENT,
reposicao VARCHAR(10),
dtHora DATETIME,
estoqueGeral INT NOT NULL);

