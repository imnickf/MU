/**
 * Created by Pine-Pro on 3/2/2017.
 */
angular.module('app').controller('adminController', ['$scope', '$firebaseObject', function($scope, $firebaseObject){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    $scope.data = "Admin View";
}]);
