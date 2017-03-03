/*
     Controller for providing data to the textbookView
 */
app.controller('textbookController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Textbook View";
}]);
