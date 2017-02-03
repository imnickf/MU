//
//  AuthViewController.swift
//  MU
//
//  Created by Nick Flege on 2/1/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController, GIDSignInUIDelegate
{
  @IBOutlet weak var signInButton: GIDSignInButton!

  override func viewDidLoad()
  {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
  }
}
