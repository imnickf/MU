/*
     Controller for providing data to the textbookView
 */
angular.module('app').controller('textbookController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Textbook View";


    const database = firebase.database();

    // listen for database changes and update our view in real time (GET/pull data)
    database.ref("/products/book").on('value', function (data) {
        // on database change, grab the books and set the scope variable
        $scope.books = data.val();
        $scope.$apply();
    });


}]);


