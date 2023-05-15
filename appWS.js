// Description: WebSocket server for the app

const WebSocket = require('ws')
const { v4: uuidv4 } = require('uuid')
const queryDatabase = require('./db.js')

class Obj {



    init(httpServer) {

        this.mapSizeX = 3008;
        this.mapSizeY = 2624;

        // Run WebSocket server
        this.websocketServer = new WebSocket.Server({ server: httpServer })
        this.socketsClients = new Map() //Map de clientes conectados. 
        console.log(`Listening for WebSocket queries`)

        this.llistaJugadors = new Map() // Map de los jugadores con sus ciclos
        this.llistaTotems = new Map() // Map de los totems

        /* Cuando se conecta un cliente, se activa el evento connection, recibe un objeto ws en una funcion anónima 
        y esta función llama a la función newConnection*/
        this.websocketServer.on('connection', (ws, req) => { this.newConnection(ws, req) })
    }

    end() {
        this.websocketServer.close()
    }

    // A websocket client connects
    newConnection(ws, req) {

        console.log("Client connected")

        // Add client to the clients list
        const id = uuidv4()
        const color = Math.floor(Math.random() * 360)

        let ip_usuario = req.headers['x-forwarded-for'] || req.socket.remoteAddress

        const metadata = { id, color, ip_usuario }
        this.socketsClients.set(ws, metadata) //Almacena la conexción del cliente y la data. 


        // Send clients list to everyone
        this.sendClients()



        saveConnection(ip_usuario, 'Connexió')

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

        try {
            messageAsObject = JSON.parse(messageAsString)
            //console.log(messageAsString);
        }
        
        catch (e) { console.log("Could not parse bufferedMessage from WS message") }

        switch (messageAsObject.type) {
            case "test": // Test de conexión
                var JSonToSendClient = { type: "test", message: messageAsObject.message }
                ws.send(JSON.stringify(JSonToSendClient))
                break;

            case "info_usuari": // Este mensaje se recibe cada vez que se conecta un usuario (en el cliente se envia directamente)
                var JSonInfo = messageAsObject.message

                // TODO: Cambiar las coordenadas por el centro del mapa
                this.llistaJugadors.set(JSonInfo.nom_jugador, [640, 320]) // Se añade al mapa el jugador como clave y un array con las coordenadas x,y 

                await this.generateTotems(JSonInfo.cicle)

                this.broadcastTotems();
                break;

            case "desconectar":
                var message = messageAsObject.message
                var nom_jugador = message.nom_jugador;



                this.llistaJugadors.delete(nom_jugador)

                if (this.llistaJugadors.size === 0) {
                    this.llistaTotems.clear();
                }

                var ip_usuario = ws._socket.remoteAddress;

                this.websocketServer.clients.forEach((client) => {
                    if (this.socketsClients.get(client).id == id) {
                        ip_usuario = this.socketsClients.get(client).ip_usuario
                    }
                })

                saveConnection(ip_usuario, 'Desconnexió')

                ws.close();

                break;

            case "remove_totem":
                var messageJSON = messageAsObject.message
                var totem = messageJSON.totem;

                this.llistaTotems.forEach(function (valor, clave) {
                    valor.forEach(function (valor2, clave2) {
                        if (clave2 === totem) {
                            valor.delete(clave2);
                        }
                    })
                })

                var totem_borrado = {
                    type: "totem_borrado",
                    totem: totem
                }

                this.broadcast(totem_borrado)

                break;

            case "llistar_totems":

                this.broadcastTotems();
                break;

            case "pos_jugador":
                var jugadorJSON = messageAsObject.message
                var jugador = jugadorJSON.jugador;
                var posX = jugadorJSON.pos_x;
                var posY = jugadorJSON.pos_y;

                
                this.llistaJugadors.set(jugador,[posX, posY])
                
                var jsonObject = {};
                for (let [key, value] of this.llistaJugadors) {
                    jsonObject[key] = value;
                  }

                var playerPositionsJSON = {
                    type: "player_positions",
                    message: jsonObject
                }

                ws.send(JSON.stringify(playerPositionsJSON))
                break;

                

        }
    }

    async broadcastTotems(){
        var mapaTemp = new Map();

        this.llistaTotems.forEach(function (valor, clave) {
            mapaTemp.set(clave, Object.fromEntries(valor.entries()))
        })



        var llistaTotemObj = Object.fromEntries(mapaTemp.entries());


        var TotemsJSON = {
            type: "llistaTotems",
            totemsServer: llistaTotemObj
        }


        this.broadcast(TotemsJSON)
    }

    async generateTotems(cicle) {

        var cicleID = await queryDatabase(`select id from cicles where nom = "${cicle}";`)
        var totemsBuenos = await queryDatabase(`select nom from ocupacions where cicle = ${cicleID[0].id};`)
        var cicleMalo = await queryDatabase(`select nom,id from cicles where nom != "${cicle}" order by rand();`)
        var totemsMalos = await queryDatabase(`select nom from ocupacions where cicle = ${cicleMalo[0].id};`)

        while (this.llistaTotems.has(cicleMalo[0].nom)) {
            cicleMalo = await queryDatabase(`select nom,id from cicles where nom != "${cicle}" order by rand();`)
        }

        var totemsBuenosMap = new Map();
        var totemsMalosMap = new Map();

        var cnt = 0;
        var x = 0;
        var y = 0;

        totemsBuenos.forEach(element => {
            if (cnt < 5) {
                x = getRandomIntInclusive(0, this.mapSizeX);
                y = getRandomIntInclusive(0, this.mapSizeY);
                totemsBuenosMap.set(element.nom, [x,y])
                cnt++;
            }
        });

        cnt = 0;

        totemsMalos.forEach(element => {
            if (cnt < 5) {
                x = getRandomIntInclusive(0, this.mapSizeX);
                y = getRandomIntInclusive(0, this.mapSizeY);
                totemsMalosMap.set(element.nom, [x,y])
                cnt++;
            }
        });



        return new Promise((resolve) => {
            this.llistaTotems.set(cicle, totemsBuenosMap);
            this.llistaTotems.set(cicleMalo[0].nom, totemsMalosMap);
            resolve(this.llistaTotems);
        });

    }
}

async function saveConnection(ip_usuario, tipus_connexio) {
    //var ip_usuarioTrim = ip_usuario.split(':')[3];
    await queryDatabase(`INSERT INTO connexions (ip_origen, hora_conexion, tipus_connexio) VALUES ('${ip_usuario}', now(), '${tipus_connexio}');`);
}

function getRandomIntInclusive(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}



module.exports = Obj

