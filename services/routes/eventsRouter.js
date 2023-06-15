const express = require("express")
const router=express.Router()
const{getAll,addEvents,updateEvents,getEvents,deleteEvents}=require("../controller/eventsController")


router.get("/getAll",getAll)
router.post("/addEvents",addEvents)
router.put("/updateEvents/:id",updateEvents)
router.get("/getEvents/:id",getEvents)
router.delete("/deleteEvents/:id",deleteEvents)
module.exports = router