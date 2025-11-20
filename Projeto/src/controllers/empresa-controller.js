var empresaModel = require("../models/empresa-model");

function cadastrar(req, res) {
    var nomeEmpresa = req.body.nomeEmpresa;
    var nomeFantasia = req.body.nomeFantasia;
    var cnpj = req.body.cnpj;

    empresaModel.cadastrar(nomeEmpresa, nomeFantasia, cnpj)
        .then(result => res.status(200).json(result))
        .catch(erro => {
            console.log("Erro ao cadastrar empresa:", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarPorCnpj(req, res) {
    var cnpj = req.query.cnpj;

    empresaModel.buscarPorCnpj(cnpj)
        .then(result => res.json(result))
        .catch(erro => res.status(500).json(erro.sqlMessage));
}

function buscarPorId(req, res) {
    var id = req.params.id;

    empresaModel.buscarPorId(id)
        .then(result => res.json(result))
        .catch(erro => res.status(500).json(erro.sqlMessage));
}

function listar(req, res) {
    empresaModel.listar()
        .then(result => res.json(result))
        .catch(erro => res.status(500).json(erro.sqlMessage));
}

module.exports = {
    cadastrar,
    buscarPorCnpj,
    buscarPorId,
    listar
};
