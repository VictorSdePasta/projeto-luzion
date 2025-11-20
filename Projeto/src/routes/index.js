var express = require("express");
var path = require("path");
var router = express.Router();

router.get("/cadastro-usuario", (req, res) => {
    res.sendFile(path.join(__dirname, "../../public/HTML/cadastro-usuario.html"));
});

router.get("/cadastro-empresa", (req, res) => {
    res.sendFile(path.join(__dirname, "../../public/HTML/cadastro-empresa.html"));
});

router.get("/login", (req, res) => {
    res.sendFile(path.join(__dirname, "../../public/HTML/login.html"));
});

router.get("/home", (req, res) => {
    res.sendFile(path.join(__dirname, "../../public/HTML/home-page.html"));
});


module.exports = router;
