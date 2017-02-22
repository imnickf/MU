//
//  Food.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

class Food: Item
{
  var category: String
  var location: String?
  var time: Date?

  init(id: String, creatorID: String, createDate: String, desc: String, location: String?, name: String, time: String?, buyerID: String?, viewCount: Int, category: String)
  {
    self.category = category
    self.location = location
    self.time = time?.dateFromISO8601

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}
