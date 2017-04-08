//
//  ChatViewController.swift
//  MU
//
//  Created by Nick Flege on 3/23/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController
{
  @IBOutlet weak var messagesTableView: UITableView!
  @IBOutlet weak var sendMessageButton: UIButton!
  @IBOutlet weak var messageTextField: UITextField!

  let chatRepo = ChatRepository()
  var receiverID: String!
  var chat: Chat!

  override func viewDidLoad()
  {
    super.viewDidLoad()

    chatRepo.getChat(withUserID: receiverID) { (chat) in
      self.chat = chat
      // TODO: Set source for table view
    }
  }

  @IBAction func sendMessage()
  {
    if let message = messageTextField.text {
      chat.send(message: message)
    }
  }
}

// MARK: - Navigation

extension ChatViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {

  }
}
