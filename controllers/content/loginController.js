/**
 * Created by Pine-Pro on 2/21/2017.
 */


angular.module('app').controller('loginController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // grab the firebase database object
    const database = firebase.database();
    //const auth = firebase.auth();
    var provider = new firebase.auth.GoogleAuthProvider();

    $scope.signup = function() {
        const promise = provider.createUserWithEmailAndPassword($scope.email, $scope.pass);
    };

    $scope.authenticate = function() {
        firebase.auth().signInWithPopup(provider).then(function(result) {
            // This gives you a Google Access Token. You can use it to access the Google API.
            var token = result.credential.accessToken;
            // The signed-in user info.
            var user = result.user;

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