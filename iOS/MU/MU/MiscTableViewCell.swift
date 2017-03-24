//
//  MiscTableViewCell.swift
//  MU
//
//  Created by Nick Flege on 2/28/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Misc Table View.
class MiscTableViewCell: UITableViewCell
{
  /// A Misc Object used to store the created Misc.
  var misc: Misc!
  
  /// A link to the "name" label.
  @IBOutlet weak var nameLabel: UILabel!
  
  /// A link to the "price" label.
  @IBOutlet weak var priceLabel: UILabel!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
  }

  /// A function that initalizes a Misc for
  /// this Table View Cell.
  func configureWith(misc: Misc)
  {
    self.misc = misc
    nameLabel.text = misc.name
    priceLabel.text = misc.price
  }
}
