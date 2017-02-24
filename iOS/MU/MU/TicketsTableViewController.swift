//
//  TicketsTableViewController.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class TicketsTableViewController: UITableViewController
{
  let itemRepo = ItemRepository()
  var tickets = [Ticket]()

  override func viewDidLoad()
  {
    super.viewDidLoad()

    itemRepo.getItems(.ticket) { (items) in
      self.tickets = items as! [Ticket]
    
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - UITableViewDataSource Protocol Methods

extension TicketsTableViewController
{
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return tickets.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let ticket = tickets[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTableViewCell", for: indexPath) as! TicketTableViewCell
    cell.configureWith(ticket: ticket)
    return cell
  }
}

// MARK: - UITableViewDelegate Protocol Methods

extension TicketsTableViewController
{
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 50.0
  }
}

// MARK: - Navigation

extension TicketsTableViewController
{
  /*
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
}
