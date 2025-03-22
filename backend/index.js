// import the express module
const express = require('express');
const mongoose = require('mongoose'); // CẦN THIẾT ĐỂ KẾT NỐI MONGO
const authRouter = require('./routes/auth');
const bannerRouter = require('./routes/banner');
const categoryRouter = require('./routes/category');
const subcategoryRouter = require('./routes/sub_category');
const productRouter = require('./routes/product');
// Defind the port number the server will listen on 
const PORT = 3000;

// create an instance of an express application 
// because it give us the starting point 
const app = express();

// kết nối mongodb
const DB = "mongodb+srv://duonggnguyen88:bin211200119@cluster0.pd9ez.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// gan ket tuyen duong ket noi 
app.use(express.json());
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subcategoryRouter);
app.use(productRouter);
mongoose.connect(DB).then(() => {
    console.log('Kết nối cơ sở dữ liệu thành công');
});

// start the server and listen on the specified port
app.listen(PORT, "0.0.0.0", function () {
    // LOG THE NUMBER
    console.log(`Máy chủ đang chạy ở cổng ${PORT}`);

})