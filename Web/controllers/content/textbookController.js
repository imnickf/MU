/*
     Controller for providing data to the textbookView
 */
app.controller('textbookController', ['$scope', '$routeParams', '$location', 'bookService', 'books', function($scope, $routeParams, $location, bookService, books){
    // books variable resolved on the route, resolved variables are only available
    // in the controller, so we need to update our singleton service
    bookService.updateBooks(books);

    // default editing to false, show edit form when we have a valid bookID
    $scope.editing = false;

    // yank in our URL parameter
    var bookID = $routeParams.bookID;

    // grab our book from bookService, we are making asynchronous calls, but since
    // the books variable is a dependency, this wont run until books array is loaded
    $scope.book = bookService.get(bookID);

    // all of our error checking goes here
    var validate = function(book){
        // begin checking for errors
        if(!book.name){
            $scope.error = "Please enter a book name.";
        }else if(!book.author){
            $scope.error = "Please enter an author.";
        }else if(!book.price){
            $scope.error = "Please enter a price.";
        }else{
            $scope.error = null;
        }// end error checking
    };

    // function call to update the database upon form submission (POST/push data)
    var setBook = function(book) {
        validate(book);
        if(!$scope.error){
            // we dont have an error
            bookService.set(book, bookID);
            $location.path('/textbooks');
        }// end if we dont have an error
    };

    var addBook = function(book){
        validate(book);
        if(!$scope.error){
            // we dont have an error
            bookService.add(book);
            $location.path('/textbooks');
        }// end if we dont have an error
    };

    $scope.deleteBook = function(bookID){
        bookService.remove(bookID);
    };

    if(bookID == 'add'){
        // we are trying to add a new book
        $scope.title = 'Add Book';
        $scope.editing = true;
        $scope.book = {};
        $scope.update = addBook;
    }else if($scope.book){
        // we have a valid bookID in URL, show the edit form
        $scope.title = 'Edit Book';
        $scope.editing = true;
        $scope.update = setBook;
    }else{
        // we have nothing, just pull in the list of books
        $scope.books = bookService.all();
    }// end if bookID == add
}]);


