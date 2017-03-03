/*
    All of our page routing, if a user hits a URL, tell them
    where we need to go and what controller to use
*/
app.config(function ($routeProvider) {
    $routeProvider.when("/", {
        controller: "mainController",
        templateUrl: "views/mainView.html"
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
            books: function ($firebaseArray, bookService) {
                return $firebaseArray(bookService.getRef()).$loaded();
            }
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