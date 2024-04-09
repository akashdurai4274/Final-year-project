const app = require('./app');
const db = require('./Config/db');
const userModel = require('./Models/userModel');
const port = 3000;


app.get((req,res,next) => {
    res.send("Welcome To this Page")
})

app.listen(port, () => {
    console.log(`Server listening in the port ${port}`);
})