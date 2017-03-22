//
//  ItemTableViewCell.swift
//  MU
//
//  Created by Brennen Ferguson on 3/21/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

  @IBOutlet weak var nameText: UILabel!
  @IBOutlet weak var itemTypeText: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

  func configureWith(item: Item) {
    nameText.text = item.name
    let type: String = item.id.components(separatedBy: "-")[0]
    itemTypeText.text = type
  }
}
