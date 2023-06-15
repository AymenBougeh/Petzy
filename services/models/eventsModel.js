const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from events`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `INSERT INTO events (title, description, date) VALUES (?, ?, ?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  }
  ,
  update: (cb, id, data) => {
    const sql = 'UPDATE events SET ? WHERE id = ?';
    db.query(sql, [data, id], (err, rslt) => {
      cb(err, rslt);
    });
  },
  
getOne:(callback,id)=>{
    const sql=`select * from events where id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM events WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}