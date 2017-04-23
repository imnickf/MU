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

  @IBOutlet weak var actionButton: UIButton!
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
    actionButton.isHidden = false

    if UserRespository().getCurrentUserID() == book.creatorID {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
      actionButton.setTitle("Mark Book Sold", for: .normal)
    } else {
      actionButton.setTitle("Message Seller", for: .normal)
      navigationItem.rightBarButtonItem = nil
    }
  }

  @objc fileprivate func editItem()
  {
    performSegue(withIdentifier: "editBook", sender: self)
  }

  @IBAction func actionButtonPressed(_ sender: UIButton)
  {
    if UserRespository().getCurrentUserID() == book.creatorID {
      // TODO: Mark sold
    } else {
      performSegue(withIdentifier: "showChat", sender: self)
    }
  }
}

// MARK: - Navigation

extension BookDetailViewController
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "editBook" {
      if let vc = segue.destination as? CreateBookTableViewController {
        vc.shouldEdit = true
        vc.book = book
      }
    } else if segue.identifier == "showChat" {
      if let vc = segue.destination as? ChatViewController {
        vc.receiverID = book.creatorID
      }
    }
  }
}
