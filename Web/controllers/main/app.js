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
app.controller('navController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    $scope.isNavCollapsed = true;
}]);

app.controller('authController', ['$scope', 'authService', function($scope, authService){
    // pull auth object from authService
    $scope.auth = authService.getCurrentUser();

    $scope.auth.$onAuthStateChanged(function(firebaseUser) {
        $scope.user = firebaseUser;
    });
}]);
