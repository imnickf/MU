/*
 Controller for providing data to the textbookView
 */
app.controller('ticketController', function($scope, $routeParams, $location, itemService, tickets, userItems){
    // setup our items service with a database URL, item name, and item array
    // books variable resolved on the route, resolved variables are only available
    // in the controller, so we need to update our singleton service by passing books array
    itemService.setup('/products/ticket/', 'ticket', tickets);

    // default editing to false, show edit form when we have a valid bookID
    $scope.editing = false;

    // yank in our URL parameter
    var ticketID = $routeParams.ticketID;

    // grab our book from bookService, we are making asynchronous calls, but since
    // the books variable is a dependency, this wont run until books array is loaded
    $scope.ticket = itemService.get(ticketID);

    // all of our error checking goes here
    var validate = function(ticket){
        // begin checking for errors
        if(!ticket.name){
            $scope.error = "Please enter a name for this ticket.";
        }else if(!ticket.sport){
            $scope.error = "Please enter the sport this ticket is for.";
        }else if(!ticket.price){
            $scope.error = "Please enter a price for the ticket.";
        }else{
            $scope.error = null;
        }// end error checking
    };

    // function call to update the database upon form submission (POST/push data)
    var setTicket = function(ticket) {
        validate(ticket);
        if(!$scope.error){
            // we dont have an error
            itemService.set(ticket, ticketID);
            $location.path('/tickets');
        }// end if we dont have an error
    };

    var addTicket = function(ticket){
        validate(ticket);
        if(!$scope.error){
            // we dont have an error
            itemService.add(ticket);
            $location.path('/tickets');
        }// end if we dont have an error
    };

    $scope.deleteTicket = function(ticketID){
        itemService.remove(ticketID);
    };

    if(ticketID == 'add'){
        // we are trying to add a new book
        $scope.title = 'Sell Ticket';
        $scope.editing = true;
        // false because we are on the 'add' form
        $scope.edit_form = false;
        $scope.book = {};
        $scope.update = addTicket;
    }else if($scope.ticket){
        // we have a valid bookID in URL, show the edit form
        $scope.title = 'Edit Ticket';
        // pull in Firebase storage image reference
        var imageRef = itemService.getImageRef(ticketID);

        imageRef.getDownloadURL().then(function(url) {
            $scope.image_url = url;
            $scope.$apply();
        });

        $scope.editing = true;
        // true if we are on the 'edit' form
        $scope.edit_form = true;
        $scope.update = setTicket;
    }else{
        // we are just showing the list of books
        angular.forEach(tickets, function(ticket) {
            if(userItems.$getRecord(ticket.$id) !== null){
                ticket.allow_edit = true;
            }// end if the user can edit this book
        });

        $scope.tickets = tickets;
    }// end if bookID == add
});