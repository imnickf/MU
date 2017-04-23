//
//  FoodDetailViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/13/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

  @IBOutlet weak var TitleLabel: UILabel!
  @IBOutlet weak var FoodCatLabel: UILabel!
  @IBOutlet weak var DescriptionTextView: UITextView!
  @IBOutlet weak var actionButton: UIButton!

  /// Food item for detail view
  var food: Food!

  /// Item Repository for interacting with item objects
  let itemRepo = ItemRepository()

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool)
  {
    TitleLabel.text = food?.name
    FoodCatLabel.text = food?.category
    DescriptionTextView.text = food?.description
    actionButton.isHidden = false

    if UserRespository().getCurrentUserID() == food.creatorID {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
      actionButton.setTitle("Close Food Event", for: .normal)
    } else if UserDefaults.standard.integer(forKey: "userType") > 1 {
      actionButton.setTitle("Message Creator", for: .normal)
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    } else {
      actionButton.setTitle("Message Creator", for: .normal)
      navigationItem.rightBarButtonItem = nil
    }
  }

  @objc fileprivate func editItem()
  {
    performSegue(withIdentifier: "editFood", sender: self)
  }

  @IBAction func messageSeller(_ sender: Any)
  {
    if UserRespository().getCurrentUserID() == food!.creatorID {
      itemRepo.markItemSold(food)
    } else {
      performSegue(withIdentifier: "showChat", sender: self)
    }
  }
}

// MARK: - Navigation

extension FoodDetailViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "editFood" {
      if let vc = segue.destination as? CreateFoodTableViewController {
        vc.food = food
        vc.shouldEdit = true
      }
    } else if segue.identifier == "showChat" {
      if let vc = segue.destination as? ChatViewController {
        vc.receiverID = food.creatorID
      }
    }
  }
}
