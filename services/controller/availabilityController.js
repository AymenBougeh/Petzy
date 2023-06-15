const availability =require ("../models/availabilityModel")
module.exports ={
getAll:(req,res)=>{
    availability.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addAvailability: (req, res) => {
    const {
      
      start_time,
      end_time,
      day_of_week
    } = req.body;
  
    availability.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    }, start_time,end_time,day_of_week);
  },

  updateAvailability:(req,res)=>{
    const {
      
        start_time,
        end_time,
        day_of_week
      } = req.body;

    availability.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id,start_time,end_time,day_of_week)
},
getAvailability:(req,res)=>{
    availability.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteAvailability:(req,res)=>{
    availability.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}