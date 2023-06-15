
const purchase =require ("../models/purchsesModel")
module.exports ={
getAll:(req,res)=>{
    purchase.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addPurchase: (req, res) => {
    const { shop_id, name, purchase_number } = req.body;
    const date = new Date().toISOString().slice(0, 10).replace('T', ' ');
  
    purchase.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    }, [name, purchase_number, date, shop_id]);
  }



}