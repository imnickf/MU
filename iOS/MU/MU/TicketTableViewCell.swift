//
//  TicketTableViewCell.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Ticket Table View.
class TicketTableViewCell: UITableViewCell
{
  /// A Ticket Object used to store the created Ticket.
  var ticket: Ticket!

  /// A link to the "name" label.
  @IBOutlet weak var nameLabel: UILabel!
  
  /// A link to the "price" label.
  @IBOutlet weak var priceLabel: UILabel!

  // A function that initalizes a Ticket for
  /// this Table View Cell.
  func configureWith(ticket: Ticket)
  {
    self.ticket = ticket
    nameLabel.text = ticket.name
    priceLabel.text = ticket.price
  }
}
