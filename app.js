const express = require('express')
const post = require('./post.js')
const queryDatabase = require('./db.js')

const webSockets = require('./appWS.js')

var websocket = new webSockets();

// Start HTTP server
const app = express()

// Set port number
const port = process.env.PORT || 3000



// Publish static files from 'public' folder
app.use(express.static('public'))

// Activate HTTP server
const httpServer = app.listen(port, appListen)
function appListen() {
  console.log(`Listening for HTTP queries on: http://localhost:${port}`)
}

websocket.init(httpServer) // Start websockets

// Close connections when process is killed
process.on('SIGTERM', shutDown);
process.on('SIGINT', shutDown);

function shutDown() {
  console.log('Received kill signal, shutting down gracefully');
  websocket.end()
  process.exit(0);
}

// set_record endpoint
app.post('/set_record', set_record)
async function set_record(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  let ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress
  console.log("set_record: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {
    var nom_jugador = receivedPOST.nom_jugador;
    var cicle = receivedPOST.cicle;
    var items_correctes = receivedPOST.items_correctes;
    var items_incorrectes = receivedPOST.items_incorrectes;
    var temps_emprat = receivedPOST.temps_emprat;
    var dispositiu = receivedPOST.dispositiu;

    var puntuacio = (items_correctes / items_incorrectes) * ((items_correctes + items_incorrectes)/temps_emprat) * 1000;
    
    if (puntuacio < 0) {
      puntuacio = 0;
    }

    await queryDatabase(`insert into ranking(nom_jugador, cicle, puntuacio, temps_emprat,  items_correctes, items_incorrectes, ocult, ip_origen, dispositiu) values ` +
      `("${nom_jugador}","${cicle}",${puntuacio},${temps_emprat},${items_correctes},${items_incorrectes}, 0, '${ip}', '${dispositiu}')`);

    result = {
      status: "OK",
      result: "Record afegit"
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// get_ranking endpoint
app.post('/get_ranking', get_ranking)
async function get_ranking(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  console.log("get_ranking: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {
    var element_inici = receivedPOST.element_inici;
    var nombre_elements = receivedPOST.nombre_elements;

    if (nombre_elements > 20) {
      nombre_elements = 20;
    }

    var ranking = await queryDatabase(`select * from ranking order by puntuacio desc limit ${element_inici - 1},${nombre_elements};`)

    result = {
      status: "OK",
      result: ranking
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// get_ranking_all endpoint
app.post('/get_ranking_all', get_ranking_all)
async function get_ranking_all(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  console.log("get_ranking_all: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {
    

    var ranking = await queryDatabase(`select * from ranking order by puntuacio desc;`)

    result = {
      status: "OK",
      result: ranking
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// get_ranking endpoint
app.post('/get_families', get_families)
async function get_families(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  console.log("get_families: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {

    var families_profesionals = await queryDatabase(`select * from families_profesionals`)

    result = {
      status: "OK",
      result: families_profesionals
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// get_ranking endpoint
app.post('/get_cicles', get_cicles)
async function get_cicles(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  console.log("get_cicles: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {
    var familiaNom = receivedPOST.familiaNom;
    console.log(familiaNom)
    var familiaId = await queryDatabase(`select id from families_profesionals where nom = '${familiaNom}';`)
    var cicles = await queryDatabase(`select * from cicles where familia_profesional = ${familiaId[0].id};`)

    result = {
      status: "OK",
      result: cicles
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// get_ranking endpoint
app.post('/get_totems', get_totems)
async function get_totems(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  console.log("get_totems: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {
    var cicleNom = receivedPOST.cicleNom;
    
    var cicleID = await queryDatabase(`select id from cicles where nom = "${cicleNom}";`)
    var totemsBuenos = await queryDatabase(`select * from ocupacions where cicle = ${cicleID[0].id};`)
    var cicleMalo = await queryDatabase(`select nom,id from cicles where nom != "${cicleNom}"`)
    var totemsMalos = await queryDatabase(`select * from ocupacions where cicle = ${cicleMalo[0].id};`)


    var JSonTotems = {
      totemsGenerados: {
        buenos: {cicleNom: cicleNom,
          totems: totemsBuenos},
        malos: {cicleNom: cicleMalo[0].nom,
                totems: totemsMalos}
      }
    }

    result = {
      status: "OK",
      result: JSonTotems
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

app.post("/ocultar_jugador",ocultar_jugador)
async function ocultar_jugador(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }
  console.log("ocultar_jugador: "+JSON.stringify(receivedPOST))

  if (receivedPOST) {
    var ip = receivedPOST.ip.split('/')[1]

    await queryDatabase(`update ranking set ocult = true where ip_origen = '${ip}';`)

    result = {
      status: "OK",
      result: "Jugador ocultat correctament"
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}



