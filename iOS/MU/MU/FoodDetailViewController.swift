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
  
  var food: Food?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
  }
  
  override func viewWillAppear(_ animated: Bool) {
    TitleLabel.text = food?.name
    FoodCatLabel.text = food?.category
    DescriptionTextView.text = food?.description
  }
}
