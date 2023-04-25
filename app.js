const express = require('express')
const fs = require('fs/promises')
const url = require('url')
const post = require('./post.js')
var mysql = require('mysql2');

// Wait 'ms' milliseconds
function wait (ms) {
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
function appListen () {
  console.log(`Listening for HTTP queries on: http://localhost:${port}`)
}

// set_record endpoint
app.post('/set_record',set_record)
async function set_record(req, res){
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }

  if (receivedPOST) {
    var nom_jugador = receivedPOST.nom_jugador;
    var cicle = receivedPOST.cicle;
    var items_correctes = receivedPOST.items_correctes;
    var items_incorrectes = receivedPOST.items_incorrectes;
    // TODO: Mirar de enviar el tiempo que ha tardado


    var puntuacio = 0; // TODO: Algoritmo puntuacion

    await queryDatabase(`insert into ranking(nom_jugador, cicle, puntuacio, temps_emprat,  items_correctes, items_incorrectes) values `+
    `("${nom_jugador}","${cicle}",${puntuacio},0,${items_correctes},${items_incorrectes})`);

    result = {
      status: "OK",
      result: "Record afegit"
    }
  }

  res.writeHead(200, { 'Content-Type': 'application/json' })
  res.end(JSON.stringify(result))
}

// get_ranking endpoint
app.post('/get_ranking',get_ranking)
async function get_ranking(req, res){
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

// Perform a query to the database
function queryDatabase (query) {

  return new Promise((resolve, reject) => {
    var connection = mysql.createConnection({
      host: process.env.MYSQLHOST || "localhost",
      port: process.env.MYSQLPORT || 3306,
      user: process.env.MYSQLUSER || "root",
      password: process.env.MYSQLPASSWORD || "root",
      database: process.env.MYSQLDATABASE || "proyectoiem"
    });

    connection.query(query, (error, results) => { 
      if (error) reject(error);
      resolve(results)
    });
     
    connection.end();
  })
}