// importa os bibliotecas necessários
const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');

// constantes para configurações
const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;

// habilita ou desabilita a inserção de dados no banco de dados
const HABILITAR_OPERACAO_INSERIR = true;

// função para comunicação serial
const serial = async (
    valoresDispenser1,
    valoresDispenser2,
    valoresDispenser3,
    dtRegistros
) => {

    // conexão com o banco de dados MySQL
    let poolBancoDados = mysql.createPool(
        {
            host: 'localhost',
            user: 'aluno',
            password: 'Sptech#2024',
            database: 'luzion',
            port: 3307
        }
    ).promise();

    // lista as portas seriais disponíveis e procura pelo Arduino
    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }

    // configura a porta serial com o baud rate especificado
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );

    // evento quando a porta serial é aberta
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });

    // processa os dados recebidos do Arduino
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        console.log(data);
        const valores = data.split(':');
        const valorDistancia = parseFloat(valores[1]);

        //Registra a data e hora de processamento dos dados
        const dtAtual = new Date(Date.now())

        let stData = `${dtAtual.getFullYear()}-${dtAtual.getMonth()}-${dtAtual.getDay()} ${dtAtual.getHours()}:${dtAtual.getMinutes()}:${dtAtual.getSeconds()}` // YYYY-MM-DD HH:MM:SS

        dtRegistros.push(stData);

        // armazena os valores dos sensores nos arrays correspondentes
        valoresDispenser1.push(valorDistancia);
        valoresDispenser2.push(valorDistancia+5);
        valoresDispenser3.push(valorDistancia+7);

        // insere os dados no banco de dados (se habilitado)
        if (HABILITAR_OPERACAO_INSERIR) {
          
            console.log("valores inseridos no banco Dispenser 1: ", valorDistancia, "Data atual ", stData);
            console.log("valores inseridos no banco Dispenser 2: ", valorDistancia+5, "Data atual ", stData);
            console.log("valores inseridos no banco Dispenser 3: ", valorDistancia+7, "Data atual ", stData);
            
            // este insert irá inserir os dados na tabela "Registro"
            await poolBancoDados.execute(
              `INSERT INTO Registro (valor, dtRegistro, fkDispenser) VALUES (?, ?, 41);`,
              [valorDistancia, stData]
            );

            await poolBancoDados.execute(
              `INSERT INTO Registro (valor, dtRegistro, fkDispenser) VALUES (?, ?, 43);`,
              [valorDistancia, stData]
            );
            
            await poolBancoDados.execute(
              `INSERT INTO Registro (valor, dtRegistro, fkDispenser) VALUES (?, ?, 42);`,
              [valorDistancia, stData]
            );

        }

    });

    // evento para lidar com erros na comunicação serial
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

// função para criar e configurar o servidor web
const servidor = (
    valoresDispenser1,
    valoresDispenser2,
    valoresDispenser3
) => {
    const app = express();

    // configurações de requisição e resposta
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    // inicia o servidor na porta especificada
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    // define os endpoints da API para cada tipo de sensor
    app.get('/sensores/dispenser1', (_, response) => {
        return response.json(valoresDispenser1);
    });
    app.get('/sensores/dispenser2', (_, response) => {
        return response.json(valoresDispenser2);
    });
    app.get('/sensores/dispenser3', (_, response) => {
        return response.json(valoresDispenser3);
    });
}

// função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
    // arrays para armazenar os valores dos sensores
    const valoresDispenser1 = [];
    const valoresDispenser2 = [];
    const valoresDispenser3 = [];
    const dtRegistros = [];

    // inicia a comunicação serial
    await serial(
        valoresDispenser1,
        valoresDispenser2,
        valoresDispenser3,
        dtRegistros
    );

    // inicia o servidor web
    servidor(
        valoresDispenser1,
        valoresDispenser2,
        valoresDispenser3,
        dtRegistros
    );
})();