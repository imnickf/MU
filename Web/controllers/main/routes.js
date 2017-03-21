/*
    All of our page routing, if a user hits a URL, tell them
    where we need to go and what controller to use
*/
app.config(function ($routeProvider) {
    $routeProvider.when("/", {
        controller: "mainController",
        templateUrl: "views/mainView.html",
        resolve:{
            auth: function(authService){
                // we wont begin calling controller code until this promise is resolved
                return authService.promise;
            }
        }
    })
    .when("/food", {
        controller: "foodController",
        templateUrl: "views/foodView.html"
    })
    .when("/tickets", {
        controller: "ticketController",
        templateUrl: "views/ticketView.html"
    })
    .when("/textbooks/:bookID?", {
        // bookID is an optional URL parameter
        controller: "textbookController",
        templateUrl: "views/textbookView.html",
        resolve: {
            books: function ($firebaseArray) {
                var ref = firebase.database().ref('/products/book/');
                return $firebaseArray(ref).$loaded();
            },
            userItems: function($firebaseArray, authService, $q){
                // create a promise object
                var deferred = $q.defer();

                // wait for user to be authenticated
                authService.promise.then(function(){
                    // user authenticated promise resolved, return a new promise to the users items
                    var ref = firebase.database().ref('/users/' + authService.getUser().uid + '/items/');
                    var data = $firebaseArray(ref).$loaded();
                    deferred.resolve(data);
                });

                return deferred.promise;
            }// end resolved functions
        }
    })
    .when("/textbooks/detail/:bookID?", {
        controller: "textbookController",
        templateUrl: "views/textbookView.html",
        resolve: {
            books: function ($firebaseArray) {
                var ref = firebase.database().ref('/products/book/');
                return $firebaseArray(ref).$loaded();
            },
            userItems: function ($firebaseArray, authService, $q) {
                // create a promise object
                var deferred = $q.defer();

                // wait for user to be authenticated
                authService.promise.then(function () {
                    // user authenticated promise resolved, return a new promise to the users items
                    var ref = firebase.database().ref('/users/' + authService.getUser().uid + '/items/');
                    var data = $firebaseArray(ref).$loaded();
                    deferred.resolve(data);
                });

                return deferred.promise;
            }// end resolved functions
        }
    })
    .when("/furniture", {
        controller: "furnitureController",
        templateUrl: "views/furnitureView.html"
    })
    .when("/profile", {
        controller: "profileController",
        templateUrl: "views/profileView.html"
    })
    .otherwise({
        redirectTo: "/"
    });
});