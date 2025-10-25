



























// Para Sprint 3

let setores = ['Administrativo', 'Comercial', 'RH', 'Operacional', 'Financeiro']
let campoSetores = document.getElementById('divKpisGrafico');

let conteudoPagina = ``

for (let i = 0; i < setores.length - 1; i++) {
  conteudoPagina +=
    `
    <div class="divisaSetor">
      <div class="linhaDivisa"></div>
      <h1>${setores[i]}</h1>
    </div>
    `

  campoSetores.innerHTML = conteudoPagina
}

const ctx = document.getElementById('estoqueJumbo');

new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'],
    datasets: [{
      label: 'Porcentagem de estoque',
      data: [94, 94, 94, 94, 94, 94, 92, 88, 84, 80, 72, 68, 50, 37, 25, 11, 8, 99, 95, 80, 74, 74, 65, 50],
      backgroundColor: 'rgba(127, 92, 146, 100)'
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      x: {
        title: {
          display: true,
          text: 'Horário',
          font: {
            size: 14,
            weight: 'bold'
          }
        }
      },
      y: {
        title: {
          display: true,
          text: 'Nível do estoque(%)',
          font: {
            size: 14,
            weight: 'bold'
          }
        },
        beginAtZero: true
      }
    }
  }
});