/*
    Controller for providing data to the profileView
 */
app.controller('profileController', function($scope, $firebaseObject, authService, userInfo, userService, userItems, completedItems, itemService){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    //userInfo grabs all info of current user logged in.
    userService.setup(userInfo);
    itemService.userItemSetup(userItems);

    //flag for editing one profile.
    $scope.editing = false;

    //Grabs user information from AuthServices.js
    authService.promise.then(function() {
        var user = authService.getUser();
        $scope.userEmail = user.email;
        console.log(userInfo);
        $scope.userName = userInfo.displayName;
        $scope.userBio = userInfo.bio;
        $scope.items = userItems;
        $scope.completedItems = completedItems;
    });

    $scope.saveProfileData = function(){
      userInfo.bio = $scope.userBio;
        userService.set(userInfo);
        $scope.editing = false;
    };

    $scope.soldTicket = function(item) {
        // we dont have an error
        var updates = {};
        itemService.userItemremove(item);
        var itemId = item.$id;
        delete item['$id'];
        delete item['$priority'];
        delete item['$$hashKey'];
        updates['/users/' + userInfo.$id + '/soldItems/' + itemId] = item;
        database.ref().update(updates);
    };
});