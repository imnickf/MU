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
  @IBOutlet weak var descriptionTextView: UITextView!

  override func viewDidLoad()
  {
    super.viewDidLoad()
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
