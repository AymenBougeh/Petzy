const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from reminders`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into reminders (title,description,date,time,is_completed,date_created,date_modified,user_id,orders_id) values (?,?,?,?,?,?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update:(cb,title,description,date,time,is_completed,date_created,date_modified)=>{
    const sql=`update reminders set title="${title}",description="${description}",time="${time}",=is_completed"${is_completed}",date="${date}",date_created="${date_created}",date_modified="${date_modified}" where id="${id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
getOne:(callback,user_id)=>{
    const sql=`select * from reminders where id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM reminders WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}