const reminders =require ("../models/remindersModel")
module.exports ={
getAll:(req,res)=>{
    reminders.get((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    })
},
addReminder: (req, res) => {
    const {
  
      title,
      description,
      date,
      time,
      is_completed,
      user_id,
      orders_id
    
    } = req.body;

    const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');


  
    reminders.add((err, rslt) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log(req.body);
        res.status(200).json(rslt);
      }
    } ,[title,description,date,time,is_completed,date_created,date_modified,user_id,orders_id]);
  },

  updateReminder:(req,res)=>{
    const {
      
      title,
      description,
      date,
      time,
      is_completed,
      user_id,
      orders_id     
    
    } = req.body;

    const date_created = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const date_modified = new Date().toISOString().slice(0, 19).replace('T', ' ');

    reminders.update((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },[req.params.id,title,description,date,time,is_completed,date_created,date_modified,user_id,orders_id])
},
getOneReminder:(req,res)=>{
    reminders.getOne((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.user_id)
},

deleteReminder:(req,res)=>{
    reminders.delete((err,result)=>{
        if (err) res.status(500).send(err)
        else res.status(200).json(result)
    },req.params.id)
},

}