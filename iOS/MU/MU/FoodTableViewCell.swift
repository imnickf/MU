//
//  FoodTableViewCell.swift
//  MU
//
//  Created by Brennen Ferguson on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    var food: Food!

    @IBOutlet weak var FoodText: UILabel!
    @IBOutlet weak var PriceText: UILabel!
    
    func configureWith(food: Food) {
        self.food = food
        FoodText.text = food.name
        PriceText.text = food.name
    }
}
