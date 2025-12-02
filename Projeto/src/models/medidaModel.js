var database = require("../database/config");

function buscarSetores(idFilial) {
  var instrucaoSql = `SELECT * FROM vw_dash_setores_estados WHERE fkFilial = ${idFilial};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarBanheirosSetor(idFilial, setor) {
  var instrucaoSql = `SELECT * FROM vw_dash_banheiros_estados WHERE fkFilial = ${idFilial} AND setor = '${setor}';`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarDadosBanheiro(idFilial, setor, banheiro) {
  var instrucaoSql = `SELECT * FROM vw_dash_dispensadores WHERE fkFilial = ${idFilial} AND setor = '${setor}' AND banheiro = '${banheiro}';`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function tempoDeEstado(idDispenser) {
  var instrucaoSql = `
    SELECT 
        r.dtRegistro tempo,
        CASE
            WHEN (( (ph.diametroExternoMM - ph.diametroInternoMM)/2 - r.valor) / ((ph.diametroExternoMM - ph.diametroInternoMM)/2) ) * 100 < 0 THEN 0
            ELSE ROUND((( (ph.diametroExternoMM - ph.diametroInternoMM)/2 - r.valor) / ((ph.diametroExternoMM - ph.diametroInternoMM)/2) ) * 100)
        END AS valor,
        d.idDispenser
    FROM Registro r
    JOIN Dispenser d ON r.fkDispenser = d.idDispenser
    JOIN PapelHigienico ph ON d.fkPapelHigienico = ph.idPapelHigienico
    WHERE d.idDispenser = ${idDispenser};
  `

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarSetores,
  buscarBanheirosSetor,
  buscarDadosBanheiro,
  tempoDeEstado
}
