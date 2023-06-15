const express = require("express")
const router=express.Router()
const{getAll,addBlog,updateBlog,getOneBlog,deleteBlog}=require("../controller/blogsController")


router.get("/getAll",getAll)
router.post("/addBlog",addBlog)
router.put("/updateBlog/:user_id",updateBlog)
router.get("/getOneBlog/:user_id",getOneBlog)
router.delete("/deleteBlog/:user_id",deleteBlog)
module.exports = router