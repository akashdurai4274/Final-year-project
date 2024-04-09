const mongoose = require('mongoose');
const db = require('../Config/db'); 
const bcrypt = require('bcrypt');
const { Schema } = mongoose;

const UserSchema = new Schema(
    {
        email: {
            type: String,
            lowercase: true,
            required: true,
            unique:true
        },
        password:{ 
            type:String,
            required:true
        }
    }
)

UserSchema.pre('save', async function(){
    try {
        var user = this;
        const salt = await (bcrypt.genSalt(10));
        const hashpass = await (bcrypt.hash(user.password, salt));
        //Store hashpass as a user password
        user.password = hashpass;
    } catch (error) {
        throw error
    }
})

UserSchema.methods.comparepassword = async function (userpassword) {
    try {
        const isMatch = await bcrypt.compare(userpassword, this.password);
        return isMatch
    } catch (error) {
        throw new Error("Error")
    }
}
const userModel = db.model('users', UserSchema);
module.exports = userModel;