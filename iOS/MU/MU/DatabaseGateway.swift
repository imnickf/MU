//
//  DatabaseGateway.swift
//  MU
//
//  Created by Nick Flege on 2/4/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseDatabase

/// The DatabaseGateway class interfaces directly with the Firebase backend database.
/// This class is used to fetch raw data from the database as well as to save raw data
/// back to the database.
class DatabaseGateway
{
  /// Queries the database at a given endpoint and returns the contents in the completion handler
  /// - Parameter endpoint: the path or endpoint in the database being queried
  /// - Parameter completion: callback containing raw dictionary data for queried objects or error
  func query(endpoint: String, with completion: @escaping ([String : Any]?, Error?) -> Void)
  {
    FIRDatabase.database().reference().child(endpoint).observeSingleEvent(of: .value, with: { snapshot in
      let value = snapshot.value as? [String : Any]

      completion(value, nil)
    }) { error in
      print(error.localizedDescription)
      completion(nil, error)
    }
  }

  /// Saves provided data to firebase at the provided endpoint
  /// - Parameter data: data being saved to database
  /// - Parameter endpoint: endpoint or path at which the data should be saved
  func persist(data: Any, endpoint: String)
  {
    FIRDatabase.database().reference().child(endpoint).setValue(data)
  }

  /// Saves itemID in users table
  /// - Parameter itemId: itemId string being saved to database
  /// - Parameter forUserId: userId for which the item is being saved for
  func persist(itemId id: String, forUserId uid: String)
  {
    FIRDatabase.database().reference().child(FirebaseKeyVender.usersKey + "/" + uid + "/" + FirebaseKeyVender.itemsKey).childByAutoId().setValue(id)
  }

  /// Creates new unique ID for the specified endpoint
  /// - Parameter endpoint: endpoint or path for which an unique should be Created
  /// - Returns: unique identifier string for given endpoint
  static func createNewID(_ endpoint: String) -> String
  {
    return FIRDatabase.database().reference().child(endpoint).childByAutoId().key
  }
}
