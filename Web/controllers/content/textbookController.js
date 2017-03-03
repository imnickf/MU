/*
     Controller for providing data to the textbookView
 */
app.controller('textbookController', ['$scope', 'bookService', function($scope, bookService){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();
    $scope.data = "Textbook View";

    // pull in the books
    $scope.books = bookService.getBooks();
}]);


