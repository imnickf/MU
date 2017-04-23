//
//  FoodTableViewCell.swift
//  MU
//
//  Created by Brennen Ferguson on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit
/// A class used to manage the Food Table View.
class FoodTableViewCell: UITableViewCell
{  
  /// A Food Object used to store the created Food.
  var food: Food!
  
  /// A link to the "Food" label.
  @IBOutlet weak var FoodText: UILabel!
  
  /// A function that initalizes a Book for
  /// this Table View Cell.
  func configureWith(food: Food) {
    self.food = food
    FoodText.text = food.name
  }
}
