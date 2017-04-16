/*
    Controller for providing data to the profileView
 */
app.controller('profileController', function($scope, $firebaseObject, authService, userInfo, userService){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    //userInfo grabs all info of current user logged in.
    userService.setup(userInfo);

    //flag for editing one profile.
    $scope.editing = false;

    var updates =


    //Grabs user information from AuthServices.js
    authService.promise.then(function() {
       // console.log(authService.getUser());

        var user = authService.getUser();
        $scope.userEmail = user.email;


        $scope.userName = userInfo.displayName;
        $scope.userBio = userInfo.bio;
        $scope.userItems = userInfo.items;



    });

        $scope.saveProfileData = function(){
          userInfo.bio = $scope.userBio;
            userService.set(userInfo);
            $scope.editing = false;
        };


});