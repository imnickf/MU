//
//  ViewControllerHelpers.swift
//  MU
//
//  Created by Nick Flege on 3/2/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

extension UIViewController
{
  func hideKeyboardWhenTappedAround()
  {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  func dismissKeyboard()
  {
    view.endEditing(true)
  }
}
