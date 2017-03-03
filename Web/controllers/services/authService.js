/**
 * Created by joe kuczek on 3/2/2017.
 */
app.factory('authService', ['$firebaseAuth', '$firebaseObject', function authService($firebaseAuth, $firebaseObject) {
    var auth = $firebaseAuth();

    return {
        authenticate: function(){
            // authenticate the user using google sign-in
            auth.$signInWithPopup("google").then(function(user) {
                // login successful
                return user;
            }).catch(function(error) {
                // login failed
                console.error("Authentication failed:", error);
            });
        },
        getCurrentAuth: function(){
            // return current information about the user
            return auth;
        },
        signOut: function(){
            // sign the user out of firebase
            firebase.auth().signOut();
        },
        setScope: function(scope){
            // set all our neccessary scope variables
            scope.authenticate = this.authenticate;
            scope.signOut = this.signOut;
            scope.auth = this.getCurrentAuth();
        }
    };
}]);


