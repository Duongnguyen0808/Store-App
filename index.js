// import the express module
const express = require('express');

const mongoose = require('mongoose'); // CẦN THIẾT ĐỂ KẾT NỐI MONGO
const authRouter = require('./routes/auth');

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
mongoose.connect(DB).then(() => {
    console.log('mongodb ket noi thanh cong ');
});

// start the server and listen on the specified port
app.listen(PORT, "0.0.0.0", function () {
    // LOG THE NUMBER
    console.log(`sever is running on  post ${PORT}`);

})