/*
    Controller for providing data to the profileView
 */
app.controller('profileController', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Profile View";
});