var express             = require('express');
var app                 = express();
var bodyParser          = require('body-parser');
var mongoose            = require('mongoose');
var morgan              = require('morgan');
var passport            = require('passport');
var jwt                 = require('jwt-simple');
var usersRouter         = require('./api/users');
var config              = require('./config/database');
var port                = process.env.PORT || 8080;
var User                = require('./app/models/user');

mongoose.connect(config.database);                      // connect database
app.use(bodyParser.urlencoded({ extended: true }));     // configure app to use bodyParser()
app.use(bodyParser.json());                             // this will let us get the data from a POST
app.use(morgan('dev'));                                 // use morgan to log requests to the console
app.use(passport.initialize());                         // use the passport package in out application
require('./config/passport')(passport);                 // pass passport for config

// Basic route
app.get('/', function(req, res) {
    res.send('Hello! The API is at http://localhost:' + port + '/api');
});

// ROUTES FOR API
var apiRouter = express.Router();

apiRouter.get('/', function(req, res) {
    res.json({ message: 'Hooray! Welcome to the MU API!' });
});

// create a new user account (POST http://localhost:8080/api/signup)
apiRouter.post('/signup', function(req, res) {
    if (!req.body.name || !req.body.password) {
        res.json({
            success: false,
            msg: 'Please provide name and password'
        });
    } else {
        var newUser = new User({
            name: req.body.name,
            password: req.body.password
        });
        newUser.save(function(err) {
            if (err) {
                return res.json({
                    success: false,
                    msg: 'Username already exists'
                });
            }
            res.json({
                success: true,
                msg: 'Successfully created new user'
            });
        });
    }
});

// route to authenticate a user (POST http://localhost:8080/api/authenticate)
apiRouter.post('/authenticate', function(req, res) {
    User.findOne({
        name: req.body.name
    }, function(err, user) {
        if (err)
            throw err;
        if (!user) {
            res.send({ success: false, msg: 'Authentication failed. User not found.' });
        } else {
            // check if password matches
            user.compare(req.body.password, function(err, isMatch) {
                if (isMatch && !err) {
                    // if user is found and password is right create a token
                    var token = jwt.encode(user, config.secret);
                    // return the information including token as JSON
                    res.json({ success: true, token: 'JWT ' + token });
                } else {
                    res.send({ success: false, msg: 'Authentication failed. Wrong password.' });
                }
            });
        }
    });
});

// route to a restricted info (GET http://localhost:8080/api/memberinfo)
apiRouter.get('/memberinfo', passport.authenticate('jwt', { session: false }), function(req, res) {
    var token = getToken(req.headers);
    if (token) {
        var decoded = jwt.decode(token, config.secret);
        User.findOne({
            name: decoded.name
        }, function(err, user) {
            if (err) throw err;

            if (!user) {
                return res.status(403).send({ success: false, msg: 'Authentication failed. User not found.' });
            } else {
                res.json({ success: true, msg: 'Welcome in the member area ' + user.name + '!' });
            }
        });
    } else {
        return res.status(403).send({ success: false, msg: 'No token provided.' });
    }
});

getToken = function (headers) {
    if (headers && headers.authorization) {
        var parted = headers.authorization.split(' ');
        if (parted.length === 2) {
            return parted[1];
        } else {
            return null;
        }
    } else {
        return null;
    }
};

// REGISTER ROUTES
// all routes will be prefixed with /api
app.use('/api', apiRouter);

// register user routes
app.use('/api', usersRouter);

// START THE SERVER
app.listen(port);
console.log('Magic happens on port ' + port);
