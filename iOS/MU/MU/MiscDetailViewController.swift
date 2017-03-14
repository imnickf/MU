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
  
  /// A variable used to hold the selected Misc object.
  var misc: Misc?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    NameLabel.text = misc?.name
    CategoryLabel.text = misc?.category
    PriceLabel.text = misc?.price
    DescriptionView.text = misc?.description
  }

}
