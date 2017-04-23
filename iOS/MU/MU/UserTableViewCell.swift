//
//  UserTableViewCell.swift
//  MU
//
//  Created by Brennen Ferguson on 4/18/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

  let gateway: DatabaseGateway = DatabaseGateway()
  var user: User!
  
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userTypeSel: UISegmentedControl!

  @IBAction func editUserLevel(_ sender: Any) {
    let endpoint: String = FirebaseKeyVendor.usersKey + "/" + user.userId + "/" + FirebaseKeyVendor.userTypeKey
    gateway.persist(data: userTypeSel.selectedSegmentIndex, endpoint: endpoint)
  }

  
  func configureWith(user: User)
  {
    self.user = user
    userName.text = user.userName
    userTypeSel.selectedSegmentIndex = user.type
  }
}
