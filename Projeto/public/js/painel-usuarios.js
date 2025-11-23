function abrirNovo() {
  fundoFilial.style.display = 'flex';
}

function fechar() {
  fundoFilial.style.display = 'none';
}

const idFilial = sessionStorage.ID_FILIAL
const idUsuario = sessionStorage.ID_USUARIO
const nivelPerm = sessionStorage.NIVEL_PERMISSAO

fetch(`/paineis/buscarFuncionarios/${idFilial}`).then(function (resposta) {
  if (resposta.ok) {
    if (resposta.status == 204) {
      throw "nenhum funcionario encontrado"
    }
    resposta.json().then(function (resposta) {
      console.log("Dados recebidos: ", JSON.stringify(resposta))
      let tabela = document.getElementById("divTabela")
      tabela.innerHTML = ``

      for (let i = 0; i < resposta.length - 1; i++) {
        const dados = resposta[i]
        let msg = ``
        if (i % 2 == 1) {
          msg +=
            `<div class="corpoTabela">
              <div class="linhaImpar">
                <p>${dados.usuario}</p>
                <p>${dados.permissao}</p>
                <div class="icones">
                  <img src="../Assets/editar.png" alt="Editar" onclick="editarUsuario(${dados.idUsuario})">
                  <img src="../Assets/lixeira.svg" alt="Excluir" onclick="excluirFuncionario(${dados.idUsuario})">
                </div>
              </div>`
        } else {
          msg +=
            `<div class="linhaPar">
              <p>${dados.usuario}</p>
              <p>${dados.permissao}</p>
              <div class="icones">
                <img src="../Assets/editar.png" alt="Editar" onclick="editarUsuario(${dados.idUsuario})">
                <img src="../Assets/lixeira.svg" alt="Excluir" onclick="excluirFuncionario(${dados.idUsuario})">
              </div>
            </div>`
        }
        tabela.innerHTML += msg
      }

      tabela.innerHTML +=
        `<div class="linhaPar linhaFinal">
          <p>${resposta[resposta.length - 1].usuario}</p>
          <p>${resposta[resposta.length - 1].permissao}</p>
          <div class="icones">
            <img src="../Assets/editar.png" alt="Editar" onclick="editarUsuario(${resposta[resposta.length - 1].idUsuario})">
            <img src="../Assets/lixeira.svg" alt="Excluir" onclick="excluirFuncionario(${resposta[resposta.length - 1].idUsuario})">
          </div>
        </div>
      </div>`
    })

  } else {
    throw ('Houve um erro na API!');
  }
}).catch(function (resposta) {
  console.error(resposta)
})
