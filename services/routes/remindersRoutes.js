const express = require("express")
const router=express.Router()
const{getAll,addReminder,updateReminder,getOneReminder,deleteReminder}=require("../controller/remindersController")


router.get("/getAll",getAll)
router.post("/addReminder",addReminder)
router.put("/updateReminder/:id",updateReminder)
router.get("/getOneReminder/:user_id",getOneReminder)
router.delete("/deleteReminder/:id",deleteReminder)
module.exports = router