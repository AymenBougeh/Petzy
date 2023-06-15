const express = require("express")
const router=express.Router()
const{getAll,addLocation,updateLocations,getOnelocations,deleteLocation}=require("../controller/locationsController")


router.get("/getAll",getAll)
router.post("/addLocation",addLocation)
router.put("/updateLocations/:id",updateLocations)
router.get("/getOnelocations/:user_id",getOnelocations)
router.delete("/deleteLocation/:id",deleteLocation)
module.exports = router 