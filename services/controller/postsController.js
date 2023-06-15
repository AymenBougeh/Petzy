const posts =require ("../models/postsModel")
module.exports ={
getAll:(req,res)=>{
    posts.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addPosts: (req, res) => {
    const {
      title,
      content,
      image,
      user_id
    } = req.body;

    const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
    posts.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    } ,[title,content,image,date_created,date_modified,user_id]);
  },

  updatePosts:(req,res)=>{
    const {
    
       title,
       content,
      image,
      user_id

      } = req.body;
      const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
      const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');
    

    posts.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },[title,content,image,date_created,date_modified,user_id,req.params.id])
},
getOnePosts:(req,res)=>{
    posts.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deletePosts:(req,res)=>{
    posts.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}