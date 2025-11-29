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

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
