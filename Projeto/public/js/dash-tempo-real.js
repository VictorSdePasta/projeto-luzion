let idFilial = 1;
// let idFilial = sessionStorage.ID_FILIAL
let topo = document.getElementById("divTopo");

let setores = [];
let banheirosSetor = [];
let cabines = [];
let dados = [];

// setor[]>banheiro[]
// [ [], [], [] ]

window.onload = buscarDados(idFilial);

async function buscarDados(idFilial) {
  let resposta = await fetch(`/medidas/setores/${idFilial}`, {
    cache: "no-store",
  });
  if (!resposta.ok) {
    return;
  }
  resposta = await resposta.json();

  document.getElementById("divEmpresa").innerHTML = resposta[0].empresa;

  for (let i = 0; i < resposta.length; i++) {
    if (!setores.includes(resposta[i].setor)) {
      setores.push(resposta[i].setor);
    }
  }

  for (let i = 0; i < setores.length; i++) {
    let banheiroSetor = [];
    let dadoBanheiroSetor = [];
    let cabineBanheiroSetor = [];
    let setor = setores[i];

    let resposta = await fetch(`/medidas/banheiroSetor/${idFilial}/${setor}`, {
      cache: "no-store",
    });
    if (!resposta.ok) {
      return;
    }
    resposta = await resposta.json();
    for (let j = 0; j < resposta.length; j++) {
      let banheiro = resposta[j].banheiro;
      let dadoBanheiro = [];
      let cabineBanheiro = [];

      banheiroSetor.push(banheiro);

      let response = await fetch(`/medidas/dadosBanheiro/${idFilial}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          setorServer: setor,
          banheiroServer: banheiro
        })
      });
      response = await response.json();
      for (let k = 0; k < response.length; k++) {
        const resposta = response[k];
        const valor = resposta.distancia_sensor_mm;
        const maxValor = (resposta.diametroExternoMM - resposta.diametroInternoMM) / 2;

        let porc = ((maxValor - valor) / maxValor) * 100;
        porc = Math.floor(porc);

        let estado = "ideal";

        if (porc <= 20) {
          estado = "critico";
        } else if (porc <= 40) {
          estado = "atencao";
        }

        cabineBanheiro.push(resposta.dispenser);

        dadoBanheiro.push(porc);
      }
      cabineBanheiroSetor.push(cabineBanheiro);
      dadoBanheiroSetor.push(dadoBanheiro);
    }

    cabines.push(cabineBanheiroSetor);
    dados.push(dadoBanheiroSetor);
    banheirosSetor.push(banheiroSetor);
  }

  preencherPagina();
}

function gerarLegendaCores() {
  return `
    <div class="legenda">
      <h4>As cores representam as situações dos banheiros:<br>
        <span><div class="situacao critico"></div> Vermelho - Estado crítico</span>
        <span><div class="situacao"></div> Amarelo - Estado de atenção</span>
        <span><div class="situacao ideal"></div> Verde - Estado ideal</span>
      </h4>
    </div>`;
}

function gerarLinhaLista(nome, numero) {
  return `
    <div class="linha ${numero % 2 == 1 ? '' : 'par'}">
      <div class="coluna">${nome}</div>
      <div class="coluna"><div class="situacao critico"></div></div>
    </div>`;
}

function criarGraficoBase(ctx, labels, data, anotacoes) {
  new Chart(ctx, {
    data: {
      labels,
      datasets: [
        {
          type: "bar",
          data,
          backgroundColor: "rgba(127, 92, 146, 1)",
        },
      ],
    },
    options: {
      plugins: {
        legend: { display: false },
        annotation: { annotations: anotacoes },
      },
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          ticks: { color: "#5A4168", font: { size: 18, weight: "bold" } },
          title: {
            display: true,
            text: "Dispensadores",
            color: "#5A4168",
            font: { size: 18, weight: "bold" },
          },
        },
        y: {
          max: 100,
          beginAtZero: true,
          ticks: { color: "#5A4168", font: { size: 18, weight: "bold" } },
          title: {
            display: true,
            text: "Nível de Abastecimento(%)",
            color: "#5A4168",
            font: { size: 18, weight: "bold" },
          },
        },
      },
    },
  });
}

function gerarCardBanheiro(setor, banheiro, idConjunto, primeiro) {
  const id = `${banheiro.replaceAll(" ", "")}_${setor.replaceAll(" ", "")}`;

  return `
    <div id="divConjunto${idConjunto}" class="conjunto ${primeiro ? "detalhado" : ""}">
      <div class="colunaEsq">
        <div class="kpi">
          <h2>Banheiro</h2>
          <div id="divEstoqueJumbo"><h1>${banheiro}</h1></div>
        </div>

        <div class="kpiBottom">
          <div class="legendaSituacao">
            <h4>Situação do Banheiro</h4>
            <h4>${primeiro ? "Crítico" : "Atenção"}</h4>
            <h4>Dispensadores em estado:</h4>
            <h4><div class="situacao critico"></div> Crítico: <div id="divDispensadoresCritico${id}"></div></h4>
            <h4><div class="situacao"></div> Atenção: <div id="divDispensadoresAtencao${id}"></div></h4>
          </div>
        </div>

        ${gerarLegendaCores()}
      </div>

      <div class="colunaDir">
        <div class="header">
          <div id="divDescricaoKpi${idConjunto}" class="descricaoKpi">
            ${primeiro ? "<h2>Nível de abastecimento dos dispensadores</h2>" : "<h3>Situação do banheiro: <div class='situacao critico'></div></h3>"}
          </div>
        </div>

        <div class="campoGrafico"><canvas id="grafico${id}"></canvas></div>

        <div class="botaoExpandir">
          <div id="divBotaoExpandir${idConjunto}" class="conteudoBotao" onclick="abrir(${idConjunto})">
            <h4>${primeiro ? "Ocultar" : "Mais Detalhes"}</h4>
          </div>
        </div>
      </div>
    </div>
  `;
}

function preencherPagina() {
  let topoHTML = `
    <div id="divConjunto" class="conjunto detalhado">
      <div class="colunaEsq">
        <div class="kpi">
          <h4>Setor em estado<br>de urgência</h4>
          <div id="divEstoqueJumbo"><h2>${setores[0]}</h2></div>
        </div>

        <div class="kpiBottom">
          <div class="listaPrioridade">
            <div class="identificacaoLista">
              Banheiro <div class="divisao"></div> Situação
            </div>
            ${(() => {
      let html = "";
      for (let i = 0; i < banheirosSetor[0].length; i++) {
        html += gerarLinhaLista(banheirosSetor[0][i], i);
      }
      return html;
    })()}
          </div>
        </div>

        ${gerarLegendaCores()}
      </div>

      <div class="colunaDir">
        <div class="header">
          <div class="descricaoKpi">Tempo em estado crítico<h2>1h 37min</h2></div>
          <h1 class="titulo">Nível de abastecimento dos setores</h1>
        </div>

        <div class="grafico">
          <div class="campoGrafico"><canvas id="graficoSetores"></canvas></div>
        </div>

        <h4>O índice mostra a situação geral...</h4>
      </div>
    </div>`;

  topo.innerHTML = topoHTML;

  // gráfico do topo
  criarGraficoBase(
    document.getElementById("graficoSetores"),
    setores,
    [23, 89, 57, 65, 97, 40],
    {
      crit: { type: "line", yMin: 25, yMax: 25, borderColor: "red", borderDash: [6, 6] },
      aten: { type: "line", yMin: 75, yMax: 75, borderColor: "yellow", borderDash: [6, 6] }
    }
  );

  // setor + banheiros
  let pagina = "";
  let id = 1;

  for (let i = 0; i < setores.length; i++) {
    pagina += `<div class="divisaSetor"><div class="linhaDivisa"></div><h1>${setores[i]}</h1></div>`;

    for (let j = 0; j < banheirosSetor[i].length; j++) {
      pagina += gerarCardBanheiro(setores[i], banheirosSetor[i][j], id, j === 0);
      id++;
    }
  }

  document.getElementById("divSetores").innerHTML = pagina;

  // gráficos individuais
  for (let i = 0; i < setores.length; i++) {
    for (let j = 0; j < banheirosSetor[i].length; j++) {
      const idGraf = `${banheirosSetor[i][j].replaceAll(" ", "")}_${setores[i].replaceAll(" ", "")}`;

      criarGraficoBase(
        document.getElementById(`grafico${idGraf}`),
        cabines[i][j],
        dados[i][j],
        {
          crit: { type: "line", yMin: 15, yMax: 15, borderColor: "red", borderDash: [6, 6] },
          aten: { type: "line", yMin: 40, yMax: 40, borderColor: "yellow", borderDash: [6, 6] }
        }
      );
    }
  }
}

function abrir(idConjunto) {
  const div = document.getElementById(`divConjunto${idConjunto}`);
  const desc = document.getElementById(`divDescricaoKpi${idConjunto}`);
  const btn = document.getElementById(`divBotaoExpandir${idConjunto}`);

  const aberto = div.classList.contains("detalhado");

  if (aberto) {
    btn.innerHTML = "<h4>Mais Detalhes</h4>";
    desc.innerHTML = `<h3>Situação do banheiro: <div class="situacao critico"></div></h3>`;
    div.classList.remove("detalhado");
  } else {
    btn.innerHTML = "<h4>Ocultar</h4>";
    desc.innerHTML = "<h2>Nível de abastecimento dos dispensadores</h2>";
    div.classList.add("detalhado");
  }
}