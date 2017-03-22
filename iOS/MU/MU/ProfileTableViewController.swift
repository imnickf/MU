//
//  ViewController.swift
//  MU
//
//  Created by Nick Flege on 2/1/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

/// A protocol that is used to implement the sign out functionality.
protocol SignOutDelegate
{
  /// A method that is used to sign out the user.
  func signOut()
}

/// A class used to manage the Profile View.
class ProfileTableViewController: UITableViewController
{
  @IBOutlet weak var nameText: UILabel!
  
  /// The AppDelegate of the Profile View.
  let signOutDelegate: SignOutDelegate = (UIApplication.shared.delegate as! AppDelegate)


  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    navigationController?.navigationBar.barTintColor = Theme.primaryRedColor
    navigationController?.navigationBar.tintColor = UIColor.black
    tabBarController?.tabBar.barTintColor = Theme.primaryGrayColor
    tabBarController?.tabBar.tintColor = Theme.secondaryRedColor
    
    
    //Add Name to text.
  }

    /// A method that is used to sign out the user using Firebase API.
    /// This function is linked to the "Sign Out" button on the navagation bar.
    /// On click, the fuction signOut() is called.
    /// - parameter sender: The UIBarButtonItem that is clicked when the user wishes to sign out.
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
