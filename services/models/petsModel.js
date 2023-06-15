const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from pets`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into pets (name,species,breed,age,gender,image,user_id) values (?,?,?,?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update:(cb,user_id,name,species,breed,age,gender,image)=>{
    const sql=`update pets set name="${name}",species="${species}",breed="${breed}",age="${age}",gender="${gender}",image="${image}" where user_id="${user_id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
getUserPets:(callback,user_id)=>{
    const sql=`select * from pets where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
deletepet:(callback,id)=>{
    const sql=`DELETE FROM pets WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}