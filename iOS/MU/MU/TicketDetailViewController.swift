//
//  TicketDetailViewController.swift
//  MU
//
//  Created by Nick Flege on 3/5/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class TicketDetailViewController: UIViewController
{
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var sportLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  var ticket: Ticket!

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool)
  {
    titleLabel.text = ticket.name
    sportLabel.text = ticket.sport
    priceLabel.text = ticket.price
    descriptionTextView.text = ticket.description
  }
}
