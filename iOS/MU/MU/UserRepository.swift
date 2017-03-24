//
//  UserRepository.swift
//  MU
//
//  Created by Nick Flege on 3/6/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

/// The UserRepository class enables you to query and persist user data with the database.
/// The UserRepository interfaces with DatabaseGateway to save and query raw JSON data.
class UserRespository
{
  /// DatabaseGateway for connecting to database
  fileprivate var gateway: DatabaseGateway

  /// Creates a new UserRepository
  init() {
    gateway = DatabaseGateway()
  }

  func getCurrentUserID() -> String
  {
    return FIRAuth.auth()!.currentUser!.uid
  }

  /// Saves new user information and permissions to database
  func setupNewUser()
  {
    let endpoint = FirebaseKeyVendor.usersKey + "/" + getCurrentUserID()

    gateway.querySingleEvent(endpoint: endpoint) { (data, error) in
      if data == nil {
        self.gateway.persist(data: UserType.normal.rawValue, endpoint: endpoint + "/" + FirebaseKeyVendor.userTypeKey)
        self.gateway.persist(data: FIRAuth.auth()!.currentUser!.displayName ?? "", endpoint: endpoint + "/" + FirebaseKeyVendor.displayNameKey)
      }
    }
  }
}
