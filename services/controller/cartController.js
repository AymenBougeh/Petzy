const cart =require ("../models/cartModel")
module.exports ={
getAll:(req,res)=>{
    cart.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addToCart: (req, res) => {
  const { users_id, shop_id, product_name, product_price, quantity, product_img, breed } = req.body;

  const values = [users_id, shop_id, product_name, product_price, quantity, product_img, breed];

  cart.add((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(rslt);
    }
  }, values);
},


updateCart: (req, res) => {
  const { users_id, shop_id, product_name, product_price, quantity, product_img, breed } = req.body;

  const data = {
    users_id: users_id,
    shop_id: shop_id,
    product_name: product_name,
    product_price: product_price,
    quantity: quantity,
    product_img: product_img,
    breed: breed
  };

  cart.update((err, result) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).json(result);
    }
  }, req.params.id, data);
},



deleteCart:(req,res)=>{
    cart.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

deleteAllCart: (req, res) => {
  const users_id = req.params.users_id; 

  cart.deleteAll((err, result) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).json(result);
    }
  }, users_id);
}
}