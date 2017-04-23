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

let userRepo = UserRespository()

/// A class used to manage the Profile View.
class ProfileTableViewController: UITableViewController
{
  @IBOutlet weak var nameText: UILabel!
  @IBOutlet weak var emailText: UILabel!
  @IBOutlet weak var testImage: UIImageView!
  @IBOutlet weak var adminTitle: UITableViewCell!
  @IBOutlet weak var adminUsers: UITableViewCell!
  @IBOutlet weak var adminItems: UITableViewCell!
  
  
  /// The AppDelegate of the Profile View.
  let signOutDelegate: SignOutDelegate = (UIApplication.shared.delegate as! AppDelegate)


  override func viewDidLoad()
  {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = Theme.primaryRedColor
    navigationController?.navigationBar.tintColor = UIColor.black
    tabBarController?.tabBar.barTintColor = Theme.primaryGrayColor
    tabBarController?.tabBar.tintColor = Theme.secondaryRedColor
    
    nameText.text = FIRAuth.auth()?.currentUser?.displayName
    emailText.text = FIRAuth.auth()?.currentUser?.email
    
    if (UserDefaults.standard.integer(forKey: "userType") != 3) {
      adminTitle.isHidden = true
      adminUsers.isHidden = true
      adminItems.isHidden = true
    }
    
    
    let url = URL(string: "http://proj-309-gb-4.cs.iastate.edu/images/Qd04tReXvcfCDuFvPak5hyNO44U2/cat_image.jpg")
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if (error != nil) {
        print(error!.localizedDescription)
      }
      else {
        var docDirectory: String?
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
          docDirectory = paths[0]
          let savePath = docDirectory! + "/cat.jpg"
          
          FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
          
          DispatchQueue.main.async {
            self.testImage.image = UIImage(named: savePath)
          }
        }
      }
    }
    
    task.resume()
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

// MARK: - Navigation

extension ProfileTableViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPostedItems" {
      if let vc = segue.destination as? ViewItemsProfileTableViewController {
        vc.fetchType = .posted
        vc.userId = userRepo.getCurrentUserID()
        vc.navigationItem.title = "Posted Items"
      }
    }
    
    if segue.identifier == "showSoldItems" {
      if let vc = segue.destination as? ViewItemsProfileTableViewController {
        vc.fetchType = .sold
        vc.userId = userRepo.getCurrentUserID()
        vc.navigationItem.title = "Sold Items"
      }
    }
  }
}
