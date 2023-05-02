const express = require('express')
const fs = require('fs/promises')
const url = require('url')
const post = require('./post.js')
var mysql = require('mysql2');

// Wait 'ms' milliseconds
function wait(ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

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

// set_record endpoint
app.post('/set_record', set_record)
async function set_record(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }

  if (receivedPOST) {
    var nom_jugador = receivedPOST.nom_jugador;
    var cicle = receivedPOST.cicle;
    var items_correctes = receivedPOST.items_correctes;
    var items_incorrectes = receivedPOST.items_incorrectes;
    // TODO: Mirar de enviar el tiempo que ha tardado
    var temps_emprat = 30;

    var puntuacio = ((items_correctes * 100) - (items_incorrectes * 50) / temps_emprat);
    
    if (puntuacio < 0) {
      puntuacio = 0;
    }

    await queryDatabase(`insert into ranking(nom_jugador, cicle, puntuacio, temps_emprat,  items_correctes, items_incorrectes) values ` +
      `("${nom_jugador}","${cicle}",${puntuacio},${temps_emprat},${items_correctes},${items_incorrectes})`);

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

// get_ranking endpoint
app.post('/get_families', get_families)
async function get_families(req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }

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

  if (receivedPOST) {
    var cicleNom = receivedPOST.cicleNom;
    
    var cicleID = await queryDatabase(`select id from cicles where nom = '${cicleNom}';`)
    var totems = await queryDatabase(`select * from ocupacions where cicle = ${cicleID[0].id};`)

    result = {
      status: "OK",
      result: totems
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// Perform a query to the database
function queryDatabase(query) {

  return new Promise((resolve, reject) => {
    var connection = mysql.createConnection({
      host: "containers-us-west-1.railway.app" || "localhost",
      port: 6258 || 3306,
      user: "root" || "root",
      password: "1IHDj6ijcbplAgvxYIIy" || "root",
      database: "railway" || "proyectoiem"
    });

    connection.query(query, (error, results) => {
      if (error) reject(error);
      resolve(results)
    });

    connection.end();
  })
}