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
angular.module('app').controller('navController', ['$scope', '$log','$firebaseObject', function($scope, $log, $firebaseObject){
    $scope.items = [
        'Profile',
        'Food'
    ];

    $scope.status = {
        isopen: false
    };

    $scope.toggled = function(open) {
        $log.log('Dropdown is now: ', open);
    };

    $scope.toggleDropdown = function($event) {
        $event.preventDefault();
        $event.stopPropagation();
        $scope.status.isopen = !$scope.status.isopen;
    };

    $scope.appendToEl = angular.element(document.querySelector('#dropdown-long-content'));

    $scope.isNavCollapsed = true;
    $scope.email = "";
    $scope.display_dropDwn = false;

    // listen for authentication changes
    firebase.auth().onAuthStateChanged(function(user) {
        if (user && user.email.includes("@iastate.edu")){
            // user is logged in using an @iastate.edu account
            $scope.loggedInText = "You are currently logged in as " + user.email;
            $scope.email = user.email;
            $scope.display_dropDwn = true;
        }else if(user){
            // user is logged in with non-iastate account
            $scope.email = user.email;
            firebase.auth().signOut();
        }else{
            // user is logging out, determine if @iastate.edu so we can print the correct error message
            if($scope.email == "" || $scope.email.includes("@iastate.edu")){
                // user logged out
                $scope.loggedInText = "You are not logged in.";
            }else if(!$scope.email.includes("@iastate.edu")){
                // user automatically signed out of a non-iastate account
                $scope.loggedInText = "Bitch login with an iastate.edu account or get the fuck out.";
            }// end if email does not include @iastate
            $scope.display_dropDwn = false;
        }// end if we have a valid user

        $scope.$apply();
    });
}]);
