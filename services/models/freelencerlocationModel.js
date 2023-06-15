const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from freelencer_has_locations`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,freelencer_id,locations_id)=>{
    const sql=`insert into freelencer_has_locations (freelencer_id,locations_id) values ("${freelencer_id}","${locations_id}")`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
update:(cb,freelencer_id,locations_id)=>{
    const sql=`update freelencer_has_locations set freelencer_id="${freelencer_id}" ,locations_id="${locations_id}" where id="${id}"`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},
getFreelencerLocation:(callback,id)=>{
    const sql=`select * from freelencer_has_locations where id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
deleteFreelencerLocation:(callback,id)=>{
    const sql=`DELETE FROM freelencer_has_locations WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}