//
//  CreateBookTableViewController.swift
//  MU
//
//  Created by Nick Flege on 3/5/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Create Book View.
class CreateBookTableViewController: UITableViewController
{
  /// The link to the "name" text field.
  @IBOutlet weak var nameTextField: UITextField!
  
  /// The link to the "author" text field.
  @IBOutlet weak var authorTextField: UITextField!
  
  /// The link to the "ISBN" text field.
  @IBOutlet weak var isbnTextField: UITextField!
  
  /// The link to the "Class" text field.
  @IBOutlet weak var classCodeTextField: UITextField!
  
  /// The link to the "price" text field.
  @IBOutlet weak var priceTextField: UITextField!
  
  /// The link to the "description" text View.
  @IBOutlet weak var descriptionTextView: UITextView!
  
  /// The link to the "create" button.
  @IBOutlet weak var createButton: UIButton!

  /// An Item Factory.
  let itemFactory = ItemFactory()
  
  /// An Item Repository.
  let itemRepo = ItemRepository()

  var shouldEdit: Bool = false
  var book: Book?

  override func viewDidLoad()
  {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()

    createButton.isEnabled = false
  }

  override func viewWillAppear(_ animated: Bool)
  {
    if shouldEdit {
      guard let editBook = book else {
        return
      }

      nameTextField.text = editBook.name
      authorTextField.text = editBook.author
      priceTextField.text = editBook.price.substring(from: editBook.price.index(editBook.price.startIndex, offsetBy: 1))
      descriptionTextView.text = editBook.description != "" ? editBook.description : "About this book"
      isbnTextField.text = editBook.isbn
      classCodeTextField.text = editBook.classCode
      createButton.setTitle("Save", for: .normal)
      createButton.isEnabled = true
    }
  }

  /// A function used to check if form is filled in.
  /// - returns: A boolean value indicating that the form is filled in.
  fileprivate func verifyInputs() -> Bool
  {
    return nameTextField.text != nil && authorTextField.text != nil && priceTextField.text != nil && priceTextField.text!.isCurrencyFormat() && descriptionTextView.text != "About this book"
  }

  /// A function that is used to create a new user.
  /// This fuction is linked to "Create" button.
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

    if shouldEdit {
      guard let editBook = book else {
        return
      }

      editBook.name = name
      editBook.author = author
      editBook.price = "$" + price
      editBook.description = description
      editBook.isbn = isbnTextField.text
      editBook.classCode = classCodeTextField.text
      itemRepo.persist(item: editBook)
      let _ = self.navigationController?.popViewController(animated: true)
    } else {
      let newBook = itemFactory.makeBook(withDescription: description, name: name, author: author, price: "$" + price, isbn: isbnTextField.text, classCode: classCodeTextField.text)
      itemRepo.persist(item: newBook)
    }
    let _ = self.navigationController?.popViewController(animated: true)
  }
}

extension CreateBookTableViewController: UITextViewDelegate
{
  /// A function that is executed when the user
  /// begins editing a Text View.
  func textViewDidBeginEditing(_ textView: UITextView)
  {
    if textView.text == "About this book" {
      textView.text = nil
      textView.textColor = UIColor.white
    }
    tableView.isScrollEnabled = true
  }

  /// A function that is executed when the user
  /// ends editing a Text View.
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
  /// A function that is executed when the user
  /// begins editing a Text Field.
  func textFieldDidBeginEditing(_ textField: UITextField)
  {
    tableView.isScrollEnabled = true
  }

  /// A function that is executed when the user
  /// ends editing a Text Field.
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
