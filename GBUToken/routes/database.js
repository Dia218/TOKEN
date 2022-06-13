const mysql = require("mysql");
const mysqlConnection = {
    init: function () { 
        return mysql.createConnection({
            host: process.env.host,
            user: process.env.user,
            password: process.env.password,
            database: process.env.database
        });
    },
    db_open: function (con) { 
        con.connect(function (err) {
            if (err) {
                console.log("mysql err : +err" + err);
            }
            else {
                console.log("mysql is connected user_db")
            }
        });
    },
    close: function(con) {      // #4
        con.end(err => {
            if (err) {
                console.log("MySQL 종료 실패 : ", err);
            } else {
                console.log("MySQL Terminated...");
            }
        });
    }
}
module.exports = mysqlConnection;