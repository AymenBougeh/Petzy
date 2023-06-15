const location =require ("../models/addressModel")
module.exports ={
getAll:(req,res)=>{
    location.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addAddress: (req, res) => {
  const {
    name,
    address,
    city,
    state,
    zip,
    latitude,
    longitude
  } = req.body;

  const values = [name, address, city, state, zip, latitude, longitude];

  location.add((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).json(rslt);
    }
  }, values);
},


  updateAddress:(req,res)=>{
    const {
        name,
        address,
        city,
        state,
        zip,
        latitude,
        longitude
      } = req.body;

    location.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id,name,address,city,state,zip,latitude,longitude)
},
getOneAddress:(req,res)=>{
    location.getOnelocations((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteAddress:(req,res)=>{
    location.deleteLocation((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}