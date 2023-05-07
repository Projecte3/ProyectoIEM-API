var mysql = require('mysql2');

module.exports = function queryDatabase(query) {

  return new Promise((resolve, reject) => {
    var connection = mysql.createConnection({
      host: "containers-us-west-28.railway.app" || "localhost",
      port: 7019 || 3306,
      user: "root" || "root",
      password: "nDvmEAmKCuWGycKGefhI" || "root",
      database: "railway" || "proyectoiem"
    });

    connection.query(query, (error, results) => {
      if (error) reject(error);
      resolve(results)
    });

    connection.end();
  })
}