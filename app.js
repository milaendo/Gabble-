const express = require('express')
const app = express()
const path = require('path')
const mustacheExpress = require('mustache-express');
const bodyParser = require('body-parser')
const config = require('config')
const mysql = require('mysql')
const session = require('express-session')

app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())
app.engine('mustache', mustacheExpress())
app.set('views', './views')
app.set('view engine', 'mustache')
app.use(express.static(path.join(__dirname, 'static')))
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true
}))

const conn = mysql.createConnection({
  host: config.get('db.host'),
  database: config.get('db.database'),
  user: config.get('db.user'),
  password: config.get('db.password')
})

app.post("/register",function(req, res, next){
	const displayName = req.body.displayName
	const username = req.body.username
	const password = req.body.password
	const sql = `
		INSERT into users (user_name,display_name,password)
		VALUES (?,?,?)
	`
	conn.query(sql,[username, displayName, password],function(err, results, fields){
		if (!err){
			res.redirect('/')
		}
		else {
			console.log(err)
			res.send("ooooops")
		}
	})
})

app.post("/login", function(req, res, next){
	const username = req.body.username
	const password = req.body.password
	const sql = `SELECT user_name, password, idusers FROM users where user_name = ? and password = ?`

	conn.query(sql,[username,password], function(err,results,fields){
		if (!err && results[0]){
			req.session.username = results[0].user_name
			req.session.idusers = results[0].idusers
			res.redirect('./social')
		}
		else {

			res.send("error")
		}
	})
})
app.get("/", function(req, res, next){
  res.render("index")
})
app.post("/social", function(req,res,next){
	const gab = req.body.gab
	const userid = req.session.idusers 
	const sql = `INSERT into gabs (gab, userid) VALUES (?,?)`

	conn.query(sql,[gab,userid],function(err,results,fields){
		if(!err){
			res.render("./home")
		}
		else {
			res.send("error")
		}
	})
})
app.get("/social", function(req,res,next){
	res.render("social")
})
app.get("/home",function(req,res,next){
	const sql = `SELECT gab,user_name from gabs join users on gabs.userid = users.idusers`

	conn.query(sql,function(err, results, fields){
		let stuff = {gabs:results}
		console.log(stuff)
		res.render("home",stuff)
	})
})

app.listen(3000, function(){
  console.log("App running on port 3000")
})
