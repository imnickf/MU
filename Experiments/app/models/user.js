var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');

var UserSchema = new Schema({
    name: {
        type: String,
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true
    },
    admin: Boolean,
    moderator: Boolean
});

UserSchema.pre('save', function(next) {
    var user = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function(err, salt) {
            if (err)
                next(err);
            bcrypt.hash(user.password, salt, function(err, hash) {
               if (err)
                   next(err);
               user.password = hash;
               next();
            });
        });
    } else {
        return next();
    }
});

UserSchema.methods.compare = function (passw, cb) {
    bcrypt.compare(passw, this.password, function(err, isMatch) {
        if (err)
            return cb(err);
        cb(null, isMatch);
    });
};

module.exports = mongoose.model('User', UserSchema);
