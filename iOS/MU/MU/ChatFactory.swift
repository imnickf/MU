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

  init() {
    userRepo = UserRespository()
  }

  /// Makes a chat from raw data usually supplied from the database
  /// - Parameter fromData: data used to create the chat
  /// - Parameter withReceiverID: user ID of the receiver for the chat
  /// - Returns: the created chat
  func makeChat(fromData data: [String : Any], withReceiverID id: String) -> Chat
  {
    let chat = Chat(receiverID: id, senderID: userRepo.getCurrentUserID())

    // TODO: Create message objects and store in chat

    return chat
  }

  /// Makes a new chat without any messages attached
  /// - Parameter withReceiverID: user ID of the receiver of the chat
  /// - Returns: the created chat
  func createNewChat(withReceiverID id: String) -> Chat
  {
    return Chat(receiverID: id, senderID: userRepo.getCurrentUserID())
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
    // TODO
  }
}
