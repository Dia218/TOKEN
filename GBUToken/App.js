const express = require("express");
const dotenv = require("dotenv").config();
const mysqlConobj = require('./routes/database');
const db = mysqlConobj.init();
var data_list;
mysqlConobj.db_open(db);
db.query("select * from user", function (err, result) {
    if (err) { 
        console.log(err);
    }
    else {
        console.log(result);
        data_list = result;
    }
});
var path = require('path');
const app = express();
app.use(express.static(path.join(__dirname, 'public')));
app.use('/js', express.static(path.join(__dirname,  'node_modules', 'bootstrap', 'dist', 'js')));
app.use('/css', express.static(path.join(__dirname, 'node_modules', 'bootstrap', 'dist', 'css')));
app.use('/vendor', express.static(path.join(__dirname, 'node_modules', 'bootstrap', 'dist', 'vendor')));

app.set('views', __dirname + '/views'); // view페이지의 폴더 기본경로로 _dirname + views 이름의 폴더를 사용
app.set('view engine', 'ejs'); // view엔진으로 ejs 사용

app.get("/", (req, res) => {
    console.log('ADMIN_PAGE');
    res.render("admin_page.ejs", { 'data': data_list }); 
});
app.get("/user", (req, res) => {
    console.log('USER_PAGE');
   res.render("user_page.ejs", { 'data': data_list });
});
app.use(function(req, res, next) {
    console.log(2)
    res.status(500).send('path error');
});
app.listen(3000, (err,req,res) => {
    if(!err)
        console.log('server is listening at localhost:3000');
});