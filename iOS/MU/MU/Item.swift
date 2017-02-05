//
//  Item.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

enum ItemType
{
  case ticket, book, food, miscellaneous
}

class Item
{
  private(set) var id: String
  private(set) var sellerID: String
  private(set) var createDate: String
  var buyerID: String?
  var price: String
  var isSold: Bool
  var dateSold: String?
  var viewCount: Int

  init(id: String, sellerID: String, createDate: String, buyerID: String?, price: String, isSold: Bool, dateSold: String?, viewCount: Int)
  {
    self.id = id
    self.sellerID = sellerID
    self.createDate = createDate
    self.buyerID = buyerID
    self.price = price
    self.isSold = isSold
    self.dateSold = dateSold
    self.viewCount = viewCount
  }

}
