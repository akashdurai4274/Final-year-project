const express = require('express');
const app = express();
const bodyparser = require('body-parser');
const userRouter = require('./Routes/userRoute')

app.use(bodyparser.json());

app.use('/', userRouter);
app.use((req, res, next) => {
    res.send("Welcome")
})

module.exports = app;