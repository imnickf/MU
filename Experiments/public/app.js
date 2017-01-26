(function () {
    var config = {
        apiKey: "AIzaSyB3bDwdIesJJqq8LUY06d_BS6RkGWjyarE",
        authDomain: "com-s-309-project.firebaseapp.com",
        databaseURL: "https://com-s-309-project.firebaseio.com",
        storageBucket: "com-s-309-project.appspot.com",
        messagingSenderId: "788794802091"
    };
    firebase.initializeApp(config);

    angular.module('project', ['ngRoute', 'firebase'])
        .config(function ($routeProvider) {
            $routeProvider.when("/", {
                controller: "indexController",
                templateUrl: "views/indexView.html"
            });
            $routeProvider.otherwise({
                redirectTo: "/"
            })
        })
        .controller('indexController', function ($scope, $firebaseObject) {
            const database = firebase.database();
            $scope.hello = 'Hello World!';

            database.ref("/users").on('value', function (data) {
                $scope.test = [];
                $scope.test.push(data.val());
                $scope.$apply();
            });
        });
})();