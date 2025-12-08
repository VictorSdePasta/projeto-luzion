let idFilial = sessionStorage.FKFILIAL;
let contrato = sessionStorage.CONTRATO;
let empresa = sessionStorage.NOME_EMPRESA;

let topo = document.getElementById("divTopo");

let setores = [];
let banheirosSetor = [];
let cabines = [];
let dados = [];
let situacoesSetor = [];
let classificacoesSetor = [];
let situacoesBanheiros = [];
let qtdBanheirosAtencao = [];
let qtdBanheirosCrit = [];
let tempo = '0 dias 0 horas 00 minutos'


let graficoSetores = null;
let graficosBanheiros = [];

window.onload = autenticar();
function autenticar() {
  if (contrato == 2) {
    document.getElementById("divEmpresa").innerHTML = `Olá ${empresa}! Obrigado por escolher a Luzion, em breve entraremos em contato para ativar seu contrato.`;
  } else {
    buscarDados()
  }
}
async function buscarDados() {
  console.log()
  let resposta = await fetch(`/medidas/setores/${idFilial}`, {
    cache: "no-store",
  });
  if (!resposta.ok) {
    return;
  }
  resposta = await resposta.json();

  document.getElementById("divEmpresa").innerHTML = resposta[0].empresa;

  for (let i = 0; i < resposta.length; i++) {
    setores.push(resposta[i].setor);
    situacoesSetor.push(resposta[i].situacao_setor)
    classificacoesSetor.push(resposta[i].classificacao_setor)
  }

  for (let i = 0; i < setores.length; i++) {
    let banheiroSetor = [];
    let dadoBanheiroSetor = [];
    let cabineBanheiroSetor = [];
    let setor = setores[i];
    let situacoesBanheiroSetor = [];
    let qtdAtencao = []
    let qtdCrit = []

    let resposta = await fetch(`/medidas/banheiroSetor/${idFilial}/${setor}`, {
      cache: "no-store",
    });
    if (!resposta.ok) {
      return;
    }
    resposta = await resposta.json();
    for (let j = 0; j < resposta.length; j++) {
      let banheiro = resposta[j].banheiro;
      let situacao = resposta[j].classificacao_banheiro
      let atencao = resposta[j].dispensadorAtencao
      let crit = resposta[j].dispensadorCritico
      let dadoBanheiro = [];
      let cabineBanheiro = [];

      situacoesBanheiroSetor.push(situacao)
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
        const valor = Number(resposta.porcentagem_uso);
        const ultimaData = resposta.ultima_medicao
        const idDispenser = resposta.idDispenser

        if (k == 0 && j == 0 && i == 0) {
          let resp = await fetch(`/medidas/tempoDeEstado/${idDispenser}`)
          resp = await resp.json()

          let dtIdentificada = null;

          for (let j = 0; j < resp.length; j++) {
            const t = resp[j].tempo;
            const v = resp[j].valor;

            if (dtIdentificada == null) {
              if (v < 20) {
                dtIdentificada = t;
              } else if (v < 40) {
                dtIdentificada = t;
              }
            } else if (v >= 40) {
              dtIdentificada = null
            }
          }

          if (!dtIdentificada) {
            tempo = "";
          } else {
            let dtInicial = new Date(ultimaData).getTime()
            let dtFinal = new Date(dtIdentificada).getTime()

            let seg = Math.floor(Math.abs(dtFinal - dtInicial) / 1000)
            let dias = Math.floor(seg / 86400)
            seg %= 86400
            let horas = Math.floor(seg / 3600)
            seg %= 3600
            let minutos = Math.floor(seg / 60)
            seg %= 60

            tempo = `${dias > 0 ? `${dias} dias ` : ``}${horas > 0 ? `${horas} horas` : ``}${minutos > 0 ? `${minutos} minutos` : ``}`
          }
        }

        cabineBanheiro.push(resposta.dispenser);
        dadoBanheiro.push(valor);
      }

      qtdAtencao.push(atencao)
      qtdCrit.push(crit)
      cabineBanheiroSetor.push(cabineBanheiro);
      dadoBanheiroSetor.push(dadoBanheiro);
    }

    qtdBanheirosAtencao.push(qtdAtencao)
    qtdBanheirosCrit.push(qtdCrit)
    cabines.push(cabineBanheiroSetor);
    dados.push(dadoBanheiroSetor);
    banheirosSetor.push(banheiroSetor);
    situacoesBanheiros.push(situacoesBanheiroSetor)
  }

  preencherPagina();
}

function gerarLegendaCores() {
  return `
    <div class="legenda">
      <h4>As cores representam as situações dos banheiros:<br>
        <span><div class="situacao critico"></div> - Estado crítico</span>
        <span><div class="situacao"></div> - Estado de atenção</span>
        <span><div class="situacao ideal"></div> - Estado ideal</span>
      </h4>
    </div>`;
}

function gerarLinhaLista(nome, i) {
  return `
    <div class="linha ${i % 2 == 1 ? '' : 'par'}">
      <div class="coluna">${nome}</div>
      <div class="coluna"><div class="situacao ${situacoesBanheiros[0][i]}"></div></div>
    </div>`;
}

