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

  init(id: String, receiverID: String, senderID: String)
  {
    self.id = id
    self.receiverID = receiverID
    self.senderID = senderID
    self.messages = []
  }

  func store(messages: [Message])
  {
    self.messages = messages
  }
}

class Message
{
  var senderID: String
  var content: String

  init(senderID: String, content: String)
  {
    self.senderID = senderID
    self.content = content
  }
}
