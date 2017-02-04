//
//  ViewController.swift
//  MU
//
//  Created by Nick Flege on 2/1/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol SignOutDelegate
{
  func signOut()
}

class ProfileViewController: UIViewController
{
  let signOutDelegate: SignOutDelegate = (UIApplication.shared.delegate as! AppDelegate)

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  @IBAction func signOut(_ sender: UIBarButtonItem)
  {
    do {
      try FIRAuth.auth()?.signOut()
      signOutDelegate.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
}

