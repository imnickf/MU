//
//  Book.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Book: Item
{
  var price: String
  var dateSold: String?
  var author: String
  var isbn: String?
  var classCode: String

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, isSold: Bool, dateSold: String?, viewCount: Int, author: String, isbn: String, classCode: String)
  {
    self.price = price
    self.dateSold = dateSold
    self.author = author
    self.isbn = isbn
    self.classCode = classCode

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}
