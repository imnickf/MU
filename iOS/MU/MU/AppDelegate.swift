//
//  AppDelegate.swift
//  MU
//
//  Created by Nick Flege on 2/1/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  {
    FIRApp.configure()
    GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self

    if FIRAuth.auth()?.currentUser != nil {
      window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    } else {
      window?.rootViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
    }

    return true
  }

  func applicationWillResignActive(_ application: UIApplication)
  {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication)
  {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication)
  {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication)
  {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication)
  {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool
  {
    return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
  }
}

// MARK: - GIDSignInDelegate

extension AppDelegate: GIDSignInDelegate
{
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)
  {
    if let error = error {
      print(error.localizedDescription)
      return
    }

    if user.hostedDomain != "iastate.edu" {
      let alert = UIAlertController(title: "Error", message: "Please connect with your Iowa State email.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      window?.rootViewController?.present(alert, animated: true, completion: nil)

      signIn.disconnect()
      print("User did not sign in with iastate.edu email.")
      return
    }

    guard let authentication = user.authentication else { return }

    let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

    FIRAuth.auth()?.signIn(with: credential) { (user, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
      UserRespository().setupNewUser()
    }
  }

  func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!, withError error: Error!)
  {
    // Perform any operations when the user disconnects from app here.
    // ...
  }
}

extension AppDelegate: SignOutDelegate
{
  func signOut()
  {
    window?.rootViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
    GIDSignIn.sharedInstance().signOut()
    UserDefaults.standard.set(nil, forKey: "userType")
  }
}

