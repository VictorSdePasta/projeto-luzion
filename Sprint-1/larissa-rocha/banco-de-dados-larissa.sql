CREATE DATABASE projetoLuzion;
USE projetoLuzion;

CREATE TABLE cadastro (
idCadastro INT PRIMARY KEY AUTO_INCREMENT,
nomeCompleto VARCHAR(100) NOT NULL,
cargo VARCHAR(50),
email VARCHAR(50) NOT NULL,
senha VARCHAR(40),
telefone VARCHAR(15) NOT NULL,
empresa VARCHAR(100) NOT NULL,
cnpj CHAR(14) NOT NULL,
endereco VARCHAR(150)
);

CREATE TABLE historicoRelatorio (
idArduino INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(50),
dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
localArduino VARCHAR(50),
distancia INT,
statusArduino TINYINT
);

CREATE TABLE estoqueEmpresa (
idEstoque INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(50),
statusEstoque TINYINT,
reposicao INT,
dtHora DATETIME DEFAULT CURRENT_TIMESTAMP
);









