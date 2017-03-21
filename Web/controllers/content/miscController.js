/*
 Controller for providing data to the textbookView
 */
app.controller('miscController', function($scope, $routeParams, $location, itemService, miscs, userItems){
    // setup our items service with a database URL, item name, and item array
    // books variable resolved on the route, resolved variables are only available
    // in the controller, so we need to update our singleton service by passing books array
    itemService.setup('/products/misc/', 'misc', miscs);

    // default editing to false, show edit form when we have a valid bookID
    $scope.editing = false;

    // yank in our URL parameter
    var miscID = $routeParams.miscID;

    // grab our book from bookService, we are making asynchronous calls, but since
    // the books variable is a dependency, this wont run until books array is loaded
    $scope.furniture = itemService.get(miscID);

    // all of our error checking goes here
    var validate = function(misc){
        // begin checking for errors
        if(!misc.name){
            $scope.error = "Please enter a name for this Item.";
        }else if(!misc.category){
            $scope.error = "Please Enter a Category For this Item.";
        }else if(!misc.price){
            $scope.error = "Please enter a price for the item.";
        }else{
            $scope.error = null;
        }// end error checking
    };

    // function call to update the database upon form submission (POST/push data)
    var setMisc = function(misc) {
        validate(misc);
        if(!$scope.error){
            // we dont have an error
            itemService.set(misc, miscID);
            $location.path('/miscs');
        }// end if we dont have an error
    };

    var addMisc = function(misc){
        validate(misc);
        if(!$scope.error){
            // we dont have an error
            itemService.add(misc);
            $location.path('/miscs');
        }// end if we dont have an error
    };

    $scope.deleteMisc = function(miscID){
        itemService.remove(miscID);
    };

    if(miscID == 'add'){
        // we are trying to add a new book
        $scope.title = 'Sell Item';
        $scope.editing = true;
        // false because we are on the 'add' form
        $scope.edit_form = false;
        $scope.book = {};
        $scope.update = addMisc;
    }else if($scope.misc){
        // we have a valid bookID in URL, show the edit form
        $scope.title = 'Edit Item';
        // pull in Firebase storage image reference
        var imageRef = itemService.getImageRef(miscID);

        imageRef.getDownloadURL().then(function(url) {
            $scope.image_url = url;
            $scope.$apply();
        });

        $scope.editing = true;
        // true if we are on the 'edit' form
        $scope.edit_form = true;
        $scope.update = setMisc;
    }else{
        // we are just showing the list of books
        angular.forEach(miscs, function(misc) {
            if(userItems.$getRecord(misc.$id) !== null){
                misc.allow_edit = true;
            }// end if the user can edit this book
        });

        $scope.miscs = miscs;
    }// end if bookID == add
});