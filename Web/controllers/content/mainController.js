/*
   Controller for providing data to the indexView
*/
angular.module('app').controller('mainController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // grab the firebase database object
    $scope.data = "Main VIew";
}]);