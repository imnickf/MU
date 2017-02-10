/*
     Controller for handling the navagation bar
 */
angular.module('app').controller('navController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    $scope.isNavCollapsed = true;
}]);