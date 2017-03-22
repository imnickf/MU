//
//  CreateFoodTableViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 3/7/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// A class used to manage the Create Food View.
class CreateFoodTableViewController: UITableViewController {

  /// The link to the "name" text field.
  @IBOutlet weak var nameTextField: UITextField!
  /// The link to the "date" text field.
  @IBOutlet weak var dateTextField: UITextField!
  /// The link to the "category" text field.
  @IBOutlet weak var categoryTextField: UITextField!
  /// The link to the "description" text view.
  @IBOutlet weak var descriptionTextView: UITextView!
  /// The link to the "location" text field.
  @IBOutlet weak var locationTextField: UITextField!
  /// The link to the "create" button.
  @IBOutlet weak var createButton: UIButton!
  
  /// An Array that stores the categories.
  var categoryArray = ["American",
                       "Italian",
                       "Chinese"]
  
  /// A Date object used to hold the selected date.
  var selectedDate: Date?
  
  /// An Item Factory.
  let itemFactory = ItemFactory()
  
  /// An Item Repository.
  let itemRepo = ItemRepository()
  
  var food: Food?
  var shouldEdit: Bool = false
  
  /// A DateFormatter used to format the date to a human readable format.
  lazy var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
  }()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      hideKeyboardWhenTappedAround()
      
      let datePicker = UIDatePicker()
      datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
      dateTextField.inputView = datePicker
      
      let catPicker = UIPickerView();
      catPicker.delegate = self
      catPicker.dataSource = self
      categoryTextField.inputView = catPicker
      
      createButton.isEnabled = false
    }
  
  override func viewWillAppear(_ animated: Bool) {
    if shouldEdit {
      guard let editFood = food else {
        return
      }
      
      nameTextField.text = editFood.name
      dateTextField.text = dateFormatter.string(from: editFood.time!)
      selectedDate = editFood.time
      categoryTextField.text = editFood.category
      descriptionTextView.text = editFood.description != "" ? editFood.description : "Description of Food"
      locationTextField.text = editFood.location
      createButton.setTitle("Save", for: .normal)
      createButton.isEnabled = true
    }
  }
  
  
  /// A function used to check if form is filled in.
  /// - returns: A boolean value indicating that the form is filled in.
  fileprivate func verifyInputs() -> Bool
  {
    return nameTextField.text != nil && selectedDate != nil && categoryTextField.text != nil && descriptionTextView.text != "Description of Food"
  }
  
  /// A function that is used to create a new Food.
  /// This fuction is linked to "Create" button.
  @IBAction func createFood(_ sender: Any) {
    guard let name = nameTextField.text else {
      return
    }
    guard let date = selectedDate else {
      return
    }
    guard let category = categoryTextField.text else {
      return
    }
    guard let description = descriptionTextView.text else {
      return
    }
    
    if shouldEdit {
      guard let editFood = food else {
        return
      }
      
      editFood.name = name
      editFood.time = date
      editFood.category = category
      editFood.description = description
      editFood.location = locationTextField.text
      itemRepo.persist(item: editFood)
      let _ = self.navigationController?.popViewController(animated: true)
      
    } else {

    let food = itemFactory.makeFood(withDescription: description, name: name, category: category, location: locationTextField.text, time: date)
    itemRepo.persist(item: food)
    let _ = self.navigationController?.popViewController(animated: true)
    }
  }
}

// MARK: - UITextViewDelegate Protocol Methods

extension CreateFoodTableViewController: UITextViewDelegate
{
  /// A function that is executed when the user
  /// begins editing a Text View.
  func textViewDidBeginEditing(_ textView: UITextView)
  {
    if textView.text == "Description of Food" {
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
      descriptionTextView.text = "Description of Food"
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

extension CreateFoodTableViewController: UITextFieldDelegate
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

// MARK: - UIPickerViewDelegate Protocol Methods

extension CreateFoodTableViewController: UIPickerViewDelegate
{
  /// A function that is used to set titles for the row.
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return categoryArray[row]
  }
  
  /// A function that is used to update the "category" text field when a user
  /// selects a category.
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    categoryTextField.text = categoryArray[row]
  }
  
}

// MARK: - UIPickerViewDataSource Protocol Methods

extension CreateFoodTableViewController: UIPickerViewDataSource
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

// MARK: - Actions

extension CreateFoodTableViewController
{
  /// A function that changes the date when the user edits the date
  /// using a date picker.
  func dateChanged(_ sender: UIDatePicker)
  {
    selectedDate = sender.date
    dateTextField.text = dateFormatter.string(from: sender.date)
  }
}

