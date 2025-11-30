let idFilial = 1
// let idFilial = sessionStorage.ID_FILIAL
let topo = document.getElementById('divTopo');

let setores = []
let banheirosSetor = []
let cabines = [];
let dados = []

// setor[]>banheiro[]
// [ [], [], [] ]

window.onload = buscarDados(idFilial)

async function buscarDados(idFilial) {
  let resposta = await fetch(`/medidas/setores/${idFilial}`, { cache: 'no-store' })
  if (!resposta.ok) { return }
  resposta = await resposta.json()

  document.getElementById('divEmpresa').innerHTML = resposta[0].empresa

  for (let i = 0; i < resposta.length; i++) {
    if (!setores.includes(resposta[i].setor)) { setores.push(resposta[i].setor) }
  }

  for (let i = 0; i < setores.length; i++) {
    let banheiroSetor = []
    let dadoBanheiroSetor = []
    let cabineBanheiroSetor = []
    let setor = setores[i]

    let resposta = await fetch(`/medidas/banheiroSetor/${idFilial}/${setor}`, { cache: 'no-store' })
    if (!resposta.ok) { return }
    resposta = await resposta.json()
    for (let j = 0; j < resposta.length; j++) {
      let banheiro = resposta[j].banheiro
      let dadoBanheiro = []
      let cabineBanheiro = []

      banheiroSetor.push(banheiro)

      let response = await fetch(`/medidas/dadosBanheiro/${idFilial}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          setorServer: setor,
          banheiroServer: banheiro
        })
      })
      response = await response.json()
      for (let k = 0; k < response.length; k++) {
        let resp = response[k]
        let valor = resp.distancia_sensor_mm
        let maxValor = (resp.diametroExternoMM - resp.diametroInternoMM) / 2
        let porc = (maxValor - valor) / maxValor * 100

        cabineBanheiro.push(resp.dispenser)
        dadoBanheiro.push(Math.floor(porc))
      }

      cabineBanheiroSetor.push(cabineBanheiro)
      dadoBanheiroSetor.push(dadoBanheiro)
    }

    cabines.push(cabineBanheiroSetor)
    dados.push(dadoBanheiroSetor)
    banheirosSetor.push(banheiroSetor)
  }

  preencherPagina()
}

function preencherPagina() {

  let conteudoTopo = `
  <div id="divConjunto" class="conjunto detalhado">
    <div class="colunaEsq">
      <div class="kpi">
        <h4>Setor em estado<br>de urgência</h4>
        <div id="divEstoqueJumbo">
          <h2>${setores[0]}</h2>
        </div>
      </div>
      <div class="kpiBottom">
        <div class="listaPrioridade">`

  for (let i = 0; i < setores.length - 1; i++) {
    if (i == 0) {
      conteudoTopo += `
      <div class="identificacaoLista">
        Banheiro <div class="divisao"></div> Situação
      </div>
      `
    }

    if (i % 2 == 0) {
      conteudoTopo += `
      <div class="linha par">
        <div class="coluna">
          ${banheirosSetor[i]}
        </div>
        <div class="coluna">
          <div class="situacao critico"></div>
        </div>
      </div>
      `
    } else {
      conteudoTopo += `
      <div class="linha">
        <div class="coluna">
          ${banheirosSetor[i]}
        </div>
        <div class="coluna">
          <div class="situacao critico"></div>
        </div>
      </div>
      `
    }
  }

  conteudoTopo += `
  </div>
      </div>
      <div class="legenda">
        <h4>As cores representam as situações dos banheiros:<br>
          <span>
            <div class="situacao critico"></div>
            Vermelho - Estado crítico
          </span>
          <span>
            <div class="situacao"></div>
            Amarelo - Estado de atenção
          </span>
          <span>
            <div class="situacao ideal"></div>
            Verde - Estado ideal
          </span>
        </h4>
      </div>
    </div>
    <div class="colunaDir">
      <div class="header">
        <div id="divDescricaoKpi" class="descricaoKpi">
          Tempo em estado crítico
          <h2>1h 37min</h2>
        </div>
        <h1 class="titulo">Nível de abastecimento dos setores</h1>
      </div>
      <div class="grafico">
        <div class="campoGrafico">
          <canvas id="graficoSetores"></canvas>
        </div>
      </div>
      <h4>O índice mostra a situação geral dos banheiros de cada setor, levando em conta o estado dos dispensadores. Quanto mais dispensadores estiverem em atenção ou crítico, maior será a urgência de reposição naquele setor.</h4>
    </div>
  </div>
  `

  topo.innerHTML = conteudoTopo

  // Configuração do gráfico do topo (geral)
  // Configuração dos limites
  const setorCrit = {
    type: 'line',
    yMin: 25,
    yMax: 25,
    borderColor: 'red',
    borderWidth: 2,
    borderDash: [6, 6]
  }

  const setorAten = {
    type: 'line',
    yMin: 75,
    yMax: 75,
    borderColor: 'yellow',
    borderWidth: 2,
    borderDash: [6, 6]
  }

  const ctxSetores = document.getElementById('graficoSetores');

  // Configuração dos gráficos individuais
  new Chart(ctxSetores, {
    data: {
      labels: setores,
      datasets: [{
        type: 'bar',
        label: '',
        data: [23, 89, 57, 65, 97, 40],
        backgroundColor: 'rgba(127, 92, 146, 100)'
      }]
    },
    options: {
      plugins: {
        legend: {
          display: false
        },
        annotation: {
          annotations: {
            setorCrit,
            setorAten
          }
        }
      },
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          ticks: {
            color: '#5A4168',
            font: {
              size: 18,
              weight: 'bold'
            }
          },
          title: {
            display: true,
            text: 'Setores',
            color: '#5A4168',
            font: {
              size: 18,
              weight: 'bold'
            }
          }
        },
        y: {
          max: 100,
          ticks: {
            color: '#5A4168',
            font: {
              size: 18,
              weight: 'bold'
            }
          },
          title: {
            display: true,
            text: 'Índice de Abastecimento(%)',
            color: '#5A4168',
            font: {
              size: 18,
              weight: 'bold'
            }
          },
          beginAtZero: true
        }
      }
    }
  });

  let contador = 1
  let campoSetores = document.getElementById("divSetores")
  let conteudoPagina = ``

  for (let i = 0; i < setores.length; i++) {
    conteudoPagina +=
      `
    <div class="divisaSetor">
      <div class="linhaDivisa"></div>
      <h1>${setores[i]}</h1>
    </div>
    `

    for (let j = 0; j < banheirosSetor[i].length; j++) {
      if (j == 0) {
        conteudoPagina += `
      <div id="divConjunto${contador}" class="conjunto detalhado">
          <div class="colunaEsq">
            <div class="kpi">
              <h2>Banheiro</h2>
              <div id="divEstoqueJumbo">
                <h1>${banheirosSetor[i][j]}</h1>
              </div>
            </div>
            <div class="kpiBottom">
              <div class="legendaSituacao">
                <h4>Situação do Banheiro</h4>
                <h4>Crítico</h4>
                <h4>Dispensadores em estado:</h4>
                <h4>
                  <div class="situacao critico"></div> Crítico: <div id="divDispensadoresCritico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i]}`}"></div>
                </h4>
                <h4>
                  <div class="situacao"></div> Atenção: <div id="divDispensadoresAtencao${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i]}`}"></div>
                </h4>
              </div>
            </div>
            <div class="legenda">
              <h4>As cores representam as situações dos banheiros:<br>
                <span>
                  <div class="situacao critico"></div>
                  Vermelho - Estado crítico
                </span>
                <span>
                  <div class="situacao"></div>
                  Amarelo - Estado de atenção
                </span>
                <span>
                  <div class="situacao ideal"></div>
                  Verde - Estado ideal
                </span>
              </h4>
            </div>
          </div>
          <div class="colunaDir">
            <div class="header">
              <div id="divDescricaoKpi${contador}" class="descricaoKpi">
                <h2>Nível de abastecimento dos dispensadores</h2>
              </div>
            </div>

            <div class="campoGrafico">
              <canvas id="grafico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i]}`}"></canvas>
            </div>

            <div class="botaoExpandir"><div id="divBotaoExpandir${contador}" class="conteudoBotao" onclick="abrir(${contador})"><h4>Ocultar</h4></div> </div>
          </div>
        </div>
      `
      } else {
        conteudoPagina += `
      <div id="divConjunto${contador}" class="conjunto">
          <div class="colunaEsq">
            <div class="kpi">
              <h2>Banheiro</h2>
              <div id="divEstoqueJumbo">
                <h1>${banheirosSetor[i][j]}</h1>
              </div>
            </div>
            <div class="kpiBottom">
              <div class="legendaSituacao">
                <h4>Situação do Banheiro</h4>
                <h4>Atenção</h4>
                <h4>Dispensadores em estado:</h4>
                <h4>
                  <div class="situacao critico"></div> Crítico: <div id="divDispensadoresCritico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i]}`}"></div>
                </h4>
                <h4>
                  <div class="situacao"></div> Atenção: <div id="divDispensadoresCritico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i]}`}"></div>
                </h4>
              </div>
            </div>
            <div class="legenda">
              <h4>As cores representam as situações dos banheiros:<br>
                <span>
                  <div class="situacao critico"></div>
                  Vermelho - Estado crítico
                </span>
                <span>
                  <div class="situacao"></div>
                  Amarelo - Estado de atenção
                </span>
                <span>
                  <div class="situacao ideal"></div>
                  Verde - Estado ideal
                </span>
              </h4>
            </div>
          </div>
          <div class="colunaDir">
            <div class="header">
              <div id="divDescricaoKpi${contador}" class="descricaoKpi">
                <h3>Situação do banheiro: <div class="situacao critico"></div>
                </h3>
              </div>
            </div>
            <div class="campoGrafico"> <canvas id="grafico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i]}`}"></canvas> </div>
            <div class="botaoExpandir"><div id="divBotaoExpandir${contador}" class="conteudoBotao" onclick="abrir(${contador})"><h4>Mais Detalhes</h4></div> </div>
          </div>
        </div>
      `
      }
      contador++
    }
  }

  campoSetores.innerHTML = conteudoPagina

  const dispenserCrit = {
    type: 'line',
    yMin: 15,
    yMax: 15,
    borderColor: 'red',
    borderWidth: 2,
    borderDash: [6, 6]
  }

  const dispenserAten = {
    type: 'line',
    yMin: 40,
    yMax: 40,
    borderColor: 'yellow',
    borderWidth: 2,
    borderDash: [6, 6]
  }

  for (let i = 0; i < setores.length; i++) {
    const setor = setores[i];
    const banheiros = banheirosSetor[i];
    const dadosSetor = dados[i];
    const cabineAtual = cabines[i]

    for (let j = 0; j < banheiros.length; j++) {
      const nomeBanheiro = banheiros[j];
      const dadosBanheiro = dadosSetor[j];
      const cabines = cabineAtual[j]

      const ctxBanheiro = document.getElementById(`grafico${nomeBanheiro.replaceAll(' ', '')}${banheiros}`);

      new Chart(ctxBanheiro, {
        data: {
          labels: cabines,
          datasets: [{
            type: 'bar',
            label: `${setor} - ${nomeBanheiro}`,
            data: dadosBanheiro,
            backgroundColor: 'rgba(127, 92, 146, 1)'
          }]
        },
        options: {
          plugins: {
            legend: {
              display: false
            },
            annotation: {
              annotations: {
                dispenserCrit,
                dispenserAten
              }
            }
          },
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            x: {
              ticks: {
                color: '#5A4168',
                font: {
                  size: 18,
                  weight: 'bold'
                }
              },
              title: {
                display: true,
                text: 'Dispensadores',
                color: '#5A4168',
                font: {
                  size: 18,
                  weight: 'bold'
                }
              }
            },
            y: {
              max: 100,
              ticks: {
                color: '#5A4168',
                font: {
                  size: 18,
                  weight: 'bold'
                }
              },
              title: {
                display: true,
                text: 'Nível de Abastecimento(%)',
                color: '#5A4168',
                font: {
                  size: 18,
                  weight: 'bold'
                }
              },
              beginAtZero: true
            }
          }
        }
      });
    }
  }
}

let descricaoIdeal = `<h3>Situação do banheiro: <div class="situacao ideal"></div></h3>`
let descricaoAtencao = `<h3>Situação do banheiro: <div class="situacao"></div></h3>`
let descricaoCritico = `<h3>Situação do banheiro: <div class="situacao critico"></div></h3>`

function abrir(idConjunto) {
  let conjunto = document.getElementById(`divConjunto${idConjunto}`)
  let descricao = document.getElementById(`divDescricaoKpi${idConjunto}`)
  let botao = document.getElementById(`divBotaoExpandir${idConjunto}`)

  if (!conjunto.classList.contains("detalhado")) {
    botao.innerHTML = `Ocultar`
    descricao.innerHTML = `<h2>Nível de abastecimento dos dispensadores</h2>`
    conjunto.classList.add("detalhado");
  } else {
    botao.innerHTML = `Mais Detalhes`
    descricao.innerHTML = descricaoCritico
    conjunto.classList.remove("detalhado");
  }
}