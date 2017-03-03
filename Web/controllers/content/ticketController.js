/*
     Controller for providing data to the ticketView
 */
app.controller('ticketController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Ticket View";
}]);
