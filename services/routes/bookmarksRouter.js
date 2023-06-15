const express = require("express")
const router=express.Router()
const{getAll,addbookmark,updateBookmark,getOneBookmark,deleteBookmark}=require("../controller/bookmarksController")


router.get("/getAll",getAll)
router.post("/addbookmark",addbookmark)
router.put("/updateBookmark/:id",updateBookmark)
router.get("/getOneBookmark/:id",getOneBookmark)
router.delete("/deleteBookmark/:id",deleteBookmark)
module.exports = router