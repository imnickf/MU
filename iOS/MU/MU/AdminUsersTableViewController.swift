//
//  AdminUsersTableViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 4/18/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class AdminUsersTableViewController: UITableViewController
{
  var userRepo: UserRespository = UserRespository()
  var users: [User] = [User]()
  var selUser: User!

  override func viewDidLoad() {
    super.viewDidLoad()

    userRepo.getUsers { (fusers) in
      self.users = fusers

      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - Table view data source

extension AdminUsersTableViewController
{
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return users.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let user = self.users[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
    cell.configureWith(user: user)

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    selUser = users[indexPath.row]
    performSegue(withIdentifier: "adminShowUsersItems", sender: self)
  }

  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
}

// MARK: - Navigation

extension AdminUsersTableViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "adminShowUsersItems" {
      if let vc = segue.destination as? ViewItemsProfileTableViewController {
        vc.fetchType = .posted
        vc.userId = self.selUser.userId
        var userName: [String] = selUser.userName.components(separatedBy: " ")
        vc.navigationItem.title = userName[0] + "'s Items"
      }
    }
  }
}
