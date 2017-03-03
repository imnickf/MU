/**
 * Created by Pine-Pro on 2/21/2017.
 */

app.controller('loginController', ['$scope', '$firebaseObject', '$location', 'authService', function($scope, $firebaseObject, $location, authService){
    // grab the firebase database object
    const database = firebase.database();
    //const auth = firebase.auth();
    var provider = new firebase.auth.GoogleAuthProvider();

    $scope.auth = authService.getCurrentUser();

    $scope.signOut = function() {
        // sign the user out using firebase
        firebase.auth().signOut();
    };

    $scope.authenticate = function() {
        $scope.user = authService.authenticate();
    };

    $scope.auth.$onAuthStateChanged(function(firebaseUser) {
        if(firebaseUser){
            // user is logged in
            $scope.hide_Logout = false;
            $scope.hide_Login = true;
        }else{
            // user logged out
            $scope.hide_Logout = true;
            $scope.hide_Login = false;
        }// end if we have a valid user
    });

}]);