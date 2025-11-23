var database = require("../database/config");

function buscarFuncionarios(idFilial) {
  console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function publicar(): ", idFilial)

  let instrucaoSql = `
  select 
  `
}

module.exports = {
  buscarFuncionarios
}