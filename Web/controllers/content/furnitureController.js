/*
    Controller for providing data to the furnitureView
 */
app.controller('furnitureController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Furniture View";
}]);
