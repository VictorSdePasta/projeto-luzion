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
    valoresDistancia,
    dtRegistros
) => {

    // conexão com o banco de dados MySQL
    let poolBancoDados = mysql.createPool(
        {
            host: '127.0.0.1',
            user: 'datacquino',
            password: 'Senha123456789!',
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
        const valores = data.split(';');
        const valorDistancia = parseFloat(valores[0]);

        //Registra a data e hora de processamento dos dados
        const dtAtual = new Date()

        let stData = `${dtAtual.getFullYear()}-${dtAtual.getMonth()}-${dtAtual.getDay()} ${dtAtual.getHours()}:${dtAtual.getMinutes()}:${dtAtual.getSeconds()}` // YYYY-MM-DD HH:MM:SS

        dtRegistros.push(stData);

        // armazena os valores dos sensores nos arrays correspondentes
        valoresDistancia.push(valorDistancia);

        // insere os dados no banco de dados (se habilitado)
        if (HABILITAR_OPERACAO_INSERIR) {
          
            console.log("valores inseridos no banco: ", valorDistancia, "Data atual ", stData);
            
            // este insert irá inserir os dados na tabela "Registro"
            await poolBancoDados.execute(
              `INSERT INTO Registro (valor, dtRegistro, fkDispenser) VALUES (?, ?, 1);`,
              [valorDistancia, stData]
            );

            await poolBancoDados.execute(
              `INSERT INTO Registro (valor, dtRegistro, fkDispenser) VALUES (?, ?, 2);`,
              [valorDistancia, stData]
            );
            
            await poolBancoDados.execute(
              `INSERT INTO Registro (valor, dtRegistro, fkDispenser) VALUES (?, ?, 3);`,
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
    valoresDistancia,
    dtRegistros
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
    app.get('/sensores/distancia', (_, response) => {
        return response.json(valoresDistancia);
    });
    
    app.get('/sensores/dataHora', (_, response) => {
        return response.json(dtRegistros);
    });
}

// função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
    // arrays para armazenar os valores dos sensores
    const valoresDistancia = [];
    const dtRegistros = [];

    // inicia a comunicação serial
    await serial(
        valoresDistancia,
        dtRegistros
    );

    // inicia o servidor web
    servidor(
        valoresDistancia,
        dtRegistros
    );
})();