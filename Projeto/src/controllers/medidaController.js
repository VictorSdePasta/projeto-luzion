var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {
  var idFilial = req.params.idFilial;

  console.log(`Recuperando as ultimas medidas`);

  medidaModel.buscarUltimasMedidas(idFilial).then(function (resultado) {
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

function buscarBanheiros(req, res) {
  var idFilial = req.params.idFilial

  medidaModel.buscarBanheiros(idFilial).then(function (resultado) {
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

function buscarMedidasEmTempoReal(req, res) {
  var idFilial = req.params.idFilial;

  console.log(`Recuperando medidas em tempo real`);

  medidaModel.buscarMedidasEmTempoReal(idFilial).then(function (resultado) {
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
  buscarUltimasMedidas,
  buscarSetores,
  buscarBanheiros,
  buscarBanheirosSetor,
  buscarMedidasEmTempoReal,
  buscarDadosBanheiro
}