const express = require("express")
const router=express.Router()
const{getAll,addFreelencerLoc,updateFreelencerLoc,getFreelencerLoc,deleteFreelencerLoc}=require("../controller/freelencerLocationControll")


router.get("/getAll",getAll)
router.post("/addFreelencerLoc",addFreelencerLoc)
router.put("/updateFreelencerLoc/:id",updateFreelencerLoc)
router.get("/getFreelencerLoc/:id",getFreelencerLoc)
router.delete("/deleteFreelencerLoc/:id",deleteFreelencerLoc)
module.exports = router