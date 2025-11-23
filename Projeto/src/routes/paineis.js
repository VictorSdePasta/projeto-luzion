var express = require("express");
var router = express.Router();

var paineisController = require("../controllers/paineisController");

router.get(`/buscarFuncionarios/:idFilial`, function (req, res) {
  paineisController.buscarFuncionarios(req, res)
})

module.exports = router;