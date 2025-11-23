let setores = ['Administrativo', 'Contábil', 'RH', 'Operacional', 'Financeiro']
let topo = document.getElementById('divTopo');

let conteudoPagina = ``

let banheirosAdmin = ['Administracao', 'Ala Oeste', 'Ala Leste', 'Ala Sul']
let banheirosConta = ['Contabil', 'Ala Fiscal', 'Ala Patrimonial']
let banheirosRH = ['RH', 'Ala Convivência', 'Ala Treinamento', 'Ala Benefícios']
let banheirosOpe = ['Operacoes', 'Ala Oeste', 'Ala Leste', 'Ala Sul', 'Ala Norte']
let banheirosFinan = ['Financeiro', 'Ala Cofre']

let banheirosSetor = [banheirosAdmin, banheirosConta, banheirosRH, banheirosOpe, banheirosFinan]

let dados1 = [14, 37, 40, 10, 37]
let dados2 = [23, 14, 27, 10]
let dados3 = [93, 89, 30, 37]
let dados4 = [64, 77, 60, 80, 97]
let dados5 = [83, 74, 87, 90]
let dados6 = [93, 89, 30, 37]
let dados7 = [54, 67, 70, 30, 67]
let dados8 = [23, 34, 27, 60]
let dados9 = [23, 89, 30, 37]
let dados10 = [74, 37, 80, 10, 67]
let dados11 = [93, 74, 67, 80]
let dados12 = [73, 89, 30, 37]
let dados13 = [94, 87, 90, 80, 77]

let dadosAdmin = [dados1, dados2, dados3]
let dadosConta = [dados4, dados5]
let dadosRH = [dados6, dados7, dados8]
let dadosOpe = [dados9, dados10, dados11, dados12]
let dadosFinan = [dados13]

let dados = [dadosAdmin, dadosConta, dadosRH, dadosOpe, dadosFinan]

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

for (let i = 1; i < setores.length - 1; i++) {
  if (i == 1) {
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
        ${banheirosSetor[0][i]}
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
        ${banheirosSetor[0][i]}
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

for (let i = 0; i < setores.length; i++) {
  conteudoPagina +=
    `
    <div class="divisaSetor">
      <div class="linhaDivisa"></div>
      <h1>${setores[i]}</h1>
    </div>
    `

  for (let j = 1; j < banheirosSetor[i].length; j++) {
    if (j == 1) {
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
                  <div class="situacao critico"></div> Crítico: <div id="divDispensadoresCritico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i][0]}`}">2</div>
                </h4>
                <h4>
                  <div class="situacao"></div> Atenção: <div id="divDispensadoresAtencao${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i][0]}`}">3</div>
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
              <canvas id="grafico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i][0]}`}"></canvas>
            </div>

            <div class="botaoExpandir"><div id="divBotaoExpandir${contador}" class="conteudoBotao" onclick="abrir${contador}()"><h4>Ocultar</h4></div> </div>
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
                  <div class="situacao critico"></div> Crítico: <div id="divDispensadoresCritico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i][0]}`}">2</div>
                </h4>
                <h4>
                  <div class="situacao"></div> Atenção: <div id="divDispensadoresCritico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i][0]}`}">2</div>
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
            <div class="campoGrafico"> <canvas id="grafico${banheirosSetor[i][j].replaceAll(' ', '') + `${banheirosSetor[i][0]}`}"></canvas> </div>
            <div class="botaoExpandir"><div id="divBotaoExpandir${contador}" class="conteudoBotao" onclick="abrir${contador}()"><h4>Mais Detalhes</h4></div> </div>
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

  for (let j = 1; j < banheiros.length; j++) {
    const nomeBanheiro = banheiros[j];
    const dadosBanheiro = dadosSetor[j - 1];

    let cabines = [];
    for (let k = 0; k < dadosBanheiro.length; k++) {
      cabines.push(`Cabine ${k + 1}`);
    }

    const ctxBanheiro = document.getElementById(`grafico${nomeBanheiro.replaceAll(' ', '')}${banheiros[0]}`);

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