var express = require("express");
var router = express.Router();

var paineisController = require("../controllers/paineisController");

router.get(`/buscarFuncionarios/:idFilial`, function (req, res) {
  paineisController.buscarFilial(req, res)
})

module.exports = router;