var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = new Schema({
    name: String,
    password: String,
    admin: Boolean,
    moderator: Boolean
});

module.exports = mongoose.model('User', UserSchema);
