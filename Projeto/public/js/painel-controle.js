function abrirNovo() {
  fundoModal.style.display = 'flex';
}

function fechar() {
  fundoModal.style.display = 'none';
}


for (let i = 0; i < dados.length; i++) {
  if (i % 2 == 1) {
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
    `<div class="linhaPar">
      <p>Nome fantasia 2</p>
      <p>6</p>
      <div class="icones">
        <img src="../Assets/editar.png" alt="Editar" onclick="editarUsuario(${dados.idUsuario})">
        <img src="../Assets/lixeira.svg" alt="Excluir" onclick="excluirFuncionario(${dados.idUsuario})">
      </div>
    </div>`
  }
}