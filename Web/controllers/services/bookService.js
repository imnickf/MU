/**
 * Created by joeku on 3/3/2017.
 * This is a service for performing operations on
 * book objects from Firebase.
 */
app.factory('bookService', ['$firebaseArray', '$firebaseObject', function bookService($firebaseArray, $firebaseObject) {
    // pull in firebase object
    var database = firebase.database();
    var url = '/products/book/';
    var ref = database.ref(url);
    var books;

    // listen for database changes, update books object
    ref.on('value', function (data) {
        books = data.val();
    });

    return {
        all: function() {
            // return an array of all our books at /products/book
            return books;
        },
        get: function(bookID) {
            // return an array of a single book with bookID
            return books[bookID];
        },
        set: function(scope, bookID) {
            // update the book at bookID with the scope information
            database.ref(url + bookID).set({
                name: scope.book.name,
                classCode: scope.book.classCode,
                author: scope.book.author,
                price: scope.book.price
            });
        },
        getRef: function(){
            return ref;
        }
    };
}]);