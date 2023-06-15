const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from availability`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into availability (start_time,end_time,day_of_week,worker_id) values (?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update:(cb,id,start_time,end_time,day_of_week)=>{
    const sql=`update availability set start_time="${start_time}",end_time="${end_time}",day_of_week="${day_of_week}" where id="${id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
getOne:(callback,user_id)=>{
    const sql=`select * from availability where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
delete:(callback,id)=>{
    const sql=`DELETE FROM availability WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}