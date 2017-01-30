var express = require('express');
var router = express.Router();

var User = require('../app/models/user');

router.route('/users')

    // GET all users (accessed at GET http://localhost:8080/api/users)
    .get(function(req, res) {
        User.find(function(err, users) {
            if (err)
                res.send(err);

            res.json(users);
        });
    });

router.route('/users/:user_id')

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

module.exports = router;