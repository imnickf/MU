//
//  Users.swift
//  MU
//
//  Created by Brennen Ferguson on 4/18/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import UIKit

class User {
  var userId: String
  
  var userName: String
  
  var type: Int
  
  var postedItems: [Item]?
  
  init(id: String, name: String, type: Int, postedItems: [Item]?) {
    self.userId = id
    self.userName = name
    self.type = type
    self.postedItems = postedItems
  }
}
