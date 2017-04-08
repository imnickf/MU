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
  @IBOutlet weak var messageInputView: UIView!

  @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
  
  let chatRepo = ChatRepository()
  var receiverID: String!
  var chat: Chat?
  var messages = [Message]()

  override func viewDidLoad()
  {
    super.viewDidLoad()

    chatRepo.getChat(withUserID: receiverID) { (chat) in
      self.chat = chat
      self.messages = chat.messages.sorted(by: { $0.date < $1.date })
      self.messagesTableView.reloadData()
    }

    hideKeyboardWhenTappedAround()
    NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }

  @IBAction func sendMessage()
  {
    if let message = messageTextField.text {
      chat?.send(message: message)
      messageTextField.text = nil
    }
  }

  func keyboardWillShow(notification: NSNotification)
  {
    let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double

    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      UIView.animate(withDuration: duration) { () -> Void in
        self.messageViewBottomConstraint.constant = (keyboardSize.height - (self.tabBarController?.tabBar.frame.size.height)!)
        self.view.layoutIfNeeded()
      }
    }
  }

  func keyboardWillHide(notification: NSNotification)
  {
    let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double

    UIView.animate(withDuration: duration) { () -> Void in
      self.messageViewBottomConstraint.constant = 0
      self.view.layoutIfNeeded()
    }
  }
}

// MARK: - UITableViewDataSource Protocol Methods

extension ChatViewController: UITableViewDataSource
{
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return messages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    var cell: UITableViewCell

    let message = messages[indexPath.row]
    if message.senderID == receiverID {
      cell = tableView.dequeueReusableCell(withIdentifier: "inMessageCell", for: indexPath)
      (cell as? InMessageTableViewCell)?.messageLabel.text = message.content
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "outMessageCell", for: indexPath)
      (cell as? OutMessageTableViewCell)?.messageLabel.text = message.content
    }

    return cell
  }
}

// MARK: - UITableViewDelegate Protocol Methods

extension ChatViewController: UITableViewDelegate
{

}
