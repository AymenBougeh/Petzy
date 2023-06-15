const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from shop`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `INSERT INTO shop (name, description, image, price, category, breed, total_purchase, last_purchase, updated_at, rating) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  },
  update: (cb, id, name, description, image, price, category, breed, total_purchase, last_purchase, updated_at, rating) => {
    const sql = `UPDATE shop SET name=?, description=?, price=?, image=?, category=?, breed=?, total_purchase=?, last_purchase=?, updated_at=?, rating=? WHERE id=?`;
  
    const values = [name, description, price, image, category, breed, total_purchase, last_purchase, updated_at, rating, id];
  
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  },
getOne:(callback,id)=>{
    const sql=`select * from shop where id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
deleteProduct:(callback,id)=>{
    const sql=`DELETE FROM shop WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}