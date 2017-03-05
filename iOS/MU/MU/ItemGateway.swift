//
//  ItemGateway.swift
//  MU
//
//  Created by Nick Flege on 2/4/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseDatabase

class ItemGateway
{
  /// Queries the database at a given endpoint and returns the contents in the completion handler
  func query(_ endpoint: String, with completion: @escaping ([String : Any]?, Error?) -> Void)
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
  func persist(data: [String: Any], endpoint: String)
  {
    FIRDatabase.database().reference().child(endpoint).setValue(data)
  }

  /// Saves itemID in users table
  func persist(userItemId id: String, forUserId uid: String)
  {
    FIRDatabase.database().reference().child(FirebaseKeyVender.usersKey + "/" + uid + "/" + FirebaseKeyVender.itemsKey).childByAutoId().setValue(id)
  }

  /// Creates new unique itemID
  static func createNewItemID(_ endpoint: String) -> String
  {
    return FIRDatabase.database().reference().child(endpoint).childByAutoId().key
  }
}
