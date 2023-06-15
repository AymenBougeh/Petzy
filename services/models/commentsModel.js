const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from comments`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `INSERT INTO comments (user_id, post_id, content, date_created, date_modified) VALUES (?, ?, ?, ?, ?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  },
  update: (cb, id, content, date_created, date_modified) => {
    const sql = `UPDATE comments SET content="${content}", date_created="${date_created}", date_modified="${date_modified}" WHERE id="${id}"`
    db.query(sql, (err, rslt) => {
      cb(err, rslt)
    })
  },
getOne:(callback,user_id)=>{
    const sql=`select * from comments where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM comments WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}