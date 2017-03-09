//
//  AuthViewController.swift
//  MU
//
//  Created by Nick Flege on 2/1/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit
import GoogleSignIn

/// A class used to manage the Authentication View.
class AuthViewController: UIViewController, GIDSignInUIDelegate
{
  /// A link to the Google Sign-In button in the Authentication View.
  @IBOutlet weak var signInButton: GIDSignInButton!

  override func viewDidLoad()
  {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
    signInButton.style = .wide
  }
}
