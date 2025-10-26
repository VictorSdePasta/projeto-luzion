# Projeto Luzion

O Projeto Luzion apresenta uma solução tecnológica voltada para otimizar a gestão operacional na reposição de dispensadores de papel higiênico, substituindo processos manuais por um sistema inteligente de monitoramento IoT. 

---

## Contexto

A falta de papel higiênico em banheiros públicos e corporativos é um problema recorrente no Brasil, gerando prejuízos à saúde, imagem e conformidade legal das empresas.  
Casos registrados em escolas e hospitais comprovam a gravidade do problema, que pode resultar em multas, processos e até interdições.  

Nossos clientes vão desde Facilities que cuidam da gestão da limpeza de grandes empresas até Shoppings, Prédios comerciais e etc.
A Luzion surge como aliada estratégica das empresas que buscam eficiência operacional, sustentabilidade e fidelização de clientes por meio da inovação tecnológica.

---

## Visão Geral

A Luzion propõe uma solução IoT inovadora para o monitoramento do nível de papel higiênico em dispensadores, integrando sensores ultrassônicos conectados a Arduinos e uma plataforma web centralizada.  
Esses sensores calculam a distância do rolo restante, enviando dados periodicamente para um banco de dados em nuvem, onde são processados e exibidos em dashboards interativas.

O sistema utiliza um esquema de cores simples e intuitivo:

- 🟥 Vermelho – Estado crítico - Dispenser: Abaixo de 15% da carga total. Banheiro, Setor: Abaixo de 25% do Índice de Abastecimento.     
- 🟨 Amarelo – Estado de alerta - Dispenser: Entre 15% e 40% da carga total . Banheiro, Setor: Entre 25% e 75% do Índice de Abastecimento. 
- 🟩 Verde – Estado ideal - Dispenser: Acima de 40% da carga total. Banheiro, Setor: Acima de 75% do Índice de Abastecimento.


Através dessas informações em tempo real, as empresas podem planejar rotinas de reposição de forma precisa, reduzindo desperdícios, custos operacionais e tempo de deslocamento das equipes, além de digitalizar o processo.

---

## Objetivo

- Automatizar o processo de verificação e reposição do papel higiênico.  
- Fornecer dados em tempo real sobre o status de cada dispenser, banheiro, setor e do estoque.  
- Reduzir custos operacionais por meio da eficiência e precisão dos dados.  
- Disponibilizar uma plataforma digital intuitiva com gráficos, dashboards e insights.  
- Apoiar a tomada de decisões com base em indicadores e gestão inteligente de recursos.

---

## Escopo Técnico

- Hardware: Sensor ultrassônico HC-SR04 conectado a uma placa Arduino UNO R3.  
- Hospedagem: Máquina Virtual na nuvem.  
- Software:  
  - Front-end: HTML, CSS   
  - Back-end: API Dat-Acqu-Ino, JavaScript
  - Banco de Dados: MySql  
- Visualização: Dashboard em uma plataforma digital com dados atualizados a cada 5 minutos.  

---

## Sobre a Luzion

A Luzion é uma empresa voltada ao desenvolvimento de soluções inteligentes de monitoramento e automação, com foco em melhorar a eficiência de empresas através da integração entre hardware, software e análise de dados.  
Nosso propósito é unir tecnologia e sustentabilidade para transformar a maneira como as empresas gerenciam seus recursos e operações.


---
## Integrantes: 
Ana Jardim, Daner Quispe, Reginaldo Lima, Igor Reis, Victor Mello e Victor Lima.

---

## Documentação do projeto:


Documentação: https://docs.google.com/document/d/1bladBED_UqTeWllQynp1sSn9G_c6XxWk4DunsgbFV8g/edit?tab=t.1w9w8vpxo39k

