const reviews =require ("../models/reviewsModel")
module.exports ={
getAll:(req,res)=>{
    reviews.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addReviews: (req, res) => {
    const {
      user_id,
      rating,
      comment,
      shop_id,
      worker_id
    
    } = req.body;
    const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
    reviews.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    },[user_id,rating,comment,date_created,date_modified,shop_id,worker_id]);
  },

  updateReviews: (req, res) => {
    const {
      user_id,
      rating,
      comment,
      shop_id,
      worker_id
    } = req.body;
  
    const id = req.params.id.replace(/,/g, '');
  
    const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
    reviews.update((err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send(err);
      } else {
        res.status(200).json(result);
      }
    }, [id, user_id, rating, comment, date_created, date_modified, shop_id, worker_id]);
  },
getOneReviews:(req,res)=>{
    reviews.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

deleteReviews:(req,res)=>{
    reviews.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}