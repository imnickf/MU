//
//  CreateTicketViewController.swift
//  MU
//
//  Created by Nick Flege on 2/28/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class CreateTicketViewController: UIViewController
{
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var sportTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!

  lazy var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
  }()

  override func viewDidLoad()
  {
    super.viewDidLoad()

    let datePicker = UIDatePicker()
    datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    dateTextField.inputView = datePicker
  }
}

// MARK: - UITextViewDelegate Protocol Methods

extension CreateTicketViewController: UITextViewDelegate
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

// MARK: - DatePicker Actions

extension CreateTicketViewController
{
  func dateChanged(_ sender: UIDatePicker)
  {
    dateTextField.text = dateFormatter.string(from: sender.date)
  }
}
