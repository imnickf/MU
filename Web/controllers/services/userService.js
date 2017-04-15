/**
 * Created by Pine-Pro on 4/13/2017.
 */


app.factory('userService', function userService($firebaseArray, $firebaseObject, authService) {

    var userName;
    var userBio;
    var userEmail;

    return{

        setup: function (userInfo) {
            userName = userInfo.displayName;
            userEmail = userInfo.email;
            userBio = userInfo.bio;
        }
    };


});