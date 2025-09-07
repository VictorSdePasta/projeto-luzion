create database projetoPi;
use projetoPi;

create table cadastro(
idUsuario int primary key auto_increment,
nomeEmpresa varchar(70) not null,
nomeGestor varchar(70),
cnpj varchar(14),
email varchar(70) not null,
dtCadastro date,
senha varchar(20) not null
);

CREATE TABLE arduino (
  idArduino INT PRIMARY KEY AUTO_INCREMENT,
  numeroSerie VARCHAR(50) UNIQUE NOT NULL,
  idUsuario INT,
  descricao VARCHAR(255),
  statuSS varchar(30) constraint chkStatusS check(statuSS in('ativo', 'inativo', 'manutencao', 'erro')) DEFAULT 'ativo',
  dtInstalacao DATE
);

create table historico (
    idArduino INT AUTO_INCREMENT PRIMARY KEY,
    registro_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sensor_id VARCHAR(50) NOT NULL,
    localizacao VARCHAR(100),
    reposicao int,
    statusS varchar(30) constraint chkStatus check(status in('Vermelho','Amarelo','Verde'))
);

-- O 'idUsuario' será gerado automaticamente.
INSERT INTO cadastro (nomeEmpresa, nomeGestor, cnpj, email, dtCadastro, senha)
VALUES ('EmpresaExemplo', 'Eric Costa', '12345678901234', 'eric.costa@empresaexemplo.com', '2024-05-15', 'senha123');

-- idUsuario é 1, pois é o primeiro usuário inserido na tabela 'cadastro'.
-- O 'idArduino' será gerado automaticamente.
INSERT INTO arduino (numeroSerie, idUsuario, descricao, statuSS, dtInstalacao)
VALUES ('SN-ARD-001', 1, 'Descrição do Sensor', 'ativo', '2025-09-03');

-- O 'registro_hora' usa a data e hora atual por padrão, mas pode ser especificado.
INSERT INTO historico (idArduino, sensor_id, localizacao, reposicao, statusS)
VALUES (1, 'Sensor-Ultrasssonico-01', 'Banheiro 4° andar - Cabine 8', 10, 'Verde');
