
var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

  return database.executar(instrucaoSql);
}

function buscarPorId(fk) {
  var instrucaoSql = `SELECT * FROM Filial WHERE fkEmpresa = '${fk}'`;

  return database.executar(instrucaoSql);
}

// function listar() {
//   var instrucaoSql = `SELECT id, razao_social, cnpj, codigo_ativacao FROM empresa`;

//   return database.executar(instrucaoSql);
// }

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM Empresa WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(razaoSocial, nomeFantasia, cnpj) {
  console.log(razaoSocial, nomeFantasia, cnpj);
  var instrucaoSql = `INSERT INTO Empresa (razaoSocial, nomeFantasia, contrato, cnpj) VALUES ('${razaoSocial}', '${nomeFantasia}', 2, '${cnpj}')`;

  return database.executar(instrucaoSql);
}

function cadastrarFilial(idEmpresa) {
  var instrucaoSql = `INSERT INTO Filial (titulo, fkEmpresa) VALUES ('Sede', ${idEmpresa})`;

  return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, cadastrarFilial };
