const orders =require ("../models/ordersModel")
module.exports ={
getAll:(req,res)=>{
    orders.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addOrder: (req, res) => {
  const {
    user_id,
    status,
    worker_name,
    pet_name,
    pick_up_date,
    drop_of_date,
    walk_per_day,
    meal_per_day,
    price,
    worker_id
  } = req.body;

  const values = [
    user_id,
    status,
    worker_name,
    pet_name,
    pick_up_date,
    drop_of_date,
    walk_per_day,
    meal_per_day,
    price,
    worker_id
  ];

  orders.add((err, result) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).json(result);
    }
  }, values);
},



updateOrder: (req, res) => {
  const data = [req.body, req.params.id];
  orders.update((err, result) => {
    if (err) res.status(500).send(err);
    else res.status(200).json(result);
  }, data);
},

getOneOrder:(req,res)=>{
    orders.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteOrder:(req,res)=>{
    orders.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}