//
//  FoodDetailViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 2/24/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

    @IBOutlet weak var ItemTitleText: UINavigationItem!
    @IBOutlet weak var ItemNameText: UILabel!
    @IBOutlet weak var DesText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DesText.isEditable = false
        
        if (foodSel != nil) {
            self.ItemTitleText.title = foodSel!.name
            self.ItemNameText.text = "\(foodSel!.name) - \(foodSel!.location)"
            self.DesText.text = foodSel!.description
        }
        
    }
}
