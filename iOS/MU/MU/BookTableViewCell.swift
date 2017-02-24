//
//  BookTableViewCell.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell
{
  var book: Book!

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  func configureWith(book: Book)
  {
    self.book = book

    titleLabel.text = book.name
    authorLabel.text = book.author
    priceLabel.text = book.price
  }
}
