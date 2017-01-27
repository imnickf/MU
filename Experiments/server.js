var express             = require('express');
var app                 = express();
var bodyParser          = require('body-parser');
var mongoose            = require('mongoose');
var morgan              = require('morgan');
var usersRouter         = require('./api/users');
var config              = require("./config");
var port                = process.env.PORT || 8080;

mongoose.connect(config.database);                      // connect database
app.use(bodyParser.urlencoded({ extended: true }));     // configure app to use bodyParser()
app.use(bodyParser.json());                             // this will let us get the data from a POST
app.use(morgan('dev'));                                 // use morgan to log requests to the console

// Basic route
app.get('/', function(req, res) {
    res.send('Hello! The API is at http://localhost:' + port + '/api');
});

// ROUTES FOR API
var apiRouter = express.Router();

apiRouter.get('/', function(req, res) {
    res.json({ message: 'Hooray! Welcome to the MU API!' });
});

// REGISTER ROUTES
// all routes will be prefixed with /api
app.use('/api', apiRouter);

// register user routes
app.use('/api', usersRouter);

// START THE SERVER
app.listen(port);
console.log('Magic happens on port ' + port);
