const express = require("express")
const router=express.Router()
const{getAll,addAvailability,updateAvailability,getAvailability,deleteAvailability}=require("../controller/availabilityController")


router.get("/getAll",getAll)
router.post("/addAvailability",addAvailability)
router.put("/updateAvailability/:id",updateAvailability)
router.get("/getAvailability/:id",getAvailability)
router.delete("/deleteAvailability/:id",deleteAvailability)
module.exports = router