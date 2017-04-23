//
//  BookTableViewController.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Book View.
class BookTableViewController: UITableViewController
{
  /// An Item Repository.
  let itemRepo = ItemRepository()
  
  /// An array that is used to store Book items.
  var books = [Book]()

  var selectedBook: Book?

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    navigationController?.navigationBar.barTintColor = Theme.primaryRedColor
    navigationController?.navigationBar.tintColor = UIColor.black
    tabBarController?.tabBar.barTintColor = Theme.primaryGrayColor
    tabBarController?.tabBar.tintColor = Theme.secondaryRedColor
    
    itemRepo.getItems(.book) { (items) in
      self.books = items as! [Book]
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - TableViewDataSource Protocol Methods

extension BookTableViewController
{
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return books.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let book = books[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
    cell.configureWith(book: book)
    return cell
  }
}

// MARK: TableViewDelegate Protocol Methods

extension BookTableViewController
{
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 60.0
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    selectedBook = books[indexPath.row]
    performSegue(withIdentifier: "showBookDetail", sender: self)
  }
}

// MARK: - Navigation

extension BookTableViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "showBookDetail" {
      if let vc = segue.destination as? BookDetailViewController {
        if let book = selectedBook {
          vc.book = book
          vc.navigationItem.title = book.name
        }
      }
    }
  }
}
