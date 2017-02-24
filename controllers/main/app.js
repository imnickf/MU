/*
    Main controller for handling configuration and dependency settings
*/

// initialize our firebase settings
var config = {
    apiKey: "AIzaSyB3bDwdIesJJqq8LUY06d_BS6RkGWjyarE",
    authDomain: "com-s-309-project.firebaseapp.com",
    databaseURL: "https://com-s-309-project.firebaseio.com",
    storageBucket: "com-s-309-project.appspot.com",
    messagingSenderId: "788794802091"
};
firebase.initializeApp(config);

// define our angular app, our dependencies are ngRoute, firebase, and ui.bootstrap
var app = angular.module('app', ['ngRoute', 'firebase', 'ui.bootstrap']);

// controller for handling the navagation bar and header data
angular.module('app').controller('navController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    $scope.isNavCollapsed = true;

    // listen for authentication changes
    firebase.auth().onAuthStateChanged(function(user) {
        if (user){
            // user is logged in
            $scope.loggedInText = "You are currently logged in as " + user.email;
        }else{
            // user logged out
            $scope.loggedInText = "You are not logged in.";
        }// end if we have a valid user

        $scope.$apply();
    });
}]);
