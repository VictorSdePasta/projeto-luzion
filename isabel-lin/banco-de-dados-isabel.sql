CREATE DATABASE luzionDatabase;

USE luzionDatabase;

CREATE TABLE cadastro(
      idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    empresa VARCHAR(50),
    cnpj VARCHAR(14),
    representante VARCHAR(50),
    username VARCHAR(10),
    email VARCHAR(50),
    contato VARCHAR(20),
    senha VARCHAR(50)
);
CREATE TABLE historico(
      idHistorico INT PRIMARY KEY,
    idArduino VARCHAR(5),
    statusPapel VARCHAR(8) CONSTRAINT chkStatus CHECK (statusPapel IN ('verde', 'amarelo', 'vermelho')),
      distancia INT,
    horario DATETIME,
    reposicao INT,
    tipoPapel VARCHAR(30)
);

CREATE TABLE localizacao (
      idLocalizacao INT PRIMARY KEY,
    idArduino VARCHAR(5),
    cep VARCHAR(8),
    endereco VARCHAR(100),
    empresa VARCHAR(50),
    banheiroLocal VARCHAR(10)
);