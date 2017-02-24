/**
 * Created by Pine-Pro on 2/21/2017.
 */


angular.module('app').controller('indexController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // grab the firebase database object
    const database = firebase.database();
    //const auth = firebase.auth();
    var provider = new firebase.auth.GoogleAuthProvider();

    $scope.signOut = function() {
        firebase.auth().signOut().then(function() {
            $scope.hide_Logout = true;
            $scope.hide_Login = false;
            console.log("Not FAiled");
            //sign-out successful
        }, function(error) {
            console.log("Failed");
        });


    };


    $scope.authenticate = function() {
        firebase.auth().signInWithPopup(provider).then(function(result) {
            // This gives you a Google Access Token. You can use it to access the Google API.
            var token = result.credential.accessToken;
            // The signed-in user info.
            var user = result.user;
            // ...
            $scope.hide_Logout = false;
            $scope.hide_Login = true;

        }).catch(function(error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // The email of the user's account used.
            var email = error.email;
            // The firebase.auth.AuthCredential type that was used.
            var credential = error.credential;
            // ...
        });
    };




}]);