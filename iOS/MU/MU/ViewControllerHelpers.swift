//
//  ViewControllerHelpers.swift
//  MU
//
//  Created by Nick Flege on 3/2/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

/// Extension of UIViewController to add keyboard dismissal ability
extension UIViewController
{
  /// Dismisses keyboard when visible if user taps anywhere outside the keyboard view
  func hideKeyboardWhenTappedAround()
  {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  /// Dismisses the keyboard if active
  func dismissKeyboard()
  {
    view.endEditing(true)
  }
}

/// Extension of String to add currency string format varification
extension String
{
  /// Determines if string is in currency format
  /// - Returns: boolean value if string is in currency format
  func isCurrencyFormat() -> Bool
  {
    let regex = "\\d{0,}?(\\.\\d\\d)?"

    let currencyTest = NSPredicate(format:"SELF MATCHES %@", regex)
    return currencyTest.evaluate(with: self) && self != ""
  }
}
