/*
    All of our page routing, if a user hits a URL, tell them
    where we need to go and what controller to use
*/
angular.module('app').config(function ($routeProvider) {
    $routeProvider.when("/", {
        controller: "indexController",
        templateUrl: "views/indexView.html"
    })
    .when("main.html", {
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
    .when("/textbooks", {
        controller: "textbookController",
        templateUrl: "views/textbookView.html"
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