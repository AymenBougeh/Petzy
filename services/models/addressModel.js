const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from address`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add: (cb, values) => {
  const sql = `INSERT INTO address (name, address, city, state, zip, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?)`;
  db.query(sql, values, (err, rslt) => {
    cb(err, rslt)
  })
},



update:(cb,name,adress,city,state,zip,latitude,longitude)=>{
    const sql=`update address set name="${name}",adress="${adress}",city="${city}",state="${state}",zip="${zip}",latitude="${latitude}",longitude="${longitude}" where id="${id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
getOneaddress:(callback,user_id)=>{
    const sql=`select * from address where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
deleteAddress:(callback,id)=>{
    const sql=`DELETE FROM address WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}