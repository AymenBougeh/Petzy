const express = require("express")
const router=express.Router()
const{getAll,addOrder,updateOrder,getOneOrder,deleteOrder}=require("../controller/ordersController")


router.get("/getAll",getAll)
router.post("/addOrder",addOrder)
router.put("/updateOrder/:id",updateOrder)
router.get("/getOneOrder/:user_id",getOneOrder)
router.delete("/deleteOrder/:id",deleteOrder)
module.exports = router