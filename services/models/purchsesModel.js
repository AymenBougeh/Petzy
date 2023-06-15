const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from purchases`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `INSERT INTO purchases (name, purchase_number, date, shop_id) VALUES (?, ?, ?, ?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  }

}