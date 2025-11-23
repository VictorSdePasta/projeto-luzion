var database = require("../database/config");

function buscarFuncionarios(idFilial) {
  console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function publicar(): ", idFilial)

  let instrucaoSql = `
  select f.idFuncionario as idUsuario, f.nome as usuario, f.nivelPermissao as permissao, f.email as email from Funcionario f join Filial fl on fl.idFilial = f.fkFilial where f.fkFilial = ${idFilial};
  `

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql)
}

module.exports = {
  buscarFuncionarios
}