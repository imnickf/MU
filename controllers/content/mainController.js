/*
   Controller for providing data to the indexView
*/
angular.module('app').controller('mainController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // grab the firebase database object
    const database = firebase.database();
    //var provider = new firebase.auth.GoogleAuthProvider();

    // variables that are used for indexView buttons
    $scope.view_data = {};
    $scope.view_data.left = false;
    $scope.view_data.middle = true;
    $scope.view_data.right = false;

    // listen for database changes and update our view in real time (GET/pull data)
    database.ref("/products/food/1").on('value', function (data) {
        // push the data so we can use ng-repeat to form a list
        $scope.firebase_data = [];
        $scope.firebase_data.push(data.val());

        // save the data for the form to make the fields editable
        $scope.category = data.val().category;
        $scope.location = data.val().location;
        $scope.name = data.val().name;
        $scope.price = data.val().price;

        $scope.$apply();
    });

    // function call to update the database upon form submission (POST/push data)
    $scope.update_database = function() {
        database.ref('products/food/1').set({
            category: $scope.category,
            location: $scope.location,
            name: $scope.name,
            price: $scope.price
        });
    };
}]);