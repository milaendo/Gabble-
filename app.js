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
		VALUES (?,?,?);
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
	const sql = `SELECT user_name, password, idusers FROM users where user_name = ? and password = ?;`

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
	const sql = `INSERT into gabs (gab, userid) VALUES (?,?);`

	conn.query(sql,[gab,userid],function(err,results,fields){
		if(!err){
			res.redirect("/home")
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
	const sql = `
SELECT 
   g.idgabs, g.timestamp, g.gab, u.user_name, count(l.idlikes) as likes
FROM
    gabs g
        JOIN
    users u ON g.userid = u.idusers
		LEFT OUTER JOIN
	likes l on g.idgabs = l.gabid
GROUP BY g.idgabs
ORDER BY g.timestamp DESC;`

	conn.query(sql,function(err, results, fields){
		let stuff = {gabs:results}
		res.render("home",stuff)
	})
})

app.get("/likes/:gabid",function(req,res,next){
	const sql1 = `
SELECT 
    g.gab, u.user_name, l.userid, g.timestamp
FROM
    likes l
        JOIN
    gabs g ON g.userid = l.userid
        JOIN
    users u ON l.userid = u.idusers
WHERE
    g.idgabs = ?;`

	const sql2 = `
SELECT 
    l.*, u.*
FROM
    likes l
        JOIN
    users u ON l.userid = u.idusers
WHERE
    l.gabid = ?;`
//first query gets gab info gab, gabid, time and user
//select * from likes join with users where gabid = gabid 
//second query gets all of the people who likes that gab
// select * from gabid join with users (gab info)
//build context obj for mustache and then render the likes page 

	conn.query(sql1,[req.params.gabid],function(err, results, fields){
		
		conn.query(sql2, [req.params.gabid], function(err2, results2,fields2){
			let stuff = {
				gab:results[0],
				likes: results2
			}
			res.render("likes",stuff)
		})
		
	})
})
app.post("/likes",function(req,res,next){
	// idgabs to get from the from
	const idgabs = req.body.gabid
	// userid comes from session req 
	const userid = req.session.idusers

		//insert both as likes
	const sql = `INSERT into likes (gabid,userid) VALUES (?, ?);`

	conn.query(sql, [idgabs, userid], function(err, results, fields){
		if (err){
		
			res.send("there was an error")
		}
		else {
			
			res.redirect("home")
		}
	})
})
app.listen(3000, function(){
  console.log("App running on port 3000")
})