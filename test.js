var express = require("express");
var path = require("path");
var router =  express.Router();
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: false });
var app = express();

var totalval = 0;

//app.set("views", __dirname + "bla");
//app.set('view engine', 'ejs');

router.get("/", function (req, res) {
           res.sendFile(__dirname + "/bla/index.html");
           res.render('./bla/index', {total: totalval});
});

app.use("/", router);
app.post("/process", urlencodedParser, function(req, res) {
            response = {
                x: req.body.x,
                y: req.body.y
            };
         
        total = +response.x + +response.y;
         console.log(response.x + " + " + response.y + " = " + total);
         
         res.app.route("/");
});

app.use(express.static("bla"));

var server = app.listen(8800);



/*function printText(request, response) {
    console.log("Printing Text!");
    response.writeHead(200, {'Content-Type': 'text/plain'});
    response.write("CatDog");
    response.end();
}
function (request, response) {

    //setTimeout(function() {
   //     console.log("Work Done!");
   // },10000);
   response.writeHead(200, {'Content-Type': 'text/html'});
   fs.createReadStream("./index.html").pipe(response);
   //response.write("Cat");

   response.writeHead(200, {'Content-Type': 'text/plain'});

   response.write("Cat");
   //response.end();
}).listen(8000);*/


//Print to server console.
console.log('Server running at http://regieferg.student.iastate.edu:8800/');
