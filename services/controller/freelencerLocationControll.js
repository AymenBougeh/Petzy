const freelencerLoc =require ("../models/freelencerlocationModel")
module.exports ={
getAll:(req,res)=>{
    freelencerLoc.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addFreelencerLoc: (req, res) => {
    const {
      freelencer_id,
      location_id
    } = req.body;
  
    freelencerLoc.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    }, freelencer_id,location_id);
  },

  updateFreelencerLoc:(req,res)=>{
    const {
        freelencer_id,
        location_id
      } = req.body;
    
    freelencerLoc.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id,freelencer_id,location_id)
},
  getFreelencerLoc:(req,res)=>{
    freelencerLoc.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

deleteFreelencerLoc:(req,res)=>{
    freelencerLoc.deleteFreelencerLoc((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}