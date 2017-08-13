const express = require('express')
const app = express()
const path = require('path')
const mustacheExpress = require('mustache-express');
const bodyParser = require('body-parser')
const config = require('config')
const mysql = require('mysql')

app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())
app.engine('mustache', mustacheExpress())
app.set('views', './views')
app.set('view engine', 'mustache')
app.use(express.static(path.join(__dirname, 'static')))

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

app.post("/login:id", function(req, res, next){
	const username = req.body.username
	const password = req.body.password
	const id = req.body.id 
	const sql = `SELECT user_name, password FROM users where id = idusers`

	conn.query(sql, function(err,results,fields){
		if (!err){
			res.redirect('/')
		}
		else {
			res.send('welcome back')
		}
	})
})
app.get("/", function(req, res, next){
  res.render("index")
})


// app.post('/social', function(req, res, next){
// 	const message = req.body.blob
// 	const sql = ` INSERT into gabs (`
// })
// app.get("/social", function(req, res, next){
// 	res.render("social")
// })
app.listen(3000, function(){
  console.log("App running on port 3000")
})
