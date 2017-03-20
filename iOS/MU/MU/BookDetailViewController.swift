//
//  BookDetailViewController.swift
//  MU
//
//  Created by Nick Flege on 3/20/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController
{
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var isbnLabel: UILabel!
  @IBOutlet weak var classCodeLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!

  @IBOutlet weak var buyButton: UIButton!
  @IBOutlet weak var isbnInfoLabel: UILabel!
  @IBOutlet weak var classCodeInfoLabel: UILabel!

  var book: Book!

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool)
  {
    titleLabel.text = book.name
    authorLabel.text = book.author
    priceLabel.text = book.price
    descriptionTextView.text = book.description
    isbnLabel.text = book.isbn
    classCodeLabel.text = book.classCode

    isbnLabel.isHidden = book.isbn == nil
    isbnInfoLabel.isHidden = book.isbn == nil

    classCodeLabel.isHidden = book.classCode == nil
    classCodeInfoLabel.isHidden = book.classCode == nil
  }

  @IBAction func buyItem(_ sender: Any)
  {
    
  }
}
