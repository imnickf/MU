/*
 Controller for providing data to the foodView
 */
angular.module('app').controller('foodController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    $scope.data = "Food View";
}]);