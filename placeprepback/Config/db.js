const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/Auth')
    .on('open', () => { console.log("Database Connected"); })
    .on("error", () => { console.log("Db Connection Error"); });

module.exports = connection;