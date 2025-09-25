CREATE DATABASE luzion;
USE luzion;

CREATE TABLE cadastro
(idCadastro INT PRIMARY KEY AUTO_INCREMENT,
nomeGestor VARCHAR(60),
CNPJ CHAR(15),
nomeEmpresa VARCHAR(50),
email VARCHAR(40),
senha VARCHAR(40));

INSERT INTO cadastro (nomeGestor, CNPJ, nomeEmpresa, email, senha) VALUES 
('Marcos', '23535395/000134', 'Dispensers.com', 'dispenser@gmail.com', '123456'),
('Luiza', '00535395/000145', 'Amigos do Papel', 'amigosdopapel@gmail.com', '4567578');

SELECT * FROM cadastro;

CREATE TABLE historico
(id_arduino INT PRIMARY KEY AUTO_INCREMENT,
arduino INT,
distancia DECIMAL (3, 2),
reposicao INT,
dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
estoqueGeral INT,
statusPapel VARCHAR(10) 
CONSTRAINT chkPapel CHECK (statusPapel IN('verde', 'amarelo', 'vermelho')));

INSERT INTO historico (arduino, distancia, reposicao, estoqueGeral, statusPapel) VALUES
(1,  0.23, 10, 300, 'verde'),
(4, 0.44, 9, 299, 'vermelho'),
(6, 0.30, 8, 288, 'amarelo');


SELECT * FROM historico;

CREATE TABLE alerta
(arduino INT,
pontoVermelho CHAR(8)
CONSTRAINT chkPonto CHECK (pontoVermelho IN('vermelho')));

INSERT INTO alerta VALUES
(1, 'vermelho'),
(7, 'vermelho');

SELECT * FROM alerta;
