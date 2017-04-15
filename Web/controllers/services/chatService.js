/**
 * Created by joe kuczek on 3/2/2017.
 */

app.factory('chatService', function chatService($firebaseArray) {
    // service for providing functions to the chatController
    return {
        send: function(sender, receiver, message){
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
        }// end send() function
    };
});