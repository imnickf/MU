//
//  FoodAddViewController.swift
//  MU
//
//  Created by Brennen Ferguson on 2/23/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class FoodAddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let categories = ["Italian","Mexican","Chinese"]
    var selCategory = ""
    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var DesText: UITextField!
    @IBOutlet weak var LocText: UITextField!
    @IBOutlet weak var CatUIPicker: UIPickerView!
   
    @IBOutlet weak var TestLabel: UILabel!
    @IBAction func InfoSubmit(_ sender: Any) {
        //Add to the database.
        if (NameText.text != nil) {
            TestLabel.text = NameText.text!
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selCategory = categories[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
