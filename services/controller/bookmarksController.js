const bookmarks =require ("../models/bookmarksModel")
module.exports ={
getAll:(req,res)=>{
    bookmarks.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addbookmark: (req, res) => {
  const { user_id, shop_id } = req.body;
  const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');

  bookmarks.add((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(rslt);
    }
  }, [user_id, date_created, shop_id]);
}
,

updateBookmark:(req,res)=>{
  const { user_id, shop_id } = req.body;
  const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');

  bookmarks.update((err,result)=>{
      if (err) res.status(500).send(err)
      else res.status(200).json(result)
  }, req.params.id, user_id, shop_id, date_created);
}

,
getOneBookmark:(req,res)=>{
    bookmarks.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteBookmark:(req,res)=>{
    bookmarks.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}