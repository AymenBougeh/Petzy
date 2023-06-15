const express = require("express")
const router=express.Router()
const{getAll,addPosts,updatePosts,getOnePosts,deletePosts}=require("../controller/postsController")


router.get("/getAll",getAll)
router.post("/addPosts",addPosts)
router.put("/updatePosts/:user_id",updatePosts)
router.get("/getOnePosts/:user_id",getOnePosts)
router.delete("/deletePosts/:user_id",deletePosts)
module.exports = router