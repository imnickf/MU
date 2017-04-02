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
          let chatEndpoint = FirebaseKeyVendor.chatsKey + "/" + chatID + "/" + FirebaseKeyVendor.messagesKey
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

  /// Sets up a new chat with another user
  /// - Parameter withUserID: User ID of the person that chat is with
  fileprivate func setupChat(withUserID id: String) -> Chat
  {
    // TODO: Setup new chat
  }
}
