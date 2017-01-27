var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var morgan = require('morgan');
var jwt = require('jsonwebtoken');

var User = require('./app/models/user');
var config = require("./config");

var port = process.env.PORT || 8080;        // set port
mongoose.connect(config.database);          // connect database
app.set('superSecret', config.secret);      // secret variable

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// use morgan to log requests to the console
app.use(morgan('dev'));



// Basic route
app.get('/', function(req, res) {
    res.send('Hello! The API is at http://localhost:' + port + '/api');
});

// Setup route
app.get('/setup', function (req, res) {
   var nick = new User({
       name: 'Nick Flege',
       password: 'password',
       admin: true
   });

   nick.save(function (err, user) {
      if (err)
          res.send(err);

      console.log('User saved successfully');
      res.json({ success: true });
   });
});



// ROUTES FOR API
var apiRouter = express.Router();

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
apiRouter.get('/', function(req, res) {
    res.json({ message: 'hooray! welcome to our api!' });
});


apiRouter.route('/authenticate')

    .post(function (req, res) {
        User.findOne({
            name: req.body.name
        }, function (err, user) {
            if (err)
                res.send(err);

            if (!user) {
                res.json({ success: false, message: 'Authentication failed. User not found' });
            } else if (user) {
                // check if password matches
                if (user.password != req.body.password) {
                    res.json({ success: false, message: 'Authentication failed. Incorrect password' })
                } else {
                    // crate token
                    var token = jwt.sign(user, app.get('superSecret'), {
                        expiresIn: 1440
                    });

                    // return info including the token as JSON
                    res.json({
                        success: true,
                        message: 'Enjoy your token',
                        token: token
                    });
                }
            }

        });
    });

// middleware to use for all requests
apiRouter.use(function(req, res, next) {

    var token = req.body.token || req.query.token || req.headers['x-access-token'];

    if (token) {
        jwt.verify(token, app.get('superSecret'), function(err, decoded) {
            if (err) {
                return res.json({ success: false, message: 'Failed to authenticate token' });
            } else {
                req.decoded = decoded;
                next();
            }
        });
    } else {
        // Error: No token provided
        return res.status(403).send({
            success: false,
            message: 'No token provided.'
        });
    }
});

// on routes that end in /users
// ----------------------------------------------------
apiRouter.route('/users')

    // create a user (accessed at POST http://localhost:8080/api/users)
    .post(function(req, res) {

        var user = new User();      // create a new instance of the User model
        user.name = req.body.name;  // set the users name (comes from the request)

        // save the user and check for errors
        user.save(function(err) {
            if (err)
                res.send(err);

            res.json({ message: 'User created!' });
        });
    })

    // GET all users (accessed at GET http://localhost:8080/api/users)
    .get(function(req, res) {
       User.find(function(err, users) {
          if (err)
              res.send(err);

          res.json(users);
       });
    });

apiRouter.route('/users/:user_id')

    // GET specific user (accessed at GET http://localhost:8080/api/users/:user_id)
    .get(function(req, res) {
        User.findById(req.params.user_id, function(err, user) {
            if (err)
                res.send(err);
            res.json(user);
        });
    })

    // Update specific user's name (accessed at PUT http://localhost:8080/api/users/:user_id)
    .put(function(req, res) {
       User.findById(req.params.user_id, function(err, user) {
           if (err)
               res.send(err)

           user.name = req.body.name;
           user.save(function(err) {
              if (err)
                  res.send(err);
              res.json({ message: 'User updated' });
           });
       });
    })

    // Delete specific user (accessed at DELETE http://localhost:8080/api/users/:user_id)
    .delete(function(req, res) {
        User.remove({
            _id: req.params.user_id,
        }, function(err, user) {
            if (err)
                res.send(err);
            res.json({ message: 'Successfully deleted' });
        });
    });

// REGISTER ROUTES
// all routes will be prefixed with /api
app.use('/api', apiRouter);

// START THE SERVER
app.listen(port);
console.log('Magic happens on port ' + port);