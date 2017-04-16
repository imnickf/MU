//
//  ViewItemsProfileTableViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/21/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class ViewItemsProfileTableViewController: UITableViewController {

  let itemRepo = ItemRepository()
  let userRepo = UserRespository()
  var userItems = [Item]()
  var fetchType: ItemFetchType = .posted
  var selItem: Item? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let userId: String = userRepo.getCurrentUserID()
    itemRepo.getItems(forUserId: userId, fetchType: fetchType) { (items) in
      self.userItems = items
    
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    
    if fetchType != .posted {
      self.tableView.allowsSelection = false
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
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if fetchType == .posted {
      let type: String = userItems[indexPath.row].id.components(separatedBy: "-")[0]
    
      switch type {
      case "food":
        selItem = userItems[indexPath.row]
        performSegue(withIdentifier: "editFood", sender: self)
      case "ticket":
        selItem = userItems[indexPath.row]
        performSegue(withIdentifier: "editTicket", sender: self)
      case "book":
        selItem = userItems[indexPath.row]
        performSegue(withIdentifier: "editBook", sender: self)
      case "misc":
        selItem = userItems[indexPath.row]
        performSegue(withIdentifier: "editMisc", sender: self)
      default:
        return
      }
    }
  }
}


// MARK: - Navigation

extension ViewItemsProfileTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "editFood" {
        if let vc = segue.destination as? CreateFoodTableViewController {
          vc.food = selItem as? Food
          vc.shouldEdit = true
        }
      }
      
      if segue.identifier == "editTicket" {
        if let vc = segue.destination as? CreateTicketTableViewController {
          vc.ticket = selItem as? Ticket
          vc.shouldEdit = true
        }
      }
      
      if segue.identifier == "editBook" {
        if let vc = segue.destination as? CreateBookTableViewController {
          vc.book = selItem as? Book
          vc.shouldEdit = true
        }
      }
      
      if segue.identifier == "editMisc" {
        if let vc = segue.destination as? CreateMiscTableViewController {
          vc.misc = selItem as? Misc
          vc.shouldEdit = true
        }
      }
    }
  
}
