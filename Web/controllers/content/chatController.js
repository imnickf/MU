app.controller('chatController', function($scope, authService, $firebaseArray, $firebaseObject){
    $scope.userList = [];
    $scope.inputMessages = [];

    // number of chats currently open
    var chatCount = 0;

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

                    if(users[key].displayName != null && users[key].inbox != null && users[key].outbox != null){
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

                            users[key].chatLog = mergeBoxes(users[key].inbox, users[key].outbox);

                            console.log(users[key].chatLog);
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
            var outbox_url = '/users/' + senderID + '/outbox/' + receiverID;
            var outbox_key = database.ref(outbox_url).push().key;
            updates['/users/' + senderID + '/outbox/' + receiverID + '/' + outbox_key] = messageObject;

            firebase.database().ref().update(updates);
            // clear the message box
            $scope.inputMessages[key] = "";
        }// end if they pressed enter
    };

    var mergeBoxes = function(inbox, outbox){

        var chatLog = {};

        for(key in inbox){

            var userInbox = inbox[key];
            var userOutbox = outbox[key];

            chatLog = extend(userInbox, userOutbox);

            console.log(chatLog);

            console.log('a');
            console.log(userInbox);



        }// end for loop

        return 'test';
    }// end mergeBoxes function

    var extend = function extend(obj, src) {
        for (var key in src) {
            if (src.hasOwnProperty(key)) obj[key] = src[key];
        }
        return obj;
    }
});