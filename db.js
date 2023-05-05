var mysql = require('mysql2');

module.exports = function queryDatabase(query) {

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