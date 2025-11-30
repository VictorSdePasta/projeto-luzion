var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idFilial", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/setores/:idFilial", function (req, res) {
    medidaController.buscarSetores(req, res);
});

router.get("/banheiros/:idFilial", function (req, res) {
    medidaController.buscarBanheiros(req, res);
});

router.get("/banheiroSetor/:idFilial/:setor", function (req, res) {
    medidaController.buscarBanheirosSetor(req, res);
});

router.get("/tempo-real/:idFilial", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

module.exports = router;