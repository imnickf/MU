/*
   Controller for providing data to the indexView
*/
app.controller('mainController', ['$scope', 'bookService', function($scope, bookService){
    // pull in the books
    $scope.books = bookService.getBooks();
}]);