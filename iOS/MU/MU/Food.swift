//
//  Food.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

/// The Food class is an Item subclass for items of type Food. Food items will be used for free food advertisements or foods on sale.
class Food: Item
{
  /// Category that food falls under
  var category: String

  /// Location of free food event
  var location: String?

  /// Time of free food event
  var time: Date?

  /// Create new Food item
  init(id: String, creatorID: String, createDate: String, desc: String, location: String?, name: String, time: String?, viewCount: Int, category: String)
  {
    self.category = category
    self.location = location
    self.time = time?.dateFromISO8601

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, viewCount: viewCount)
  }
}
