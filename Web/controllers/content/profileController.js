/*
    Controller for providing data to the profileView
 */
app.controller('profileController', function($scope, $firebaseObject, authService, userInfo, userService){
    // uncomment the line below to connect to firebase
    // const database = firebase.database();

    userService.setup(userInfo);

    //Grabs user information from AuthServices.js
    authService.promise.then(function() {
       // console.log(authService.getUser());

        var user = authService.getUser();


        console.log(user);
        console.log(user.bio);
        console.log(userInfo);

        $scope.userName = user.displayName;

        $scope.userEmail = user.email;


    });


    //flag for editing one profile.
    $scope.editing = false;



});