//
//  BookTableViewCell.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Book Table View.
class BookTableViewCell: UITableViewCell
{
  /// A Book Object used to store the created Book.
  var book: Book!

  /// A link to the "title" label.
  @IBOutlet weak var titleLabel: UILabel!
  
  /// A link to the "author" label.
  @IBOutlet weak var authorLabel: UILabel!
  
  /// A link to the "price" label.
  @IBOutlet weak var priceLabel: UILabel!
  
  /// A function that initalizes a Book for
  /// this Table View Cell.
  func configureWith(book: Book)
  {
    self.book = book

    titleLabel.text = book.name
    authorLabel.text = book.author
    priceLabel.text = book.price
  }
}
