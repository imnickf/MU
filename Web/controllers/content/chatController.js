app.controller('chatController', function($scope, authService, $firebaseArray, chatService){
    authService.setup($scope);
    $scope.userList = [];
    $scope.inputMessages = [];
    $scope.displayMessages = {};
    var messagesRef = firebase.database().ref('/messages/');

    messagesRef.on('value', function(snapshot) {
        var messages = snapshot.val();
        console.log(messages);
    });

    // number of chats currently open
    var chatCount = 0;
    var sender;
    var storedChatNums = [];

    $scope.auth.$onAuthStateChanged(function (user) {
        // listener function, called every time authentication state changes
        if (user && user.email.includes("@iastate.edu")) {
            // user is logged in using an @iastate.edu account
            $scope.hide_chat = false;
        } else {
            $scope.hide_chat = true;
        }// end if we have a valid user

    }); // end on auth state change function

    var userRef = firebase.database().ref('/users/');
    var users = $firebaseArray(userRef);
    var chatIDs;

    // to take an action after the data loads, use the $loaded() promise
    users.$loaded().then(function () {

        authService.promise.then(function() {
            sender = users.$getRecord(authService.getUser().uid);
        }); // end authService promise function()

        updateUsers(users);
    }); // end users data loaded function

    userRef.on('value', function(snapshot) {
        updateUsers(users);
    });

    var updateUsers = function(users){
        // users data is loaded
        angular.forEach(users, function (user, id) {
            // for each loop over all users setting up chats

            if(user.chats != null){
                // we have a list of chats for each user, convert c.s to array
                chatIDs = user.chats;
            }else{
                chatIDs = [];
            }// end if we have chats for this user

            // we have a valid displayName
            if ($scope.userList[id] == null) {
                // setup constructor chat variables
                user.hide_message = true;
                user.chatWidth = 0;
                user.chatNum = 0;

                // push a blank placeholder onto input array
                $scope.inputMessages.push("");
                storedChatNums.push(user.chatNum);
            }// end if we are creating a new chat window

            user.id = user.$id;
            user.chatIndex = id;
            $scope.userList[id] = user;
        }); // end for loop over all users data

    }// end updateUsers function(...)

    $scope.updateChatWidth = function(type, user, $event){
        // update the chat widths for all users
        $event.stopPropagation();

        if (type == 'add') {
            chatCount++;
            user.chatNum = chatCount;
            storedChatNums[user.chatIndex] = user.chatNum;
            user.hide_message = false;
        } else if (type == 'sub') {
            chatCount--;

            angular.forEach($scope.userList, function (u, id) {
                // loop over all users
                if (user.chatNum < $scope.userList[id].chatNum){
                    $scope.userList[id].chatNum--;
                    storedChatNums[$scope.userList[id].chatIndex] = $scope.userList[id].chatNum;
                }// end if current user Chat less than some user chat

            });// end for each loop over all users

            storedChatNums[user.chatIndex] = 0;
            user.chatNum = 0;
            user.hide_message = true;
        }// end if adding a new chat

        angular.forEach($scope.userList, function (u, id) {
            // for each loop over users updating chat widths
            u.chatNum = storedChatNums[id];

            if (chatCount == 1) {
                $scope.userList[id].chatWidth = 300 * u.chatNum;
            } else {
                $scope.userList[id].chatWidth = 280 * u.chatNum;
            }// end if first chat opened

        });// end for each loop over all users

    }; // end function updateChatWidth(...)

    $scope.send = function($event, receiver) {
        // send a message by posting to firebase
        $event.stopPropagation();

        if($event.code == 'Enter' && $scope.inputMessages[receiver.chatIndex] != ''){
            // get the text input from the scope
            updateUsers($scope.userList);
            // get the message from the DOM
            var message = $scope.inputMessages[receiver.chatIndex];

            // send the message
            chatService.send(sender, receiver, message);

            // clear the message box
            $scope.inputMessages[receiver.chatIndex] = "";

            $scope.updateChatWidth(null, receiver, $event);
            $scope.$evalAsync();
        }// end if they pressed enter
    };

    $scope.slideToggle = function(key){
        $("#" + key + '_wrap').toggle();
    };
});