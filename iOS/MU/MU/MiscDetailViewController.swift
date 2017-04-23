//
//  MiscDetailViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/13/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Detail Misc View.
class MiscDetailViewController: UIViewController {

  /// The link to the "name" label.
  @IBOutlet weak var NameLabel: UILabel!
  /// The link to the "category" label.
  @IBOutlet weak var CategoryLabel: UILabel!
  /// The link to the "price" label.
  @IBOutlet weak var PriceLabel: UILabel!
  /// The link to the "description" text view.
  @IBOutlet weak var DescriptionView: UITextView!
  @IBOutlet weak var actionButton: UIButton!
  
  /// A variable used to hold the selected Misc object.
  var misc: Misc!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    NameLabel.text = misc?.name
    CategoryLabel.text = misc?.category
    PriceLabel.text = misc?.price
    DescriptionView.text = misc?.description
    
    if UserRespository().getCurrentUserID() == misc.creatorID {
      actionButton.isHidden = true
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    } else if UserDefaults.standard.integer(forKey: "userType") > 1 {
      actionButton.isHidden = false
      actionButton.setTitle("Message Seller", for: .normal)
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    } else {
      actionButton.isHidden = false
      actionButton.setTitle("Message Seller", for: .normal)
      navigationItem.rightBarButtonItem = nil
    }
  }

  @objc fileprivate func editItem()
  {
    performSegue(withIdentifier: "editMisc", sender: self)
  }
  
  @IBAction func messageSeller(_ sender: Any) {
    
  }
}

// MARK: - Navigation

extension MiscDetailViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "editMisc" {
      if let vc = segue.destination as? CreateMiscTableViewController {
        vc.misc = misc
        vc.shouldEdit = true
      }
    } else if segue.identifier == "showChat" {
      if let vc = segue.destination as? ChatViewController {
        vc.receiverID = misc?.creatorID
      }
    }
  }
}
