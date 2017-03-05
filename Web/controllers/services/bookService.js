/**
 * Created by joeku on 3/3/2017.
 * This is a service for performing operations on
 * book objects from Firebase.
 */
app.factory('bookService', ['$firebaseArray', '$firebaseObject', 'authService', function bookService($firebaseArray, $firebaseObject, authService) {
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
            // perform updates using an arary, note this will be helpful when we begin updating
            // the users table, we can add on keys to the updates array
            var updates = {};

            // delete extra shit that comes with $firebaseArray
            delete book['$id'];
            delete book['$priority'];

            // update the book at bookID with the scope information
            updates[url + bookID] = book;
            database.ref().update(updates);
        },
        add: function(book){
            // Generate a reference to a new location and add some data using push()
            var key = 'book' + ref.push().key;

            // apply additional fields when adding a book
            book.createDate = new Date().toJSON();
            book.viewCount = 0;
            book.creatorID = authService.getUser().uid;

            // call the update function with the newly generated bookID
            this.set(book, key);
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