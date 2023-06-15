const express = require("express")
const router=express.Router()
const{getAll,addReviews,updateReviews,getOneReviews,deleteReviews}=require("../controller/reviewsController")


router.get("/getAll",getAll)
router.post("/addReviews",addReviews)
router.put("/updateReviews/:id",updateReviews)
router.get("/getOneReviews/:user_id",getOneReviews)
router.delete("/deleteReviews/:id",deleteReviews)
module.exports = router