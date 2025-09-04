CREATE DATABASE projeto;
USE projeto;

CREATE TABLE usuario (
id INT PRIMARY KEY AUTO_INCREMENT,
nome_empresa VARCHAR (50) NOT NULL,
cnpj VARCHAR (14) NOT NULL,
senha VARCHAR (50) NOT NULL,
cep VARCHAR (8),
email VARCHAR(80) 
CONSTRAINT chkEmail CHECK (email LIKE '%@%')
);



CREATE TABLE arduino (
id_arduino INT PRIMARY KEY AUTO_INCREMENT,
distancia INT,
tipo VARCHAR (30),
CONSTRAINT chkDistancia CHECK (distancia > 0.5 AND distancia < 0.1)
);



CREATE TABLE relatorio (
id_arduino INT PRIMARY KEY AUTO_INCREMENT,
id_atualizacao INT,
statu_papel VARCHAR (10),
reposicao INT,
dh DATETIME DEFAULT CURRENT_TIMESTAMP,
estoque INT,


);



