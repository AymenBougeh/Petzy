const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from users`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},


register:(cb,name,email,password,phone,image)=>{
    const sql=`insert into users (name,email,password,phone,image) values ("${name}","${email}","${password}","${phone}","${image}")`
    db.query(sql,(err,rslt)=>{
        cb(err,rslt)
    })
},



// update:(cb,id,name,email,password,phone,image)=>{
//     const sql=`update users set name="${name}" ,email="${email}",password="${password}",phone="${phone}",image="${image}" where id="${id}"`
//     db.query(sql,(err,rslt)=>{
//         cb(err,rslt)
//     })
// },
update: (cb, id, data) => {
  const columnsToUpdate = Object.keys(data)
    .filter((column) => column !== 'id')
    .map((column) => `\`${column}\` = ?`)
    .join(', ');

  const valuesToUpdate = Object.values(data).filter((value) => value !== id);

  const sql = `UPDATE users SET ${columnsToUpdate} WHERE id = ?`;

  valuesToUpdate.push(id);

  db.query(sql, valuesToUpdate, (err, result) => {
    if (err) return cb(err);
    cb(null, result);
  });
},




login: (email) => {
    const sql = `SELECT * FROM users WHERE email = '${email}'`;
    // const sql = `SELECT * FROM users WHERE email = '${data}' OR phone = '${data}'`;
    return new Promise((resolve, reject) => {
      db.query(sql, (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results[0]);
        }
      });
    });
  },
  

deleteUser:(callback,id)=>{
    const sql=`DELETE FROM users WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}