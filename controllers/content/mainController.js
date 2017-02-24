/*
   Controller for providing data to the indexView
*/
angular.module('app').controller('mainController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // grab the firebase database object
    const database = firebase.database();

    // listen for database changes and update our view in real time (GET/pull data)
    database.ref("/products/book").on('value', function (data) {
        // on database change, grab the books and set the scope variable
        $scope.books = data.val();
        $scope.$apply();
    });
}]);