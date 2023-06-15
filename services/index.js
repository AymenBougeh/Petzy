const express = require("express");
const cors = require("cors");
const app = express();
const conn = require("./db")
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));


///////////////////////////////////////////////////
const userRouter=require("./routes/userRouter");
const shopRouter=require("./routes/shopRouter");
const petsRouter=require("./routes/petsRouter");
const workerRouter=require("./routes/workerRouter");
const reviewsRouter=require("./routes/reviewsRouter");
const postsRouter=require("./routes/postsRouter");
const paymentsRouter=require("./routes/paymentsRouter");
const commentsRouter=require('./routes/commentsRouter');
const bookmarksRouter=require('./routes/bookmarksRouter');
const availabilityRouter=require('./routes/availabilityRouter');
const eventsRouter=require('./routes/eventsRouter')
const ordersRouter=require('./routes/ordersRouter');
const remindersRouter=require('./routes/remindersRoutes');
const blogsRouter=require('./routes/blogsRouter');
const cartRouter=require('./routes/cartRoute');
const purchaseRouter=require('./routes/purchasesRouter');



//////////////////////////////////////////////////
app.use('/user',userRouter);
app.use('/shop',shopRouter);
app.use('/pets',petsRouter);
app.use('/worker',workerRouter);
app.use('/reviews',reviewsRouter); 
app.use('/posts',postsRouter);
app.use('/payments',paymentsRouter);
app.use('/comments',commentsRouter);
app.use('/bookmarks', bookmarksRouter);
app.use('/availability',availabilityRouter);
app.use('/events',eventsRouter);
app.use('/orders',ordersRouter);
app.use('/reminders',remindersRouter);
app.use('/blogs',blogsRouter);
app.use('/cart',cartRouter);
app.use('/purchases',purchaseRouter);



app.listen(3000,()=>{
    console.log("listening on 3000");
})