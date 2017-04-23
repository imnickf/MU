app.controller('chatController', function($scope, authService, $firebaseArray, chatService){
    authService.setup($scope);
    $scope.userList = [];
    $scope.inputMessages = [];
    $scope.displayMessages = {};
    var messagesRef = firebase.database().ref('/messages/');

    // number of chats currently open
    var chatCount = 0;
    var sender;
    var storedChatNums = [];
    var receiver;

    $scope.auth.$onAuthStateChanged(function (user) {
        // listener function, called every time authentication state changes
        if (user ) {
            /*&& user.email.includes("@iastate.edu")*/
            // user is logged in using an @iastate.edu account
            $scope.hide_chat = false;
        } else {
            $scope.hide_chat = true;
        }// end if we have a valid user

    }); // end on auth state change function

    var userRef = firebase.database().ref('/users/');
    var users = $firebaseArray(userRef);

    // to take an action after the data loads, use the $loaded() promise
    users.$loaded().then(function () {

        authService.promise.then(function() {
            sender = users.$getRecord(authService.getUser().uid);
            // update the users scope variables
            updateUsers(users);
        }); // end authService promise function()

        messagesRef.on('value', function(snapshot) {
            var messages = snapshot.val();
            var counter = 0;
            // messages listener
            authService.promise.then(function() {
                sender = users.$getRecord(authService.getUser().uid);
                // update the users scope variables
                updateUsers(users);

                if(sender.chats != null){

                    angular.forEach(sender.chats, function (chatID, receiverID) {
                        // for each loop over chats
                        receiver = users.$getRecord(receiverID);

                        if(storedChatNums[receiver.chatIndex] == null){
                            storedChatNums[receiver.chatIndex] = counter;
                            counter++;
                        }// end if we need to create a new stored chat for receiving a message

                        if(chatID in messages){
                            var messageObj = messages[chatID];
                            var index = users.$indexFor(receiverID);
                            $scope.userList[index].displayMessages = [];

                            angular.forEach(messageObj, function (message) {

                                if(message.senderID == sender.$id){
                                    message.class = 'msg_a';
                                }else{
                                    message.class = 'msg_b';
                                }// end if apply different classes to these messages

                                $scope.userList[index].displayMessages.push(message);
                            });

                        }// end if this user is involved in a chat

                    }); // end for loop over all the user chats

                }// end if the auth user is involved in any chats

            }); // end authService promise function()
           $scope.updateChatWidth();
        }); // end messages on value change listener

    }); // end users data loaded function

    userRef.on('value', function(snapshot) {
        updateUsers(users);
    });

    var updateUsers = function(users){
        // users data is loaded
        angular.forEach(users, function (user, id) {
            // for each loop over all users setting up chats
            if ($scope.userList[id] == null) {
                // setup constructor chat variables
                user.hide_message = true;
                user.chatWidth = 0;
                user.chatNum = 0;

                // push a blank placeholder onto input array
                $scope.inputMessages.push("");
                storedChatNums.push(user.chatNum);
            }// end if we are creating a new chat window

            if(user.$id == sender.$id){
                user.displayInList = false;
            }else{
                user.displayInList = true;
            }// end if we should display this user in the chat list

            user.id = user.$id;
            user.chatIndex = id;
            user.displayMessages = [];

            $scope.updateChatWidth(null, user);
            $scope.userList[id] = user;
        }); // end for loop over all users data

    }// end updateUsers function(...)

    $scope.updateChatWidth = function(type, user, $event){
        console.log(storedChatNums);
        // update the chat widths for all users
        if($event){
            $event.stopPropagation();
        }// end if we have an event to stop

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
        $scope.$evalAsync();
    }; // end function updateChatWidth(...)

    $scope.send = function($event, receiver) {
        // send a message by posting to firebase
        // only do something if the input key is "Enter"
        if($event.code == 'Enter' && $scope.inputMessages[receiver.chatIndex] != ''){
            // prevent the enter key from creating a new line in the textarea
            event.preventDefault();
            // setup our users with default 'constructor' variables
            updateUsers($scope.userList);
            // get the message from the DOM
            var message = $scope.inputMessages[receiver.chatIndex];

            // send the message
            chatService.send(sender, receiver, message);

            // clear the message box
            $scope.inputMessages[receiver.chatIndex] = "";

            // update the chat width for this receiver (fixes weird bug)
            $scope.updateChatWidth(null, receiver, $event);
        }// end if they pressed enter
    };

    $scope.slideToggle = function(key){
        $("#" + key + '_wrap').toggle();
    };
});