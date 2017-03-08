//
//  CreateTicketTableViewController.swift
//  MU
//
//  Created by Nick Flege on 3/2/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class CreateTicketTableViewController: UITableViewController
{
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var sportTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var createButton: UIButton!

  var selectedDate: Date?
  let itemFactory = ItemFactory()
  let itemRepo = ItemRepository()

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

  fileprivate func verifyInputs() -> Bool
  {
    return nameTextField.text != nil && selectedDate != nil && sportTextField.text != nil && priceTextField.text != nil && priceTextField.text!.isCurrencyFormat() && descriptionTextView.text != "About this ticket"
  }

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
  func textViewDidBeginEditing(_ textView: UITextView)
  {
    if textView.text == "About this ticket" {
      textView.text = nil
      textView.textColor = UIColor.white
    }
    tableView.isScrollEnabled = true
  }

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

// MARK: - Actions

extension CreateTicketTableViewController
{
  func dateChanged(_ sender: UIDatePicker)
  {
    selectedDate = sender.date
    dateTextField.text = dateFormatter.string(from: sender.date)
  }
}
