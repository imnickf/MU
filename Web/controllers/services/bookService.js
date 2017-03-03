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

    return {
        all: function() {
            // return an array of all our books at /products/book
            return books;
        },
        get: function(bookID) {
            // return an array of a single book with bookID
            return books.$getRecord(bookID);
        },
        set: function(book, bookID) {
            // update the book at bookID with the scope information
            database.ref(url + bookID).set({
                name: book.name,
                classCode: book.classCode,
                author: book.author,
                price: book.price
            });
        },
        add: function(book){
            // Generate a reference to a new location and add some data using push()
            var key = ref.push().key;
            database.ref(url + key).set({
                name: book.name,
                classCode: book.classCode,
                author: book.author,
                price: book.price
            });
        },
        remove: function(book){
            // delete the book with bookID
            books.$remove(book);
        },
        getRef: function(){
            return ref;
        },
        updateBooks: function(data){
            books = data;
        }// end service functions,
    };
}]);