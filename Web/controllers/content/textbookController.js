/*
     Controller for providing data to the textbookView
 */
app.controller('textbookController', function($scope, $routeParams, $location, itemService, books, userItems){
    // setup our items service with a database URL, item name, and item array
    // books variable resolved on the route, resolved variables are only available
    // in the controller, so we need to update our singleton service by passing books array
    itemService.setup('/products/book/', 'book', books);

    // default editing to false, show edit form when we have a valid bookID
    $scope.editing = false;

    // yank in our URL parameter
    var bookID = $routeParams.bookID;

    // grab our book from bookService, we are making asynchronous calls, but since
    // the books variable is a dependency, this wont run until books array is loaded
    $scope.book = itemService.get(bookID);

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
            itemService.set(book, bookID);
            $location.path('/textbooks');
        }// end if we dont have an error
    };

    var addBook = function(book){
        validate(book);
        if(!$scope.error){
            // we dont have an error
            itemService.add(book);
            $location.path('/textbooks');
        }// end if we dont have an error
    };

    $scope.deleteBook = function(bookID){
        itemService.remove(bookID);
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
        angular.forEach(books, function(book) {
            if(userItems.$getRecord(book.$id) !== null){
                book.allow_edit = true;
            }// end if the user can edit this book
        });

        $scope.books = books;
    }// end if bookID == add
});