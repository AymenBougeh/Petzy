const express = require("express")
const router=express.Router()
const{getAll,addPurchase}=require("../controller/purchasesController")


router.get("/getAll",getAll)
router.post("/addPurchase",addPurchase)

module.exports = router