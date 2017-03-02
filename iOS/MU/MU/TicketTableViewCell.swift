//
//  TicketTableViewCell.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell
{
  var ticket: Ticket!

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  func configureWith(ticket: Ticket)
  {
    self.ticket = ticket
    nameLabel.text = ticket.name
    priceLabel.text = ticket.price
  }
}
