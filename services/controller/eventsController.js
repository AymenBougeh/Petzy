const events =require ("../models/eventsModel")
module.exports ={
getAll:(req,res)=>{
    events.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addEvents: (req, res) => {
  const {
    title,
    description,
    date
  } = req.body;

  events.add((err, rslt) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(rslt);
    }
  }, [title, description, date]);
},

updateEvents: (req, res) => {
  const { title, description, date } = req.body;

  events.update((err, result) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log(req.body);
      res.status(200).json(result);
    }
  }, req.params.id, { title, description, date });
},

getEvents:(req,res)=>{
    events.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

deleteEvents:(req,res)=>{
    events.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}