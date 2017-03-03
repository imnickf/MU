/**
 * Created by joe kuczek on 3/2/2017.
 */

app.factory('bookService', ['$firebaseArray', function bookService($firebaseArray) {
    // pull in firebase object
    var database = firebase.database();
    var url = '/products/book';
    var ref = database.ref(url);

    return {
        getBooks: function() {
            // return an array of all our books at /products/book
            return $firebaseArray(ref);
        }// end getBooks() function
    };
}])
.factory('authService', ['$firebaseAuth', function authService($firebaseAuth) {
    return {
        authenticate: function(){
            var auth = $firebaseAuth();

            auth.$signInWithPopup("google").then(function(user) {
                return user;
            }).catch(function(error) {
                console.error("Authentication failed:", error);
            });
        },
        getCurrentUser: function(){
            return $firebaseAuth();
        }
    };
}]);


