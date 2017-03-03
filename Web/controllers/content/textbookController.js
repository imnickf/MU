/*
     Controller for providing data to the textbookView
 */
app.controller('textbookController', ['$scope', '$routeParams', '$location', 'bookService', function($scope, $routeParams, $location, bookService){
    // default editing to false, show edit form when we have a valid bookID
    $scope.editing = false;

    // pull in the books for list display
    $scope.books = bookService.all();

    // yank in our URL parameter
    var bookID = $routeParams.bookID;
    // grab our book data array from bookService
    $scope.book = bookService.get(bookID);

    if($scope.book){
        // we have a valid bookID in URL, show the edit form
        $scope.editing = true;
    }// end if book is null

    // function call to update the database upon form submission (POST/push data)
    $scope.setBook = function() {
        bookService.set($scope, bookID);
        $location.path('/textbooks');
    };
}]);


