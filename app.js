const express = require('express')
const fs = require('fs/promises')
const url = require('url')
const post = require('./post.js')

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

// Set URL rout for POST queries
app.post('/dades', getDades)
async function getDades (req, res) {
  let receivedPOST = await post.getPostObject(req)
  let result = { status: "KO", result: "Unkown type" }

  var textFile = await fs.readFile("./public/consoles/consoles-list.json", { encoding: 'utf8'})
  var objConsolesList = JSON.parse(textFile)

  if (receivedPOST) {
    if (receivedPOST.type == "consola") {
      var objFilteredList = objConsolesList.filter((obj) => { return obj.name == receivedPOST.name })
      await wait(1500)
      if (objFilteredList.length > 0) {
        result = { status: "OK", result: objFilteredList[0] }
      }
    }
    if (receivedPOST.type == "marques") {
      var objBrandsList = objConsolesList.map((obj) => { return obj.brand })
      await wait(1500)
      let senseDuplicats = [...new Set(objBrandsList)]
      result = { status: "OK", result: senseDuplicats.sort() } 
    }
    if (receivedPOST.type == "marca") {
      var objBrandConsolesList = objConsolesList.filter ((obj) => { return obj.brand == receivedPOST.name })
      await wait(1500)
      // Ordena les consoles per nom de model
      objBrandConsolesList.sort((a,b) => { 
          var textA = a.name.toUpperCase();
          var textB = b.name.toUpperCase();
          return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
      })
      result = { status: "OK", result: objBrandConsolesList } 
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
      password: process.env.MYSQLPASSWORD || "",
      database: process.env.MYSQLDATABASE || "test"
    });

    connection.query(query, (error, results) => { 
      if (error) reject(error);
      resolve(results)
    });
     
    connection.end();
  })
}