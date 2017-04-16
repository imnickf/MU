//
//  ChatRepository.swift
//  MU
//
//  Created by Nick Flege on 3/24/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

/// The ChatRepository class enables you to query and persist chat data with the database.
/// The ChatRepository interfaces with DatabaseGateway to save and query raw JSON data. It interfaces
/// with ChatFactory to create chats from raw data supplied by DatabaseGateway before returning
/// it to the user in a usable Chat object.
class ChatRepository
{
  /// DatabaseGateway for connecting to database
  fileprivate var gateway: DatabaseGateway

  /// User Repository property to get user information
  fileprivate var userRepo: UserRespository

  /// Chat Factory for constructing chat objects
  fileprivate var chatFactory: ChatFactory

  init()
  {
    gateway = DatabaseGateway()
    userRepo = UserRespository()
    chatFactory = ChatFactory()
  }

  /// Get the chat with a specified user ID
  /// - Parameter withUserID: user ID of person chat is with
  /// - Parameter completion: completion handler containing the created Chat object
  func getChat(withUserID id: String, completion: @escaping (Chat) -> Void)
  {
    let userID = userRepo.getCurrentUserID()
    let path = FirebaseKeyVendor.usersKey + "/" + userID + "/" + FirebaseKeyVendor.chatsKey
    gateway.query(endpoint: path) { (data, error) in
      if error != nil {
        print(error!.localizedDescription)
      }
      if let chats = data {
        if let chatID = chats[id] as? String {
          let chatEndpoint = FirebaseKeyVendor.messagesKey + "/" + chatID
          self.gateway.query(endpoint: chatEndpoint) { (messagesData, err) in
            if err != nil {
              print(err!.localizedDescription)
            }
            if let messages = messagesData {
              let chat = self.chatFactory.makeChat(withID: chatID, fromData: messages, withReceiverID: id)
              completion(chat)
            } else {
              let chat = self.chatFactory.makeChat(withID: chatID, fromData: [String : Any](), withReceiverID: id)
              completion(chat)
            }
          }
        } else {
          let newChat = self.setupChat(withUserID: id)
          completion(newChat)
        }
      } else {
        let newChat = self.setupChat(withUserID: id)
        completion(newChat)
      }
    }
  }

  /// Persists a new Chat between two users to the database
  /// - Parameter chat: chat to be persisted
  func persistNew(chat: Chat)
  {
    let senderPath = FirebaseKeyVendor.usersKey + "/" + chat.senderID + "/" + FirebaseKeyVendor.chatsKey + "/" + chat.receiverID
    let receiverPath = FirebaseKeyVendor.usersKey + "/" + chat.receiverID + "/" + FirebaseKeyVendor.chatsKey + "/" + chat.senderID
    gateway.persist(data: chat.id, endpoint: senderPath)
    gateway.persist(data: chat.id, endpoint: receiverPath)
  }

  /// Persists a new message sent from a user
  /// - Parameter message: content of message being persisted
  /// - Parameter forChatID: id of chat message is from
  func persistNew(message: Message, forChatID id: String)
  {
    let messageID = DatabaseGateway.createNewID(FirebaseKeyVendor.messagesKey + "/" + id)
    let messagePath = FirebaseKeyVendor.messagesKey + "/" + id + "/" + messageID

    var messageData = [String : String]()
    messageData[FirebaseKeyVendor.dateKey] = message.date.iso8601
    messageData[FirebaseKeyVendor.messageKey] = message.content
    messageData[FirebaseKeyVendor.senderIdKey] = message.senderID
    gateway.persist(data: messageData, endpoint: messagePath)
  }

  /// Sets up a new chat with another user
  /// - Parameter withUserID: User ID of the person that chat is with
  fileprivate func setupChat(withUserID id: String) -> Chat
  {
    let chatID = DatabaseGateway.createNewID(FirebaseKeyVendor.messagesKey)
    let chat = chatFactory.createNewChat(withID: chatID, withReceiverID: id)
    return chat
  }
}
