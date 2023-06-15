const payments =require ("../models/paymentsModel")
module.exports ={
getAll:(req,res)=>{
    payments.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addPayments: (req, res) => {
  const {
    user_id,
    order_id,
    amount,
    payment_method,
    transaction_id,
    worker_id
  } = req.body;

  const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');

  payments.add((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(rslt);
    }
  }, [amount, payment_method, transaction_id, date_created, user_id, order_id, worker_id]);
},

updatePayments: (req, res) => {
  const {
    amount,
    payment_method,
    transaction_id,
    date_created,
    user_id,
    order_id,
    worker_id
  } = req.body;
  payments.update(
    (err, result) => {
      if (err) res.status(500).send(err);
      else res.status(200).json(result);
    }, [req.params.id, amount, payment_method, transaction_id, date_created, user_id, order_id, worker_id]
  );
},
getOnePayments:(req,res)=>{
    payments.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deletePayments:(req,res)=>{
    payments.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}