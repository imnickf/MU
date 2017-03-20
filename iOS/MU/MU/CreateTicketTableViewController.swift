//
//  CreateTicketTableViewController.swift
//  MU
//
//  Created by Nick Flege on 3/2/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Create Ticket View.
class CreateTicketTableViewController: UITableViewController
{
  /// The link to the "name" text field.
  @IBOutlet weak var nameTextField: UITextField!
  
  /// The link to the "date" text field.
  @IBOutlet weak var dateTextField: UITextField!
  
  /// The link to the "sport" text field.
  @IBOutlet weak var sportTextField: UITextField!
  
  /// The link to the "location" text field.
  @IBOutlet weak var locationTextField: UITextField!
  
  /// The link to the "price" text field.
  @IBOutlet weak var priceTextField: UITextField!
  
  /// The link to the "description" text View.
  @IBOutlet weak var descriptionTextView: UITextView!
  
  /// The link to the "create" button.
  @IBOutlet weak var createButton: UIButton!

  /// A Date object used to hold the selected date.
  var selectedDate: Date?
  
  /// An Item Factory.
  let itemFactory = ItemFactory()
  
  /// An Item Repository.
  let itemRepo = ItemRepository()

  /// A DateFormatter used to format the date to a human readable format.
  lazy var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
  }()

  override func viewDidLoad()
  {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()

    let datePicker = UIDatePicker()
    datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    dateTextField.inputView = datePicker

    createButton.isEnabled = false
  }

  /// A function used to check if form is filled in.
  /// - returns: A boolean value indicating that the form is filled in.
  fileprivate func verifyInputs() -> Bool
  {
    return nameTextField.text != nil && selectedDate != nil && sportTextField.text != nil && priceTextField.text != nil && priceTextField.text!.isCurrencyFormat() && descriptionTextView.text != "About this ticket"
  }

  
  /// A function that is used to create a new user.
  /// This fuction is linked to "Create" button.
  @IBAction func createNewTicket()
  {
    guard let name = nameTextField.text else {
      return
    }
    guard let date = selectedDate else {
      return
    }
    guard let sport = sportTextField.text else {
      return
    }
    guard let price = priceTextField.text else {
      return
    }
    guard let description = descriptionTextView.text else {
      return
    }

    let ticket = itemFactory.makeTicket(withDescription: description, location: locationTextField.text, name: name, price: "$" + price, sport: sport, time: date)
    itemRepo.persist(item: ticket)
    let _ = self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITextViewDelegate Protocol Methods

extension CreateTicketTableViewController: UITextViewDelegate
{
  /// A function that is executed when the user
  /// begins editing a Text View.
  func textViewDidBeginEditing(_ textView: UITextView)
  {
    if textView.text == "About this ticket" {
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
      descriptionTextView.text = "About this ticket"
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

extension CreateTicketTableViewController: UITextFieldDelegate
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

// MARK: - Actions

extension CreateTicketTableViewController
{
  /// A function that changes the date when the user edits the date
  /// using a date picker.
  func dateChanged(_ sender: UIDatePicker)
  {
    selectedDate = sender.date
    dateTextField.text = dateFormatter.string(from: sender.date)
  }
}