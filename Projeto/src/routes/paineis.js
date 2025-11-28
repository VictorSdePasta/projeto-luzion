var express = require("express");
var router = express.Router();

var paineisController = require("../controllers/paineisController");

router.get(`/buscarFuncionarios/:idFilial`, function (req, res) {
  paineisController.buscarFuncionarios(req, res)
})

router.get(`/listarEmpresas/:idFilial`, function(req,res) {
  paineisController.listarEmpresas(req, res)
})

module.exports = router;