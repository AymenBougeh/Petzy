const comments =require ("../models/commentsModel")
module.exports ={
getAll:(req,res)=>{
    comments.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addComment: (req, res) => {
    const {
      user_id,
      post_id,
      content,
      
    } = req.body;
    const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
    comments.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    }, [user_id, post_id, content, date_created, date_modified]);
  },

  updateComment:(req,res)=>{
    const {
        user_id,
        post_id,
        content,
        date_created
        
      } = req.body;

      const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');

    comments.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },[req.params.id,content,date_created,date_modified,user_id,post_id])
},
getOneComment:(req,res)=>{
    comments.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteComment:(req,res)=>{
    pet.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}