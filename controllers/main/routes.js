/*
    All of our page routing, if a user hits a URL, tell them
    where we need to go.
*/
angular.module('app').config(function ($routeProvider) {
    $routeProvider.when("/", {
        controller: "indexController",
        templateUrl: "views/indexView.html"
    })
    .when("/index", {
        controller: "indexController",
        templateUrl: "views/indexView.html"
    })
    .when("/food", {
        controller: "foodController",
        templateUrl: "views/foodView.html"
    })
    .when("/tickets", {
        controller: "ticketController",
        templateUrl: "views/ticketView.html"
    })
    .otherwise({
        redirectTo: "/"
    });
});