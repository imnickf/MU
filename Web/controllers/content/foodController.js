/*
      Controller for providing data to the foodView
 */
app.controller('foodController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Food View";
}]);