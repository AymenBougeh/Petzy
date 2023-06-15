const blogs =require ("../models/blogsModel")
module.exports ={
getAll:(req,res)=>{
    blogs.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addBlog: (req, res) => {
    const {
      title,
      content,
      image,
      user_id
    } = req.body;

  
    blogs.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    } ,[title,content,image,user_id]);
  },

  updateBlog:(req,res)=>{
    const {
    
       title,
       content,
      image,
      user_id

      } = req.body;

    

    blogs.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },[title,content,image,user_id,req.params.user_id])
},
getOneBlog:(req,res)=>{
    blogs.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteBlog:(req,res)=>{
    blogs.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

}