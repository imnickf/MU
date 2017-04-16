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

  /// Retrieves the current user's ID
  /// - Returns: userID for current user
  func getCurrentUserID() -> String
  {
    return FIRAuth.auth()!.currentUser!.uid
  }

  /// Gets the metadata for the users current user is chatting with
  /// - Parameter completion: completion handler containing user meta data
  func getUsersChatList(completion: @escaping ([UserMetaData]) -> Void)
  {
    let userID = getCurrentUserID()
    let userPath = FirebaseKeyVendor.usersKey + "/" + userID + "/" + FirebaseKeyVendor.chatsKey
    gateway.query(endpoint: userPath) { (data, error) in
      if error != nil {
        print(error!.localizedDescription)
      }
      var usersMetaData = [UserMetaData]()
      if let chats = data {
        self.gateway.query(endpoint: FirebaseKeyVendor.usersKey) { (usersData, err) in
          if err != nil {
            print(err!.localizedDescription)
          }
          for (user, _) in chats {
            if let displayName = (usersData?[user] as? [String: Any])?[FirebaseKeyVendor.displayNameKey] as? String {
              usersMetaData.append(UserMetaData(userID: user, displayName: displayName))
            }
          }
          completion(usersMetaData)
        }
      } else {
        completion(usersMetaData)
      }
    }
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

struct UserMetaData
{
  var userID: String
  var displayName: String
}
