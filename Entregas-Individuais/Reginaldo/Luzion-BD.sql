CREATE DATABASE Luzion;
USE Luzion;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeFantasia VARCHAR(100) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(18) NOT NULL UNIQUE
);

CREATE TABLE filial (
    idFilial INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    fkEmpresa INT,
    logradouro VARCHAR(200),
    numero VARCHAR(10),
    cep CHAR(9),
    cidade VARCHAR(50),
    estado CHAR(2),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(15),
    nivelAcesso VARCHAR(20) NOT NULL,
    fkFilial INT,
    FOREIGN KEY (fkFilial) REFERENCES filial(idFilial)
);

CREATE TABLE tipoPapel (
    idTipoPapel INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45) NOT NULL,
    diametroExterno INT,
    diametroInterno INT,
    largura INT
);

CREATE TABLE estoque (
    idEstoque INT PRIMARY KEY AUTO_INCREMENT,
    fkFilial INT,
    fkTipoPapel INT,
    quantidade INT DEFAULT 0,
    capacidadeMaxima INT NOT NULL,
    FOREIGN KEY (fkFilial) REFERENCES filial(idFilial),
    FOREIGN KEY (fkTipoPapel) REFERENCES tipoPapel(idTipoPapel)
);

CREATE TABLE banheiro (
    idBanheiro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    localizacao VARCHAR(100),
    fkFilial INT,
    FOREIGN KEY (fkFilial) REFERENCES filial(idFilial)
);

CREATE TABLE dispenser (
    idDispenser INT PRIMARY KEY AUTO_INCREMENT,
    identificacao VARCHAR(50) NOT NULL,
    fkBanheiro INT,
    fkTipoPapel INT,
    FOREIGN KEY (fkBanheiro) REFERENCES banheiro(idBanheiro),
    FOREIGN KEY (fkTipoPapel) REFERENCES tipoPapel(idTipoPapel)
);

CREATE TABLE registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    fkDispenser INT,
    fkEstoque INT,
    nivelPapel INT NOT NULL,
    dataHora DATETIME NOT NULL,
    tipoRegistro VARCHAR(20) NOT NULL,
    FOREIGN KEY (fkDispenser) REFERENCES dispenser(idDispenser),
    FOREIGN KEY (fkEstoque) REFERENCES estoque(idEstoque)
);

INSERT INTO empresa (nomeFantasia, razaoSocial, cnpj) VALUES 
('SenGas', 'SenGases LTDA', '12.345.678/0001-90'),
('SmartBeef', 'SmartsBeefs LTDA', '98.765.432/0001-10');

INSERT INTO filial (nome, fkEmpresa, logradouro, numero, cidade, estado) VALUES 
('Sede Principal', 1, 'Av. Paulista', '1000', 'São Paulo', 'SP'),
('Filial Centro', 2, 'R. XV de Novembro', '500', 'São Paulo', 'SP');

INSERT INTO usuario (nome, email, senha, nivelAcesso, fkFilial) VALUES 
('Admin Master', 'admin@luzion.com', 'admin123', 'admin', 1),
('Gerente Filial', 'gerente@luzion.com', 'gerente123', 'gerente', 2);

INSERT INTO tipoPapel (modelo, diametroExterno, diametroInterno, largura) VALUES 
('Comum', 100, 40, 100),
('Jumbo', 120, 50, 100);

INSERT INTO estoque (fkFilial, fkTipoPapel, quantidade, capacidadeMaxima) VALUES 
(1, 1, 1500, 3000),
(2, 2, 2000, 4000);

INSERT INTO banheiro (nome, localizacao, fkFilial) VALUES 
('Banheiro Térreo', 'Próximo à recepção', 1),
('Banheiro Andar 1', 'Ao lado do elevador', 2);

INSERT INTO dispenser (identificacao, fkBanheiro, fkTipoPapel) VALUES 
('Cabine 1', 1, 1),
('Cabine 2', 1, 1),
('Dispenser Principal', 2, 2);

SELECT e.nomeFantasia AS Empresa, f.nome AS Filial, u.nome AS Responsavel
FROM empresa e 
JOIN filial f ON e.idEmpresa = f.fkEmpresa
JOIN usuario u ON f.idFilial = u.fkFilial;

SELECT f.nome AS Filial, tp.modelo AS Tipo_Papel, 
       e.quantidade AS Qtd_Atual, 
       e.capacidadeMaxima AS Capacidade_Max,
       (e.quantidade / e.capacidadeMaxima) * 100 AS Percentual
FROM estoque e
JOIN filial f ON e.fkFilial = f.idFilial
JOIN tipoPapel tp ON e.fkTipoPapel = tp.idTipoPapel;
