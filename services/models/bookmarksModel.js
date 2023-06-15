const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from bookmarks`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
    const sql = `insert into bookmarks (user_id, date_created, shop_id) values (?, ?, ?)`;
    db.query(sql, values, (err, rslt) => {
      cb(err, rslt);
    });
  },

  update:(cb, id, user_id, shop_id, date_created)=>{
    const sql=`update bookmarks set user_id=${user_id}, shop_id=${shop_id}, date_created="${date_created}" where id="${id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
}
,

getOne:(callback,user_id)=>{
    const sql=`select * from bookmarks where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM bookmarks WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}