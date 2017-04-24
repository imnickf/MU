/**
 * Created by joe kuczek on 3/2/2017.
 */

app.factory('chatService', function chatService() {
    // service for providing functions to the chatController
    var storedChatNums = [];
    var userList = [];
    var chatCount = 0;
    var sender; // the auth sender
    var users; // Firebase array of users
    var scope; // the chatController's scope variable

    return {
        send: function(receiver, message){
            // POST a message to the server from <sender> to <receiver>
            var receiverChatIDs;
            var senderChatIDs;
            var chat_key;
            var messageRef = firebase.database().ref('/messages/');

            var receiverID = receiver.$id;
            var senderID = sender.$id;

            if(receiver.chats != null){
                // we have a list of chats for each user, convert c.s to array
                receiverChatIDs = receiver.chats;
            }else{
                receiverChatIDs = [];
            }// end if we have chats for this user

            if(sender.chats != null){
                // we have a list of chats for each user, convert c.s to array
                senderChatIDs = sender.chats;
            }else{
                senderChatIDs = [];
            }// end if we have chats for this user

            if (senderID in receiverChatIDs){
                // both users have a similar chat id, this means a chat was already created
                chat_key = receiverChatIDs[senderID];
            }else{
                // users have different chat ids, push a new chat id for both users
                chat_key = messageRef.push().key;
                // add the new chat id to each user's list of chat ids
                receiverChatIDs[senderID] = chat_key;
                senderChatIDs[receiverID] = chat_key;
            }// end if chat id has been created

            // get a new message key for this message
            messageRef = firebase.database().ref('/messages/' + chat_key);
            var message_key = messageRef.push().key;

            var updates = {};
            var messageObject = ({
                message: message,
                senderID: senderID,
                date: new Date().toJSON()
            });

            // perform all our Firebase updates
            updates['/messages/' + chat_key + "/" + message_key] = messageObject;
            updates['/users/' + senderID + '/chats/' + receiverID] = chat_key;
            updates['/users/' + receiverID + '/chats/' + senderID] = chat_key;

            firebase.database().ref().update(updates);
        },
        updateChatWidth: function(type, user, $event){
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

                angular.forEach(userList, function (u, id) {
                    // loop over all users
                    if (user.chatNum < userList[id].chatNum){
                        userList[id].chatNum--;
                        storedChatNums[userList[id].chatIndex] = userList[id].chatNum;
                    }// end if current user Chat less than some user chat

                });// end for each loop over all users

                storedChatNums[user.chatIndex] = 0;
                user.chatNum = 0;
                user.hide_message = true;
            }// end if adding a new chat

            angular.forEach(userList, function (u, id) {
                // for each loop over users updating chat widths
                u.chatNum = storedChatNums[id];

                if (chatCount == 1) {
                    userList[id].chatWidth = 300 * u.chatNum;
                } else {
                    userList[id].chatWidth = 280 * u.chatNum;
                }// end if first chat opened

            });// end for each loop over all users

            scope.userList = userList;
            scope.$evalAsync();
        },
        updateDisplayMessages: function(messages){
            // function for updating messages in the view
            if(sender.chats != null){
                // we have chats for the auth user
                angular.forEach(sender.chats, function (chatID, receiverID) {
                    // for each loop over chats

                    if(chatID in messages){
                        var messageObj = messages[chatID];
                        var index = users.$indexFor(receiverID);
                        userList[index].displayMessages = [];

                        angular.forEach(messageObj, function (message) {
                            // for loop over messages

                            if(message.senderID == sender.$id){
                                message.class = 'msg_a';
                            }else{
                                message.class = 'msg_b';
                            }// end if apply different classes to these messages

                            userList[index].displayMessages.push(message);
                        });

                    }// end if this user is involved in a chat

                }); // end for loop over all the user chats

            }// end if the auth user is involved in any chats
        },
        initUsers: function(users){
            // initialize the users in the scope
            var that = this;
            angular.forEach(users, function (user, id) {
                // for each loop over all users setting up chats
                if (userList[id] == null) {
                    // setup constructor chat variables
                    user.hide_message = true;
                    user.chatWidth = 0;
                    user.chatNum = 0;

                    // push a blank placeholder onto input array
                    scope.inputMessages.push("");
                    storedChatNums.push(user.chatNum);
                }// end if we are creating a new chat window

                if (user.$id == sender.$id) {
                    user.displayInList = false;
                } else {
                    user.displayInList = true;
                }// end if we should display this user in the chat list

                user.id = user.$id;
                user.chatIndex = id;
                user.displayMessages = [];
                userList[id] = user;

                that.updateChatWidth(null, user, null);
            });
        },
        openChat: function(userID){
            var user = users.$getRecord(userID);
            user.hide_message = false;
            this.updateChatWidth('add', user);
        },
        getUserList: function(){
            return userList;
        },// function setup(...),
        setup: function(authSender, chatScope, scopeUsers){
            sender = authSender;
            scope = chatScope;
            users = scopeUsers;
        }// end function getUser()

    };
});