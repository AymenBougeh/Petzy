const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from reviews`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into reviews (user_id,rating,comment,date_created,date_modified,shop_id,worker_id) values (?,?,?,?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update: (cb, [id, user_id, rating, comment, date_created, date_modified, shop_id, worker_id]) => {
    const sql = `update reviews set user_id="${user_id}", rating="${rating}", comment="${comment}", date_created="${date_created}", date_modified="${date_modified}", shop_id="${shop_id}", worker_id="${worker_id}" where id="${id}"`;
    db.query(sql, (err, rslt) => {
      cb(err, rslt);
    });
  },
getOne:(callback,id)=>{
    const sql=`select * from reviews where id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM reviews WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}