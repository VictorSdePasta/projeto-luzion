var database = require("../Banco-de-dados/config");

function cadastrar(nomeEmpresa, nomeFantasia, cnpj) {
    var instrucao = `
        INSERT INTO Empresa (razaoSocial, nomeFantasia, cnpj)
        VALUES ('${nomeEmpresa}', '${nomeFantasia}', '${cnpj}');
    `;
    return database.executar(instrucao);
}

function buscarPorCnpj(cnpj) {
    var instrucao = `
        SELECT * FROM Empresa WHERE cnpj = '${cnpj}';
    `;
    return database.executar(instrucao);
}

function buscarPorId(idEmpresa) {
    var instrucao = `
        SELECT * FROM Empresa WHERE idEmpresa = ${idEmpresa};
    `;
    return database.executar(instrucao);
}

function listar() {
    var instrucao = `SELECT * FROM Empresa;`;
    return database.executar(instrucao);
}

module.exports = {
    cadastrar,
    buscarPorCnpj,
    buscarPorId,
    listar
};

