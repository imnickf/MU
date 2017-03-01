//
//  MiscTableViewCell.swift
//  MU
//
//  Created by Nick Flege on 2/28/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class MiscTableViewCell: UITableViewCell
{
  var misc: Misc!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
  }

  func configureWith(misc: Misc)
  {
    self.misc = misc
    nameLabel.text = misc.name
    priceLabel.text = misc.price
  }
}
