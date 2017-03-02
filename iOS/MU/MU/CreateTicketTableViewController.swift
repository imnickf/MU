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
  }

  @IBAction func createNewTicket()
  {
    
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
  }

  func textViewDidEndEditing(_ textView: UITextView)
  {
    if !descriptionTextView.hasText {
      descriptionTextView.text = "About this ticket"
      descriptionTextView.textColor = UIColor.lightGray
    }
  }
}

// MARK: - Actions

extension CreateTicketTableViewController
{
  func dateChanged(_ sender: UIDatePicker)
  {
    dateTextField.text = dateFormatter.string(from: sender.date)
  }
}