function criarGraficoBase(ctx, labels, data, anotacoes) {
  return new Chart(ctx, {
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
          }
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
          }
        }
      }
    }
  });
}

function criarGraficoTopo(ctx, labels, data, anotacoes) {
  return new Chart(ctx, {
    data: {
      labels,
      datasets: [
        {
          type: "bar",
          data,
          backgroundColor: "rgba(127, 92, 146, 1)",
        }
      ]
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
            text: "Setores",
            color: "#5A4168",
            font: { size: 18, weight: "bold" }
          },
        },
        y: {
          max: 100,
          beginAtZero: true,
          ticks: { color: "#5A4168", font: { size: 18, weight: "bold" } },
          title: {
            display: true,
            text: "Índice de Abastecimento(%)",
            color: "#5A4168",
            font: { size: 18, weight: "bold" }
          }
        }
      }
    }
  });
}

function gerarCardBanheiro(setor, banheiro, idConjunto, primeiro, situacao, qtdAt, qtdCrit) {
  const id = `${banheiro.replaceAll(" ", "")}_${setor.replaceAll(" ", "")}`;

  return `
    <div id="divConjunto${idConjunto}" class="conjunto ${primeiro ? "detalhado" : ""}">
      <div class="colunaEsq">
        <div class="kpi">
          <h2>Banheiro</h2>
          <div id="divEstoque"><h1>${banheiro}</h1></div>
        </div>

        <div class="kpiBottom">
          <div class="legendaSituacao">
            <h4>Situação do Banheiro</h4>
            <h4>${situacao == 'atencao' ? 'Atenção' : situacao == 'ideal' ? 'Ideal' : 'Crítico'}</h4>
            <h4>Dispensadores em estado:</h4>
            <h4><div class="situacao critico"></div> Crítico: <div id="divDispensadoresCritico${id}">${qtdCrit}</div></h4>
            <h4><div class="situacao"></div> Atenção: <div id="divDispensadoresAtencao${id}"></div>${qtdAt}</h4>
          </div>
        </div>

        ${gerarLegendaCores()}
      </div>

      <div class="colunaDir">
        <div class="header">
          <div id="divDescricaoKpi${idConjunto}" class="descricaoKpi">
            ${primeiro ? "<h2>Nível de abastecimento dos dispensadores</h2>" : `<h3>Situação do banheiro: <div class='situacao ${situacao}'></div></h3>`}
          </div>
        </div>

        <div class="campoGrafico"><canvas id="grafico${id}"></canvas></div>

        <div class="botaoExpandir">
          <div id="divBotaoExpandir${idConjunto}" class="conteudoBotao" onclick="abrir(${idConjunto}, '${situacao}')">
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
          <h4>Setor em maior<br>estado de urgência</h4>
          <div id="divEstoque"><h2>${setores[0]}</h2></div>
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
          <div class="descricaoKpi">Tempo em estado ${classificacoesSetor[0] == 'atencao' ? 'de Atenção' : 'Crítico'}<h2>${tempo}</h2></div>
          <h1 class="titulo">Nível de abastecimento dos setores</h1>
        </div>

        <div class="grafico">
          <div class="campoGrafico"><canvas id="graficoSetores"></canvas></div>
        </div>
        <h4>O índice mostra a situação geral dos banheiros de cada setor, levando em conta o estado dos dispensadores. Quanto mais dispensadores estiverem em atenção ou crítico, maior será a urgência de reposição naquele setor.</h4>
      </div>
    </div>`;

  topo.innerHTML = topoHTML;

  // gráfico do topo
  graficoSetores = criarGraficoTopo(
    document.getElementById("graficoSetores"),
    setores,
    situacoesSetor,
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
      pagina += gerarCardBanheiro(setores[i], banheirosSetor[i][j], id, j === 0, situacoesBanheiros[i][j], qtdBanheirosAtencao[i][j], qtdBanheirosCrit[i][j]);
      id++;
    }
  }

  document.getElementById("divSetores").innerHTML = pagina;

  // gráficos individuais
  for (let i = 0; i < setores.length; i++) {
    for (let j = 0; j < banheirosSetor[i].length; j++) {

      const idGraf = `${banheirosSetor[i][j].replaceAll(" ", "")}_${setores[i].replaceAll(" ", "")}`;

      if (!graficosBanheiros[i]) graficosBanheiros[i] = [];


      graficosBanheiros[i][j] = criarGraficoBase(
        document.getElementById(`grafico${idGraf}`),
        cabines[i][j],
        dados[i][j],
        {
          crit: { type: "line", yMin: 20, yMax: 20, borderColor: "red", borderDash: [6, 6] },
          aten: { type: "line", yMin: 40, yMax: 40, borderColor: "yellow", borderDash: [6, 6] }
        }
      );
    }
  }

}

