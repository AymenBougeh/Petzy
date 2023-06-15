const express = require("express")
const router=express.Router()
const{getAll,addToCart,updateCart,deleteCart,deleteAllCart }=require("../controller/cartController")


router.get("/getAll",getAll)
router.post("/addToCart",addToCart)
router.put("/updateCart/:id",updateCart)
router.delete("/deleteCart/:id",deleteCart)
router.delete("/deleteAllCart/:users_id",deleteAllCart)
module.exports = router