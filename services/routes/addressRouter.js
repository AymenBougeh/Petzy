const express = require("express")
const router=express.Router()
const{getAll,addAddress,updateAddress,getOneAddress,deleteAddress}=require("../controller/addressController")


router.get("/getAll",getAll)
router.post("/addAddress",addAddress)
router.put("/updateAddress/:user_id",updateAddress)
router.get("/getOneAddress/:user_id",getOneAddress)
router.delete("/deleteAddress/:id",deleteAddress)
module.exports = router 