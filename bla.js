//Callback Example
var Users = require("./Users");

var Users = {
    bla: 2,
    bla2: function() {
        setTimeout(cat,10000); //Delay for 10 sec.
    }
}

function cat() {
    console.log("Cat"); //Print out "Cat".
}

function printDog() {
    console.log("Dog"); //Print out "Dog".
}

function dog(callback) {
    callback(callback); //Runs this function then moves on.
    setTimeout(printDog,5000); //Continues onto this function, and this finishes first
}                              //because it delays for 5 sec. vs 10 sec.

//Run the functions.
cat();
dog(Users.bla2);
console.log(Users.cat);
console.log(Users.mac);