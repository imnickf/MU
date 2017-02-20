//
//  BookTableViewController.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController
{
  var books = [Book]()
  let itemRepo = ItemRepository()

  override func viewDidLoad()
  {
    super.viewDidLoad()

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
    let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath)

    // Configure the cell...

    return cell
  }
}

// MARK: TableViewDelegate Protocol Methods

extension BookTableViewController
{
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 50.0
  }
}

// MARK: - Navigation

extension BookTableViewController
{
  /*
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
}
