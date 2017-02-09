(function () {
	// initialize our firebase settings
    var config = {
        apiKey: "AIzaSyB3bDwdIesJJqq8LUY06d_BS6RkGWjyarE",
        authDomain: "com-s-309-project.firebaseapp.com",
        databaseURL: "https://com-s-309-project.firebaseio.com",
        storageBucket: "com-s-309-project.appspot.com",
        messagingSenderId: "788794802091"
    };
    firebase.initializeApp(config);

	// define our angular app, our dependencies are ngRoute, firebase, and ui.bootstrap
    angular.module('app', ['ngRoute', 'firebase', 'ui.bootstrap'])
		// configure routing so when user doesnt hit an actual page, we send them to the indexView  
        .config(function ($routeProvider) {
            $routeProvider.when("/", {
                controller: "indexController",
                templateUrl: "views/indexView.html"
            });
            $routeProvider.otherwise({
                redirectTo: "/"
            })
        })
		// the main control for handling our view data and creating listener events
        .controller('indexController', function ($scope, $firebaseObject) {
			// grab the firebase database object
	  	    const database = firebase.database();

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
        	  firebase.database().ref('products/food/1').set({
				category: $scope.category,
				location: $scope.location,
				name: $scope.name,
				price: $scope.price
  			});
      	  };
     })
	  // function for capitalizing first letter of a word
	 .filter('capitalize', function() {
		return function(input) {
			return (!!input) ? input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() : '';
		}
    }); 
})();
