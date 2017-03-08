/*
    Angular Filters for modifying and formatting data in
    different ways
*/
app.filter('capitalize', function() {
    return function(input) {
        return (!!input) ? input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() : '';
    }
}).filter('emailToNetID', function() {
    return function(input) {
        return (!!input) ? input.substr(0, input.indexOf('@')) : '';
    }
});