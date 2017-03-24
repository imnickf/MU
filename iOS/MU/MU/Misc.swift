//
//  Misc.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

/// The Misc class is an Item subclass for items of type Miscellaneous. Miscellaneous items will be used for any 
/// item that does not classify as a Ticket, Book, or Food.
class Misc: Item
{
  /// Unique ID for buyer
  var buyerID: String?

  /// Category that misc item falls under
  var category: String

  /// Date item was sold
  var dateSold: Date?

  /// Boolean value if item has been sold
  var isSold: Bool

  /// Price of item
  var price: String

  /// Create new Misc item
  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, dateSold: String?, viewCount: Int, category: String)
  {
    self.price = price
    self.dateSold = dateSold?.dateFromISO8601
    self.category = category
    self.buyerID = buyerID
    self.isSold = buyerID != nil

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, viewCount: viewCount)
  }
}
