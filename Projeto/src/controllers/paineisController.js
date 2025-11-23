var paineisModel = require("../models/paineisModel");

function buscarFuncionarios(req, res) {
  let idFilial = req.params.idFilial

  paineisModel.buscarFuncionarios(idFilial).then(function (resultado) {
    if (resultado.length > 0) {
      res.status(200).json(resultado)
    } else {
      res.status(204).sen("Nenhum resultado encontrado!")
    }
  }).catch(function (erro) {
    console.log(erro)
    console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage)
    res.status(500).json(erro.sqlMessage)
  })
}

module.exports = {
  buscarFuncionarios
}