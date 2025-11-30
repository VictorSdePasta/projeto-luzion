var database = require("../database/config");

function buscarUltimasMedidas(idFilial) {
  var instrucaoSql = `SELECT * FROM vw_dash_dispensadores WHERE fkFilial = ${idFilial};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idFilial) {
  var instrucaoSql = `SELECT * FROM vw_situacao_banheiros WHERE fkFilial = ${idFilial};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarSetores(idFilial) {
  var instrucaoSql = `SELECT * FROM vw_dash_setores WHERE fkFilial = ${idFilial};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarBanheiros(idFilial) {
  var instrucaoSql = `SELECT banheiro, setor FROM vw_dash_banheiros WHERE fkFilial = ${idFilial};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarBanheirosSetor(idFilial, setor) {
  var instrucaoSql = `SELECT * FROM vw_dash_banheiros WHERE fkFilial = ${idFilial} AND setor = '${setor}';`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarDadosBanheiro(idFilial, setor, banheiro) {
  var instrucaoSql = `SELECT * FROM vw_dash_dispensadores WHERE fkFilial = ${idFilial} AND setor = '${setor}' AND banheiro = '${banheiro}';`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarUltimasMedidas,
  buscarSetores,
  buscarBanheiros,
  buscarBanheirosSetor,
  buscarMedidasEmTempoReal,
  buscarDadosBanheiro
}
