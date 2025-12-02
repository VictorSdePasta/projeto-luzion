var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/setores/:idFilial", function (req, res) {
    medidaController.buscarSetores(req, res);
});

router.get("/banheiroSetor/:idFilial/:setor", function (req, res) {
    medidaController.buscarBanheirosSetor(req, res);
});

router.post("/dadosBanheiro/:idFilial", function (req, res) {
    medidaController.buscarDadosBanheiro(req, res);
});

router.get("/tempoDeEstado/:idDispenser", function (req, res) {
    medidaController.tempoDeEstado(req, res);
});

module.exports = router;