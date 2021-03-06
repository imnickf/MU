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

  /// Ticket item used for ticket detail view
  var ticket: Ticket!

  /// Item Repository for interacting with item objects
  let itemRepo = ItemRepository()

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
    actionButton.isHidden = false

    if UserRespository().getCurrentUserID() == ticket.creatorID {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
      actionButton.setTitle("Mark Ticket Sold", for: .normal)
    } else if UserDefaults.standard.integer(forKey: "userType") > 1 { // If the user is a mod, they can edit
      actionButton.setTitle("Message Seller", for: .normal)
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    } else {
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
    if UserRespository().getCurrentUserID() == ticket.creatorID {
      itemRepo.markItemSold(ticket)
    } else {
      performSegue(withIdentifier: "showChat", sender: self)
    }
  }
}

// MARK: - Navigation

extension TicketDetailViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "editTicket" {
      if let vc = segue.destination as? CreateTicketTableViewController {
        vc.shouldEdit = true
        vc.ticket = ticket
      }
    } else if segue.identifier == "showChat" {
      if let vc = segue.destination as? ChatViewController {
        vc.receiverID = ticket.creatorID

      }
    }
  }
}
