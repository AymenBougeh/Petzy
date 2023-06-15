const shop =require ("../models/shopModel")
module.exports ={
getAll:(req,res)=>{
    shop.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addProduct: (req, res) => {
  const {
    name,
    description,
    image,
    price,
    category,
    breed,
    total_purchase,
    last_purchase,
    rating
  } = req.body;

  const updated_at = new Date().toISOString().slice(0, 19).replace('T', ' ');

  const values = [
    name,
    description,
    image,
    price,
    category,
    breed,
    total_purchase,
    last_purchase,
    updated_at,
    rating
  ];

  shop.add((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(rslt);
    }
  }, values);
},

updateProduct: (req, res) => {
  const {
    name,
    description,
    image,
    price,
    category,
    breed,
    total_purchase,
    last_purchase,
    
    rating
  } = req.body;

  const updated_at = new Date().toISOString().slice(0, 19).replace('T', ' ');

  shop.update((err, result) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).json(result);
    }
  }, req.params.id, name, description, image, price, category, breed, total_purchase, last_purchase, updated_at, rating);
},
  getOne:(req,res)=>{
    shop.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

deleteProduct:(req,res)=>{
    shop.deleteProduct((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}