// Description: WebSocket server for the app

const WebSocket = require('ws')
const { v4: uuidv4 } = require('uuid')
const queryDatabase = require('./db.js')

class Obj {



    init(httpServer) {
        // Run WebSocket server
        this.websocketServer = new WebSocket.Server({ server: httpServer })
        this.socketsClients = new Map() //Map de clientes conectados. 
        console.log(`Listening for WebSocket queries`)

        this.llistaJugadors = [] // Array de los jugadores con sus ciclos
        this.llistaTotems = new Map() // Map de los totems

        /* Cuando se conecta un cliente, se activa el evento connection, recibe un objeto ws en una funcion anónima 
        y esta función llama a la función newConnection*/
        this.websocketServer.on('connection', (ws) => { this.newConnection(ws) })
    }

    end() {
        this.websocketServer.close()
    }

    // A websocket client connects
    newConnection(ws) {

        console.log("Client connected")

        // Add client to the clients list
        const id = uuidv4()
        const color = Math.floor(Math.random() * 360)
        const metadata = { id, color }
        this.socketsClients.set(ws, metadata) //Almacena la conexción del cliente y la data. 


        // Send clients list to everyone
        this.sendClients()

        let ip_usuario = ws._socket.remoteAddress;

        saveConnection(ip_usuario)

        //Cuando el cliente se desconecta, activa el evento close, y borra al cliente del map. 
        ws.on("close", () => { this.socketsClients.delete(ws) })

        //Cuando recibe un mensaje de un cliente, activa el evento message y ejecuta el método newMessage pasando el mensaje. 
        ws.on('message', (bufferedMessage) => { this.newMessage(ws, id, bufferedMessage) })
    }


    // Send clientsIds to everyone connected with websockets
    sendClients() {
        var clients = []
        this.socketsClients.forEach((value) => {
            clients.push(value.id)
        })
        /*
        this.websocketServer.clients.forEach((client) => {
            if (client.readyState === WebSocket.OPEN) {
                var id = this.socketsClients.get(client).id
                var messageAsString = JSON.stringify({ type: "clientes conectados", id: id, list: clients, size: clients.length })
                client.send(messageAsString)
            }
        })
        */

    }

    // Send a message to all websocket clients
    broadcast(obj) {
        this.websocketServer.clients.forEach((client) => {
            if (client.readyState === WebSocket.OPEN) {
                var messageAsString = JSON.stringify(obj)
                client.send(messageAsString)
            }
        })
    }

    // Send a private message to a specific websocket client
    private(obj) {
        this.websocketServer.clients.forEach((client) => {
            if (this.socketsClients.get(client).id == obj.destination && client.readyState === WebSocket.OPEN) {
                var messageAsString = JSON.stringify(obj)
                client.send(messageAsString)
                return
            }
        })
    }


    // A message is received from a websocket client, le pasa conexción del cliente, la id y el mensaje
    async newMessage(ws, id, bufferedMessage) {
        var messageAsString = bufferedMessage.toString()
        var messageAsObject = {}

        try { messageAsObject = JSON.parse(messageAsString) }
        catch (e) { console.log("Could not parse bufferedMessage from WS message") }

        switch (messageAsObject.type) {
            case "test": // Test de conexión
                var JSonToSendClient = { type: "test", message: messageAsObject.message }
                ws.send(JSON.stringify(JSonToSendClient))
                break;
            
            case "info_usuari": // Este mensaje se recibe cada vez que se conecta un usuario (en el cliente se envia directamente)
                var JSonInfo = messageAsObject.message
                this.llistaJugadors.push(JSonInfo.nom_jugador)
                /*
                this.llistaJugadors.forEach(function(valor, clave) {
                    console.log(clave, valor);})
                */

                await this.generateTotems(JSonInfo.cicle)

                /*
                this.llistaTotems.forEach(function(valor, clave) {
                    console.log(clave,": ", valor);})
                */
               
                var llistaTotemObj = Object.fromEntries(this.llistaTotems.entries());


                var TotemsJSON = {
                    totemsServer: llistaTotemObj
                }


                this.broadcast(TotemsJSON)
                break;

            case "desconectar":
                var message = messageAsObject.message
                var nom_jugador = message.nom_jugador;



                this.llistaJugadors = this.llistaJugadors.filter(item => item !== nom_jugador)

                if (this.llistaJugadors.length === 0) {
                    this.llistaTotems.clear();
                }


                ws.close();

                break;
            
        }
    }

    async generateTotems(cicle){

        var cicleID = await queryDatabase(`select id from cicles where nom = "${cicle}";`)
        var totemsBuenos = await queryDatabase(`select nom from ocupacions where cicle = ${cicleID[0].id};`)
        var cicleMalo = await queryDatabase(`select nom,id from cicles where nom != "${cicle}" order by rand();`)
        var totemsMalos = await queryDatabase(`select nom from ocupacions where cicle = ${cicleMalo[0].id};`)

        while (this.llistaTotems.has(cicleMalo[0].nom)) {
            cicleMalo = await queryDatabase(`select nom,id from cicles where nom != "${cicle}" order by rand();`)
        }

        var totemsBuenosArray = [];
        var totemsMalosArray = [];

        var cnt = 0;

        totemsBuenos.forEach(element => {
            if (cnt < 5) {
                totemsBuenosArray.push(element.nom)
                cnt++;
            }
        });

        cnt = 0;

        totemsMalos.forEach(element => {
            if (cnt < 5) {
                totemsMalosArray.push(element.nom)
                cnt++;
            }
        });

        return new Promise((resolve, reject) => {
            this.llistaTotems.set(cicle,totemsBuenosArray);
            this.llistaTotems.set(cicleMalo[0].nom,totemsMalosArray);
            resolve(this.llistaTotems);
        });

    }
}

async function saveConnection(ip_usuario) {
    // Save the connection to the connections table in the database
    var ip_usuarioTrim = ip_usuario.split(':')[3];
    await queryDatabase(`INSERT INTO connexions (ip_origen, hora_conexion) VALUES ('${ip_usuarioTrim}', now());`);
  }


module.exports = Obj

