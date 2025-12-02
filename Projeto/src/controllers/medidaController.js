var medidaModel = require("../models/medidaModel");

function buscarSetores(req, res) {
  var idFilial = req.params.idFilial

  medidaModel.buscarSetores(idFilial).then(function (resultado) {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).send("Nenhum resultado encontrado!")
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });

}

function buscarBanheirosSetor(req, res) {
  var idFilial = req.params.idFilial
  var setor = req.params.setor

  medidaModel.buscarBanheirosSetor(idFilial, setor).then(function (resultado) {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).send("Nenhum resultado encontrado!")
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarDadosBanheiro(req, res) {
  var idFilial = req.params.idFilial
  var setor = req.body.setorServer
  var banheiro = req.body.banheiroServer

  medidaModel.buscarDadosBanheiro(idFilial, setor, banheiro).then(function (resultado) {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).send("Nenhum resultado encontrado!")
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function tempoDeEstado(req, res) {
  let idDispenser = req.params.idDispenser

  medidaModel.tempoDeEstado(idDispenser).then(function (resultado) {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).send("Nenhum resultado encontrado!")
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

module.exports = {
  buscarSetores,
  buscarBanheirosSetor,
  buscarDadosBanheiro,
  tempoDeEstado
}