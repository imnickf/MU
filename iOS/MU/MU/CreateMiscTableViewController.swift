//
//  CreateMiscTableViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/13/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Create Misc View.
class CreateMiscTableViewController: UITableViewController {

  /// The link to the "name" text field.
  @IBOutlet weak var NameTextField: UITextField!
  /// The link to the "category" text field.
  @IBOutlet weak var CategoryTextField: UITextField!
  /// The link to the "description" text view.
  @IBOutlet weak var DescriptionTextView: UITextView!
  /// The link to the "price" text field.
  @IBOutlet weak var PriceTextField: UITextField!
  /// The link to the "create" button.
  @IBOutlet weak var CreateButton: UIButton!
  
  
  /// An Array that stores the categories.
  var categoryArray = ["Electronics",
                       "Furniture",
                       "Video Games"]
  
  /// An Item Factory.
  let itemFactory = ItemFactory()
  
  /// An Item Repository.
  let itemRepo = ItemRepository()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    
    let catPicker = UIPickerView()
    catPicker.dataSource = self
    catPicker.delegate = self
    CategoryTextField.inputView = catPicker
    
    CreateButton.isEnabled = false
  }
  
  /// A function used to check if form is filled in.
  /// - returns: A boolean value indicating that the form is filled in.
  fileprivate func verifyInputs() -> Bool
  {
    return NameTextField.text != nil && CategoryTextField.text != nil && PriceTextField.text != nil && DescriptionTextView.text != "About this item"
  }
  
  /// A function that is used to create a new Misc.
  /// This fuction is linked to "Create" button.
  @IBAction func CreateNewMisc(_ sender: Any) {
    guard let name = NameTextField.text else {
      return
    }
    guard let category = CategoryTextField.text else {
      return
    }
    guard let description = DescriptionTextView.text else {
      return
    }
    guard let price = PriceTextField.text else {
      return
    }
    
    
    let misc = itemFactory.makeMisc(withDescription: description, name: name, price: "$" + price, category: category)
    itemRepo.persist(item: misc)
    let _ = self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITextViewDelegate Protocol Methods

extension CreateMiscTableViewController: UITextViewDelegate
{
  /// A function that is executed when the user
  /// begins editing a Text View.
  func textViewDidBeginEditing(_ textView: UITextView)
  {
    if textView.text == "About this item" {
      textView.text = nil
      textView.textColor = UIColor.white
    }
    tableView.isScrollEnabled = true
  }
  
  /// A function that is executed when the user
  /// ends editing a Text View.
  func textViewDidEndEditing(_ textView: UITextView)
  {
    if !DescriptionTextView.hasText {
      DescriptionTextView.text = "About this item"
      DescriptionTextView.textColor = UIColor.lightGray
    }
    tableView.isScrollEnabled = false
    
    if verifyInputs() {
      CreateButton.isEnabled = true
    } else {
      CreateButton.isEnabled = false
    }
  }
}

// MARK: - UITextFieldDelegate Protocol Methods

extension CreateMiscTableViewController: UITextFieldDelegate
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
      CreateButton.isEnabled = true
    } else {
      CreateButton.isEnabled = false
    }
  }
}



// MARK: - UIPickerViewDelegate Protocol Methods

extension CreateMiscTableViewController: UIPickerViewDelegate
{
  /// A function that is used to set titles for the row.
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return categoryArray[row]
  }
  
  /// A function that is used to update the "category" text field when a user
  /// selects a category.
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    CategoryTextField.text = categoryArray[row]
  }
  
}

// MARK: - UIPickerViewDataSource Protocol Methods

extension CreateMiscTableViewController: UIPickerViewDataSource
{
  /// A function that sets the number of columns for the picker.
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  /// A function that sets the number of rows for the picker.
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return categoryArray.count
  }
}
