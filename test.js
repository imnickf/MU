var http = require("http");
var connect = require("connect");
var fs = require("fs");

var app = connect();


app.use("/bla", printMsg);
app.use("/text", printText);

http.createServer(app).listen(8800);

function printMsg(request, response) {
    console.log("Printing Msg!");
    response.writeHead(200, {'Content-Type': 'text/html'});
    fs.createReadStream("./index.html").pipe(response);

}

function printText(request, response) {
    console.log("Printing Text!");
    response.writeHead(200, {'Content-Type': 'text/plain'});
    response.write("CatDog");
    response.end();
}
/*function (request, response) {

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
console.log('Server running at http://127.0.0.1:8000/');