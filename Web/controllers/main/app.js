/*
    Main controller for handling configuration and dependency settings,
    also provides a controller for the header and navigation
*/
'use strict';

// initialize our firebase settings
var config = {
    apiKey: "AIzaSyB3bDwdIesJJqq8LUY06d_BS6RkGWjyarE",
    authDomain: "com-s-309-project.firebaseapp.com",
    databaseURL: "https://com-s-309-project.firebaseio.com",
    storageBucket: "com-s-309-project.appspot.com",
    messagingSenderId: "788794802091"
};
firebase.initializeApp(config);
var database = firebase.database();

// define our angular app, our dependencies are ngRoute, firebase, and ui.bootstrap
var app = angular.module('app', ['ngRoute', 'firebase', 'ui.bootstrap']);

app.controller('headerController', function($scope, authService) {
    // pull authentication variables/functions into current scope
    authService.setup($scope);

    $scope.auth.$onAuthStateChanged(function (user) {
        // listener function, called every time authentication state changes
        if (user && user.email.includes("@iastate.edu")) {
            // user is logged in using an @iastate.edu account
            $scope.user = user;
            $scope.display_Navinfo = true;
            $scope.error = '';
            // update firebase information with new user
            var updates = {};
            // normal users get a type set to 3
            updates['/users/' + user.uid + '/type'] = {type: 3};
            database.ref().update(updates);
        } else if (user) {
            // user is logged in with non-iastate account
            $scope.error = "You must login with your Iowa State (@iastate.edu) Google account.";
            authService.signOut();
        } else {
            // user is signing out
            $scope.display_Navinfo = false;
        }// end if we have a valid user
    });

    $scope.status = {
        isOpen: false
    };

    $scope.toggleDropdown = function($event) {
        $event.preventDefault();
        $event.stopPropagation();
        $scope.status.isopen = !$scope.status.isopen;
    };

    $scope.isNavCollapsed = true;
    $scope.display_Navinfo = false;
});
