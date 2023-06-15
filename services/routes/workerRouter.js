const express = require("express")
const router=express.Router()
const{getAll,addWorker,updateWorker,getOne,deleteWorker}=require("../controller/workerController")


router.get("/getAll",getAll)
// router.post("/addWorker",addWorker)
router.post('/register',addWorker)
router.post('/login',getOne)
router.put("/updateWorker/:id",updateWorker)
// router.get("/getOne/:users_id",getOne)
router.delete("/deleteWorker/:id",deleteWorker)
module.exports = router