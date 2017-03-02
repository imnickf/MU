/**
 * Created by Pine-Pro on 2/21/2017.
 */

angular.module('app').controller('loginController', ['$scope', '$firebaseObject', '$location', function($scope, $firebaseObject, $location){
    // grab the firebase database object
    const database = firebase.database();
    //const auth = firebase.auth();
    var provider = new firebase.auth.GoogleAuthProvider();

    // listen for authentication changes
    firebase.auth().onAuthStateChanged(function(user) {
        if (user){
            // user is logged in
            $scope.hide_Logout = false;
            $scope.hide_Login = true;
        }else{
            // user logged out
            $scope.hide_Logout = true;
            $scope.hide_Login = false;
        }// end if we have a valid user

        $scope.$apply();
    });

    $scope.signOut = function() {
        // sign the user out using firebase
        firebase.auth().signOut();
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
        });
    };

}]);