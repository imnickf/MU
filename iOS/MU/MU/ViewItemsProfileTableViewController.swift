//
//  ViewItemsProfileTableViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/21/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class ViewItemsProfileTableViewController: UITableViewController {

  let itemRepo: ItemRepository = ItemRepository()
  var userItems: [Item] = [Item]()
  var fetchType: ItemFetchType = .posted
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let userId: String = itemRepo.getUserID()
    itemRepo.getItems(forUserId: userId, fetchType: fetchType) { (items) in
      self.userItems = items
    
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - Table view data source

extension ViewItemsProfileTableViewController {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = userItems[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
  
    cell.configureWith(item: item)
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userItems.count
  }
}

//MARK: - TableViewDelagate

extension ViewItemsProfileTableViewController {
  
}


// MARK: - Navigation
/*
extension ViewItemsProfileTableViewController {
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
  
}*/
