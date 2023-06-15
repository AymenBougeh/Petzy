const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from cart`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `insert into cart (users_id, shop_id, product_name,product_price,quantity,product_img, breed) values (?, ?, ?, ?, ?,?,?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  },

  update: (cb, id, data) => {
    const sql = 'UPDATE cart SET ? WHERE id = ?';
    db.query(sql, [data, id], (err, rslt) => {
      cb(err, rslt);
    });
  },

getOne:(callback,users_id)=>{
    const sql=`select * from cart where users_id="${users_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM cart WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},

deleteAll:(callback,users_id)=>{
  const sql=`DELETE FROM cart WHERE users_id="${users_id}"`
  db.query(sql,(err,res)=>{
      callback(err,res)
  })
}


}