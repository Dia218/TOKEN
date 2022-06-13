const mysql = require("mysql");
const db_config = {
    host: "tutorial-db-instance.cdxlvvw9k0vr.ap-northeast-2.rds.amazonaws.com",
    user: "admin",
    password: "qkdGcr5%",
    database: "user_db"
};

module.exports = () => {
    return {
        init() {
            mysql.createConnection(db_config);
        },
        selectQry(con) { 
            con.connect(function () {
                con.query("SELECT * FROM user", function (err, result) {
                    if (err) {
                        console.log(err);
                    } else {
                        return result;
                    }
                });
            });
        },
    };
};