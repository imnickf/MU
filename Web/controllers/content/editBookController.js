/*
   Controller for providing data to the editBookView
*/
angular.module('app').controller('editBookController', ['$scope', '$firebaseObject', '$routeParams', '$location',
    function($scope, $firebaseObject, $routeParams, $location){
    // grab the firebase database object
    const database = firebase.database();

    // yank in our URL parameter
    $scope.bookID = $routeParams.bookID;

    // listen for database changes and update our view in real time (GET/pull data)
    database.ref("/products/book/" + $scope.bookID).on('value', function (data) {
        // on database change, grab the books and set the scope variable
        $scope.book = data.val();

        if($scope.book === null){
            // redirect to main page if we dont have a valid book
            $location.path('/main');
        }// end if book is null

        $scope.$apply();
    });

    // function call to update the database upon form submission (POST/push data)
    $scope.update_database = function() {
        database.ref('products/book/' + $scope.bookID).set({
            name: $scope.book.name,
            classCode: $scope.book.classCode,
            author: $scope.book.author,
            price: $scope.book.price
        });
        $location.path('/main');
    };
}]);