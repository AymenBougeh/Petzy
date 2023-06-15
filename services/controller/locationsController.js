const locations =require ("../models/locationsModel")
module.exports ={
getAll:(req,res)=>{
    locations.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addLocation: (req, res) => {
    const {
      name,
      address,
      city,
      state,
      zip,
      latitude,
      longitude
    } = req.body;
  
    locations.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    }, name,address,city,state,zip,latitude,longitude);
  },

  updateLocations:(req,res)=>{
    const {
        name,
        address,
        city,
        state,
        zip,
        latitude,
        longitude
      } = req.body;

    locations.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id,name,address,city,state,zip,latitude,longitude)
},
getOnelocations:(req,res)=>{
    locations.getOnelocations((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteLocation:(req,res)=>{
    locations.deleteLocation((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}