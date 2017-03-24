//
//  Item.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

/// The ItemType enum for different types of Items available in the MU application
enum ItemType
{
  case ticket, book, food, miscellaneous
}

/// The Item class is a super class containing shared properties for the various item types
class Item
{
  /// Unique ID for item
  private(set) var id: String

  /// Unique ID for the creator of the item
  private(set) var creatorID: String

  /// Date item was created
  private(set) var createDate: Date

  /// Name or title of item
  var name: String

  /// Description about the item
  var description: String

  /// Number of times the item has been viewed
  var viewCount: Int

  /// Creates a new Item object
  init(id: String, creatorID: String, createDate: String, desc: String, name: String, viewCount: Int)
  {
    self.id = id
    self.creatorID = creatorID
    self.createDate = createDate.dateFromISO8601!
    self.description = desc
    self.name = name
    self.viewCount = viewCount
  }
}
