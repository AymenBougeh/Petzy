const express = require("express")
const router=express.Router()
const{getAll,addPayments,updatePayments,getOnePayments,deletePayments}=require("../controller/paymentsController")


router.get("/getAll",getAll)
router.post("/addPayments",addPayments)
router.put("/updatePayments/:id",updatePayments)
router.get("/getOnePayments/:user_id",getOnePayments)
router.delete("/deletePayments/:id",deletePayments)
module.exports = router