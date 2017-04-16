//
//  ChatListTableViewController.swift
//  MU
//
//  Created by Nick Flege on 3/24/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class ChatListTableViewController: UITableViewController
{
  let userRepo = UserRespository()
  var chatUsers = [UserMetaData]()
  var selectedChat: UserMetaData?

  override func viewDidLoad()
  {
    super.viewDidLoad()

    userRepo.getUsersChatList { (userData) in
      self.chatUsers = userData
      self.tableView.reloadData()
    }
  }
}

// MARK: - Table view data source

extension ChatListTableViewController
{
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return chatUsers.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as! ChatListTableViewCell
    cell.displayNameLabel.text = chatUsers[indexPath.row].displayName
    return cell
  }
}

// Mark: Table view delegate

extension ChatListTableViewController
{
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    selectedChat = chatUsers[indexPath.row]
    performSegue(withIdentifier: "showChatWithUser", sender: self)
  }
}

// Mark: - Navigation

extension ChatListTableViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "showChatWithUser" {
      if let vc = segue.destination as? ChatViewController {
        if let chat = selectedChat {
          vc.receiverID = chat.userID
        }
      }
    }
  }
}
