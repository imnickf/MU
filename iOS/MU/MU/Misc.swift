//
//  Misc.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Misc: Item
{
  var price: String
  var dateSold: String?
  var category: String

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, dateSold: String?, viewCount: Int, category: String)
  {
    self.price = price
    self.dateSold = dateSold
    self.category = category

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}
