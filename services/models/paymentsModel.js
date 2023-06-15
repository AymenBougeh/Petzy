const db = require ('../db/index')

module.exports={
get:(callback)=>{
    const sql=`select * from payments`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
add:(cb,values)=>{
    const sql=`insert into payments (amount,payment_method,transaction_id,date_created,user_id,order_id,worker_id) values (?,?,?,?,?,?,?)`
    db.query(sql,values,(err,rslt)=>{
        cb(err,rslt)
    })
},
update: (cb, id, amount, payment_method, transaction_id, date_created, user_id, order_id, worker_id) => {
    const sql = `UPDATE payments SET amount="${amount}", payment_method="${payment_method}", transaction_id="${transaction_id}", date_created="${date_created}", user_id="${user_id}", order_id="${order_id}", worker_id="${worker_id}" WHERE id=${id}`;
    db.query(sql, (err, rslt) => {
      cb(err, rslt);
    });
  },
getOnePayments:(callback,user_id)=>{
    const sql=`select * from payments where user_id="${user_id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
},
deletePayment:(callback,id)=>{
    const sql=`DELETE FROM payments WHERE id="${id}"`
    db.query(sql,(err,res)=>{
        callback(err,res)
    })
}


}