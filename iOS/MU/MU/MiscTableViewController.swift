//
//  MiscTableViewController.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Misc View.
class MiscTableViewController: UITableViewController
{
  /// An Item Repository.
  let itemRepo = ItemRepository()
  
  /// An array that is used to store Misc items.
  var miscItems = [Misc]()

  override func viewDidLoad()
  {
    super.viewDidLoad()

    itemRepo.getItems(.miscellaneous) { (items) in
      self.miscItems = items as! [Misc]

      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - TableViewDataSource Protocol Methods

extension MiscTableViewController
{
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return miscItems.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let misc = miscItems[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "MiscTableViewCell", for: indexPath) as! MiscTableViewCell
    cell.configureWith(misc: misc)
    return cell
  }
}

// MARK: TableViewDelegate Protocol Methods

extension MiscTableViewController
{
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 50.0
  }
}

/*
 // MARK: - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

