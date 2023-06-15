const mysql = require("mysql2")

const db = mysql.createConnection({
    // host: "localhost",
    // user: "root",
    // password : "root",
    // database: "petzy123"
    host: "db4free.net",
    user: "rafiksouifi1",
    password : "Final123",
    database: "petzy123"
})

db.connect((err)=>{
    if(err){
        console.log(err)
    }else
   { console.log("connected to petzy")}
})

module.exports=db