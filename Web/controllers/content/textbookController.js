/*
     Controller for providing data to the textbookView
 */
app.controller('textbookController', ['$scope', '$routeParams', '$location', 'bookService', function($scope, $routeParams, $location, bookService){
    // default editing to false, show edit form when we have a valid bookID
    $scope.editing = false;
    // yank in our URL parameter
    var bookID = $routeParams.bookID;
    // grab our book data array from bookService
    $scope.book = bookService.get(bookID);

    // all of our error checking goes here
    var validate = function(book){
        // begin checking for errors
        if(!book.name){
            $scope.error = "Please enter a book name.";
        }else if(!book.classCode){
            $scope.error = "Please enter a class code.";
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

    if(bookID == 'add'){
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
        // pull in the books for list display
        $scope.books = bookService.all();
    }// end if bookID == add

}]);


