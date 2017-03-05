//
//  CreateBookTableViewController.swift
//  MU
//
//  Created by Nick Flege on 3/5/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class CreateBookTableViewController: UITableViewController
{
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var authorTextField: UITextField!
  @IBOutlet weak var isbnTextField: UITextField!
  @IBOutlet weak var classCodeTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var createButton: UIButton!

  let itemFactory = ItemFactory()
  let itemRepo = ItemRepository()

  override func viewDidLoad()
  {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()

    createButton.isEnabled = false
  }

  fileprivate func verifyInputs() -> Bool
  {
    return nameTextField.text != nil && authorTextField.text != nil && priceTextField.text != nil && priceTextField.text!.isCurrencyFormat() && descriptionTextView.text != "About this book"
  }

  @IBAction func createNewBook()
  {
    guard let name = nameTextField.text else {
      return
    }
    guard let author = authorTextField.text else {
      return
    }
    guard let price = priceTextField.text else {
      return
    }
    guard let description = descriptionTextView.text else {
      return
    }

    let book = itemFactory.makeBook(withDescription: description, name: name, author: author, price: "$" + price, isbn: isbnTextField.text, classCode: classCodeTextField.text)
    itemRepo.persist(item: book)
    let _ = self.navigationController?.popViewController(animated: true)
  }
}

extension CreateBookTableViewController: UITextViewDelegate
{
  func textViewDidBeginEditing(_ textView: UITextView)
  {
    if textView.text == "About this book" {
      textView.text = nil
      textView.textColor = UIColor.white
    }
    tableView.isScrollEnabled = true
  }

  func textViewDidEndEditing(_ textView: UITextView)
  {
    if !descriptionTextView.hasText {
      descriptionTextView.text = "About this book"
      descriptionTextView.textColor = UIColor.lightGray
    }
    tableView.isScrollEnabled = false

    if verifyInputs() {
      createButton.isEnabled = true
    } else {
      createButton.isEnabled = false
    }
  }
}

// MARK: - UITextFieldDelegate Protocol Methods

extension CreateBookTableViewController: UITextFieldDelegate
{
  func textFieldDidBeginEditing(_ textField: UITextField)
  {
    tableView.isScrollEnabled = true
  }

  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason)
  {
    tableView.isScrollEnabled = false

    if verifyInputs() {
      createButton.isEnabled = true
    } else {
      createButton.isEnabled = false
    }
  }
}
