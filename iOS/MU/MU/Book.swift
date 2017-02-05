//
//  Book.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Book: Item
{
  var author: String
  var isbn: String?
  var classCode: String

  init(id: String, sellerID: String, createDate: String, buyerID: String?, price: String, isSold: Bool, dateSold: String?, viewCount: Int, author: String, isbn: String, classCode: String)
  {
    self.author = author
    self.isbn = isbn
    self.classCode = classCode

    super.init(id: id, sellerID: sellerID, createDate: createDate, buyerID: buyerID, price: price, isSold: isSold, dateSold: dateSold, viewCount: viewCount)
  }
}
