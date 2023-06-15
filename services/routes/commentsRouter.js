const express = require("express")
const router=express.Router()
const{getAll,addComment,updateComment,getOneComment,deleteComment}=require("../controller/commentsController")


router.get("/getAll",getAll)
router.post("/addComment",addComment)
router.put("/updateComment/:id",updateComment)
router.get("/getOneComment/:id",getOneComment)
router.delete("/deleteComment/:id",deleteComment)
module.exports = router