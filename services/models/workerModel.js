const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from worker`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
// add: (cb, values) => {
//     const sql = `INSERT INTO worker (name, phone, image, license_number, years_of_experience, description, role,latitude,longitude,price,services,aboutPet) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
//     db.query(sql, values, (err, rslt) => {
//       cb(err, rslt);
//     });
//   },

  register:(cb,values)=>{
    const sql=`insert into worker (name,email,password,phone,image,status,license_number,years_of_experience,description,role,latitude,longitude,price,services,aboutPet,rating) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},

update: (cb, id, data) => {
  const columnsToUpdate = Object.keys(data)
    .filter((column) => column !== 'id')
    .map((column) => `\`${column}\` = ?`)
    .join(', ');

  const valuesToUpdate = Object.values(data).filter((value) => value !== id);

  const sql = `UPDATE worker SET ${columnsToUpdate} WHERE id = ?`;

  valuesToUpdate.push(id);

  db.query(sql, valuesToUpdate, (err, result) => {
    if (err) return cb(err);
    cb(null, result);
  });
},

// getOne:(callback,id)=>{
//     const sql=`select * from worker where id="${id}"`
//     db.query(sql,(err,res)=>{
//         callback(err,res)
//     })
// },

login: (email) => {
  const sql = `SELECT * FROM worker WHERE email = '${email}'`;
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

deletevet:(callback,id)=>{
    const sql=`DELETE FROM worker WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}