//
//  ChatFactory.swift
//  MU
//
//  Created by Nick Flege on 4/1/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

class ChatFactory
{
  var userRepo: UserRespository

  init()
  {
    userRepo = UserRespository()
  }

  /// Makes a chat from raw data usually supplied from the database
  /// - Parameter fromData: data used to create the chat
  /// - Parameter withReceiverID: user ID of the receiver for the chat
  /// - Returns: the created chat
  func makeChat(withID id: String, fromData data: [String : Any], withReceiverID rid: String) -> Chat
  {
    let chat = Chat(id: id, receiverID: rid, senderID: userRepo.getCurrentUserID(), persisted: true)

    var messages = [Message]()
    for (_, messageData) in data {
      if let message = messageData as? [String : Any] {
        messages.append(makeMessage(fromData: message))
      }
    }
    chat.store(messages: messages)
    
    return chat
  }

  /// Makes a new chat without any messages attached
  /// - Parameter withReceiverID: user ID of the receiver of the chat
  /// - Returns: the created chat
  func createNewChat(withID id: String, withReceiverID rid: String) -> Chat
  {
    let chat = Chat(id: id, receiverID: rid, senderID: userRepo.getCurrentUserID(), persisted: false)
    return chat
  }

  /// Creates a new message object with the provided message content
  /// - Parameter content: content of the message
  /// - Returns: the created message
  func createNewMessage(withContent content: String) -> Message
  {
    let message = Message(senderID: userRepo.getCurrentUserID(), content: content)
    return message
  }

  /// Makes a message from raw data usually supplied from the database
  /// - Parameter fromData: data used to create the message
  /// - Returns: the created message
  fileprivate func makeMessage(fromData data: [String : Any]) -> Message
  {
    let content = data[FirebaseKeyVendor.messageKey] as! String
    let senderID = data[FirebaseKeyVendor.senderIdKey] as! String
    let date = data[FirebaseKeyVendor.dateKey] as! String
    let message = Message(senderID: senderID, content: content, date: date.dateFromISO8601!)
    return message
  }
}
