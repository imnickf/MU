//
//  Item.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

enum ItemType
{
  case ticket, book, food, miscellaneous
}

class Item
{
  private(set) var id: String
  private(set) var creatorID: String
  private(set) var createDate: Date
  var name: String
  var description: String
  var buyerID: String?
  var isSold: Bool
  var viewCount: Int

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, viewCount: Int)
  {
    self.id = id
    self.creatorID = creatorID
    self.createDate = createDate.dateFromISO8601!
    self.description = desc
    self.name = name
    self.buyerID = buyerID
    self.isSold = buyerID != nil
    self.viewCount = viewCount
  }
}
