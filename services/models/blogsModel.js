const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from blogs`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into blogs (title,content,image,user_id) values (?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update: (cb, values) => {
  const sql = `UPDATE blogs
               SET title=?, content=?, image=?, user_id=?
               WHERE user_id=?`;
  db.query(sql, values, (err, rslt) => {
    cb(err, rslt);
  });
},

getOne:(callback,user_id)=>{
    const sql=`select * from blogs where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,user_id)=>{
    const sql=`DELETE FROM blogs WHERE user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}