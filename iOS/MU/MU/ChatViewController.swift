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

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }
}

// MARK: - Navigation

extension ChatViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {

  }
}
