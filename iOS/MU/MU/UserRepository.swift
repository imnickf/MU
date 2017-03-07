//
//  UserRepository.swift
//  MU
//
//  Created by Nick Flege on 3/6/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

class UserRespository
{
  fileprivate var gateway: DatabaseGateway

  init() {
    gateway = DatabaseGateway()
  }

  /// Saves new user information to database
  func setupNewUser()
  {
    let endpoint = FirebaseKeyVender.usersKey + "/" + FIRAuth.auth()!.currentUser!.uid

    gateway.query(endpoint) { (data, error) in
      if data == nil {
        self.gateway.persist(data: UserType.normal.rawValue, endpoint: endpoint + "/" + FirebaseKeyVender.userTypeKey)
      }
    }
  }
}
