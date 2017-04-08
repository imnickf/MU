//
//  Chat.swift
//  MU
//
//  Created by Nick Flege on 3/24/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

class Chat
{
  var messages: [Message]
  var receiverID: String
  var senderID: String
  var id: String
  var persisted: Bool
  var chatRepo: ChatRepository

  init(id: String, receiverID: String, senderID: String, persisted: Bool)
  {
    self.id = id
    self.receiverID = receiverID
    self.senderID = senderID
    self.persisted = persisted
    self.messages = []
    self.chatRepo = ChatRepository()
  }

  func store(messages: [Message])
  {
    self.messages = messages
  }

  func send(message: String)
  {
    if !persisted {
      chatRepo.persistNew(chat: self)
    }
    let message = Message(senderID: self.senderID, content: message)
    messages.append(message)
    chatRepo.persistNew(message: message, forChatID: self.id)
  }
}

class Message
{
  var senderID: String
  var content: String
  var date: Date

  init(senderID: String, content: String)
  {
    self.senderID = senderID
    self.content = content
    self.date = Date()
  }
}
