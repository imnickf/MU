/*
      Controller for providing data to the foodView
 */
angular.module('app').controller('foodController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Food View";
}]);