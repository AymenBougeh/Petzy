const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from posts`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into posts (title,content,image,date_created,date_modified,user_id) values (?,?,?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update: (cb, values) => {
  const sql = `UPDATE posts
               SET title=?, content=?, image=?, date_created=?, date_modified=?, user_id=?
               WHERE user_id=?`;
  db.query(sql, values, (err, rslt) => {
    cb(err, rslt);
  });
},

getOne:(callback,user_id)=>{
    const sql=`select * from posts where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM posts WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}