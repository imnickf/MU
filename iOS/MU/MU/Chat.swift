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

  init(receiverID: String, senderID: String)
  {
    self.receiverID = receiverID
    self.senderID = senderID
    self.messages = []
  }

  func fetchMessages()
  {
    // TODO: Add value listener to fetch messages from Firebase
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
