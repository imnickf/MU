app.controller('chatController', function($scope, authService, $firebaseArray, $firebaseObject){
    authService.setup($scope);
    $scope.userList = [];
    $scope.inputMessages = [];

    // number of chats currently open
    var chatCount = 0;

    $scope.auth.$onAuthStateChanged(function (user) {
        // listener function, called every time authentication state changes
        if (user && user.email.includes("@iastate.edu")) {
            // user is logged in using an @iastate.edu account
            $scope.hide_chat = false;
        } else {
            $scope.hide_chat = true;
        }// end if we have a valid user
    });

    authService.promise.then(function(){
        var userRef = firebase.database().ref('/users/');

        userRef.on('value', function(snapshot) {

            if($scope.userList.length == 0){
                var users = snapshot.val();
            }else{
                var users = $scope.userList;
                var newData = snapshot.val();
            }// end if userList has been defined

            for (var key in users) {

                if (users.hasOwnProperty(key)) {

                    if(users[key].displayName != null){
                        // we have a valid displayName
                        if($scope.userList[key] == null){
                            // setup constructor chat variables
                            users[key].hide_message = true;
                            users[key].chatWidth = 0;
                            users[key].chatNum = 0;
                            users[key].key = key;
                            // push a blank placeholder onto input array
                            $scope.inputMessages.push("");
                        }else{
                            // just update the inbox and outbox values
                            users[key].inbox = newData[key].inbox;
                            users[key].outbox = newData[key].outbox;

                            users[key].chatLog = mergeBoxes(users[key].inbox, users[key].outbox, key);
                        }// end if we are creating a new chat window

                    }else{
                        // if we dont have displayName we dont care
                        delete users[key];
                    }// end if we have a displayName

                }// end if we have a users object

            }// end loop over all users in database

            // update the userList with new user properties
            $scope.userList = users;

            $scope.$evalAsync();
        });
    });

    $scope.updateChatWidth = function(type, user, $event){
        // update the chat widths for all users
        $event.stopPropagation();

        if (type == 'add' && user.hide_message == true) {
            chatCount++;
            user.chatNum = chatCount;
        } else if (type == 'sub' && user.hide_message == false) {
            chatCount--;

            for(var key in $scope.userList){
                // loop over all users
                if (user.chatNum < $scope.userList[key].chatNum){
                    $scope.userList[key].chatNum--;
                }// end if current user Chat less than some user chat

            }// end for loop

            user.chatNum = 0;
        } else {
            return;
        }// end if adding a new chat

        for(var key in $scope.userList){
            // loop over all users
            if (chatCount == 1) {
                $scope.userList[key].chatWidth = 300 * $scope.userList[key].chatNum;
            } else {
                $scope.userList[key].chatWidth = 280 * $scope.userList[key].chatNum;
            }// end if first chat opened

        }// end for loop
    };

    $scope.slideToggle = function(key){
        $("#" + key + '_wrap').slideToggle();
    };

    $scope.send = function(e, user, key){
        // send a message by posting to firebase

        if(e.code == 'Enter'){
            var message = $scope.inputMessages[key];
            var receiverID = user.key;
            // pull in the sender ID from our auth service
            var senderID = authService.getUser().uid;

            var updates = {};
            var messageObject = ({
                message: message,
                date: new Date().toJSON()
            });

            // setup inbox Firebase update
            var inbox_url = '/users/' + receiverID + '/inbox/' + senderID;
            var inbox_key = database.ref(inbox_url).push().key;
            updates['/users/' + receiverID + '/inbox/' + senderID + '/' + inbox_key] = messageObject;

            // setup outbox Firebase update
            var outbox_key = database.ref(inbox_url).push().key;
            updates['/users/' + senderID + '/outbox/' + receiverID + '/' + outbox_key] = messageObject;

            firebase.database().ref().update(updates);
            // clear the message box
            $scope.inputMessages[key] = "";
        }// end if they pressed enter
    };

    var mergeBoxes = function(inbox, outbox, key){
        // merge the two chatBoxes, sorting based on date, return the combined array
        var chatLog = [];

        for(inboxUser in inbox){
            // for loop over all inboxes
            var userInbox = inbox[inboxUser];

            console.log(userInbox);

            for(outboxUser in outbox){
                // for loop over all outboxes

                if(inboxUser == outboxUser){
                    console.log(userInbox);
                    var userOutbox = outbox[outboxUser];

                    // console.log('Inbox for ' + inboxUser + ': ');
                    //console.log(userInbox);
                    //console.log('Outbox for ' + inboxUser + ': ');
                    //console.log(userOutbox);
                    var tmp_inbox = userInbox;


                    // inboxUser == outboxUser, merge the two chatboxes together
                    chatLog[inboxUser] = Object.assign(tmp_inbox, userOutbox);
                    // console.log('Chatlog for ' + inboxUser + ': ');
                    // console.log(chatLog[inboxUser]);
                }// end if inboxUser == outboxUser

            }// end for loop

        }// end for loop

        return chatLog;
    }// end mergeBoxes function
});