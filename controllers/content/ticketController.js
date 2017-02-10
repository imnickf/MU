/*
 Controller for providing data to the foodView
 */
angular.module('app').controller('ticketController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    $scope.data = "Ticket View";
}]);
