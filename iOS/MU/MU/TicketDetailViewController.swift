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
  
  @IBOutlet weak var actionButton: UIButton!

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

    if ItemRepository().getUserID() == ticket.creatorID {
      actionButton.isHidden = true
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    } else {
      actionButton.isHidden = false
      actionButton.setTitle("Message Seller", for: .normal)
      navigationItem.rightBarButtonItem = nil
    }
  }

  @objc fileprivate func editItem()
  {
    performSegue(withIdentifier: "editTicket", sender: self)
  }

  @IBAction func actionButtonPressed(_ sender: UIButton)
  {

  }
}

// MARK: - Navigation

extension TicketDetailViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "editTicket" {
      if let vc = segue.destination as? CreateTicketTableViewController {
        
      }
    }
  }
}
