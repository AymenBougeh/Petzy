const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from locations`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,name,adress,city,state,zip,latitude,longitude)=>{
    const sql=`insert into locations (name,adress,city,state,zip,latitude,longitude) values ("${name}","${adress}","${city}","${state}","${zip}","${latitude}","${longitude}")`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
update:(cb,name,adress,city,state,zip,latitude,longitude)=>{
    const sql=`update locations set name="${name}",adress="${adress}",city="${city}",state="${state}",zip="${zip}",latitude="${latitude}",longitude="${longitude}" where id="${id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
getOnelocations:(callback,user_id)=>{
    const sql=`select * from locations where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
deletePayment:(callback,id)=>{
    const sql=`DELETE FROM locations WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}