//
//  TicketsTableViewController.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Ticket View.
class TicketsTableViewController: UITableViewController
{
  /// An Item Repository.
  let itemRepo = ItemRepository()
  
  /// An array that is used to store Tickets items.
  var tickets = [Ticket]()

  var selectedTicket: Ticket?

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    navigationController?.navigationBar.barTintColor = Theme.primaryRedColor
    navigationController?.navigationBar.tintColor = UIColor.black
    tabBarController?.tabBar.barTintColor = Theme.primaryGrayColor
    tabBarController?.tabBar.tintColor = Theme.secondaryRedColor

    itemRepo.getItems(.ticket) { (items) in
      self.tickets = items as! [Ticket]
    
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  override func viewWillAppear(_ animated: Bool)
  {
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

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    selectedTicket = tickets[indexPath.row]
    performSegue(withIdentifier: "showTicketDetail", sender: self)
  }
}

// MARK: - Navigation

extension TicketsTableViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "showTicketDetail" {
      if let vc = segue.destination as? TicketDetailViewController {
        if let ticket = selectedTicket {
          vc.ticket = ticket
        }
      }
    }
  }
}
