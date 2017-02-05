//
//  Misc.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Misc: Item
{
  var category: String

  init(id: String, sellerID: String, createDate: String, buyerID: String?, price: String, isSold: Bool, dateSold: String?, viewCount: Int, category: String)
  {
    self.category = category

    super.init(id: id, sellerID: sellerID, createDate: createDate, buyerID: buyerID, price: price, isSold: isSold, dateSold: dateSold, viewCount: viewCount)
  }
}