function abrir(idConjunto, situacao) {
  const div = document.getElementById(`divConjunto${idConjunto}`);
  const desc = document.getElementById(`divDescricaoKpi${idConjunto}`);
  const btn = document.getElementById(`divBotaoExpandir${idConjunto}`);

  const aberto = div.classList.contains("detalhado");

  if (aberto) {
    btn.innerHTML = "<h4>Mais Detalhes</h4>";
    desc.innerHTML = `<h3>Situação do banheiro: <div class="situacao ${situacao}"></div></h3>`;
    div.classList.remove("detalhado");
  } else {
    btn.innerHTML = "<h4>Ocultar</h4>";
    desc.innerHTML = "<h2>Nível de abastecimento dos dispensadores</h2>";
    div.classList.add("detalhado");
  }
}

async function atualizarGrafico() {

  // limpa as arrays 
  setores = [];
  banheirosSetor = [];
  cabines = [];
  dados = [];
  situacoesSetor = [];
  classificacoesSetor = [];
  situacoesBanheiros = [];
  qtdBanheirosAtencao = [];
  qtdBanheirosCrit = [];

  // busca os setores atualizadds 
  let resposta = await fetch(`/medidas/setores/${idFilial}`, { cache: "no-store" });
  resposta = await resposta.json();

  for (let i = 0; i < resposta.length; i++) {
    setores.push(resposta[i].setor);
    situacoesSetor.push(resposta[i].situacao_setor);
    classificacoesSetor.push(resposta[i].classificacao_setor);
  }

  // busca os dispensers e os banheiros dos setores 
  for (let i = 0; i < setores.length; i++) {
    let setor = setores[i];

    let respostaBan = await fetch(`/medidas/banheiroSetor/${idFilial}/${setor}`, {
      cache: "no-store"
    });
    respostaBan = await respostaBan.json();

    let banheiroSetor = [];
    let situacoesBanheiroSetor = [];
    let cabinesSetor = [];
    let dadosSetor = [];
    let qtdAt = [];
    let qtdCr = [];

    for (let j = 0; j < respostaBan.length; j++) {
      let banheiro = respostaBan[j].banheiro;
      let situacao = respostaBan[j].classificacao_banheiro;
      let atencao = respostaBan[j].dispensadorAtencao;
      let crit = respostaBan[j].dispensadorCritico;

      banheiroSetor.push(banheiro);
      situacoesBanheiroSetor.push(situacao);
      qtdAt.push(atencao);
      qtdCr.push(crit);

      // dispensers e os valores
      let reqDisp = await fetch(`/medidas/dadosBanheiro/${idFilial}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ setorServer: setor, banheiroServer: banheiro })
      });

      reqDisp = await reqDisp.json();

      const idDispenser = respostaBan.idDispenser
      let cab = [];
      let dat = [];

      for (let k = 0; k < reqDisp.length; k++) {
        if (k == 0 && j == 0 && i == 0) {
          let resp = await fetch(`/medidas/tempoDeEstado/${idDispenser}`)
          resp = await resp.json()

          let dtIdentificada = null;

          for (let j = 0; j < resp.length; j++) {
            const t = resp[j].tempo;
            const v = resp[j].valor;

            if (dtIdentificada == null) {
              if (v < 20) {
                dtIdentificada = t;
              } else if (v < 40) {
                dtIdentificada = t;
              }
            } else if (v >= 40) {
              dtIdentificada = null
            }
          }

          if (!dtIdentificada) {
            tempo = "";
          } else {
            let dtInicial = new Date(ultimaData).getTime()
            let dtFinal = new Date(dtIdentificada).getTime()

            let seg = Math.floor(Math.abs(dtFinal - dtInicial) / 1000)
            let dias = Math.floor(seg / 86400)
            seg %= 86400
            let horas = Math.floor(seg / 3600)
            seg %= 3600
            let minutos = Math.floor(seg / 60)
            seg %= 60

            tempo = `${dias > 0 ? `${dias} dias ` : ``}${horas > 0 ? `${horas} horas` : ``}${minutos > 0 ? `${minutos} minutos` : ``}`
          }
        }

        cab.push(reqDisp[k].dispenser);
        dat.push(Number(reqDisp[k].porcentagem_uso));
      }

      cabinesSetor.push(cab);
      dadosSetor.push(dat);
    }

    cabines.push(cabinesSetor);
    dados.push(dadosSetor);
    banheirosSetor.push(banheiroSetor);
    situacoesBanheiros.push(situacoesBanheiroSetor);
    qtdBanheirosAtencao.push(qtdAt);
    qtdBanheirosCrit.push(qtdCr);
  }

  //atualiza grafico topo 
  graficoSetores.data.labels = setores;
  graficoSetores.data.datasets[0].data = situacoesSetor;
  graficoSetores.update();

  // atualiza os grafico individuais
  for (let i = 0; i < setores.length; i++) {
    for (let j = 0; j < banheirosSetor[i].length; j++) {
      let graf = graficosBanheiros[i][j];

      graf.data.labels = cabines[i][j];
      graf.data.datasets[0].data = dados[i][j];
      graf.update();
    }
  }

  preencherPagina()
  console.log("Gráficos atualizados!");
}

function limparSessao() {
  sessionStorage.clear();
  window.location = "../login.html";
}
setInterval(() => atualizarGrafico(), 5000);