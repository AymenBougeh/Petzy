const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from orders`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `INSERT INTO orders (user_id, status, worker_name, pet_name, pick_up_date, drop_of_date, walk_per_day, meal_per_day, price, worker_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  },
  update: (cb, data) => {
    const sql = 'UPDATE orders SET ? WHERE id = ?;';
    db.query(sql, data, (err, rslt) => {
      cb(err, rslt);
    });
  },
getUserorders:(callback,user_id)=>{
    const sql=`select * from orders where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM orders WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}