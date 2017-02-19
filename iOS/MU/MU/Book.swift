//
//  Book.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

class Book: Item
{
  var price: String
  var dateSold: Date?
  var author: String
  var isbn: String?
  var classCode: String?

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, dateSold: String?, viewCount: Int, author: String, isbn: String?, classCode: String?)
  {
    self.price = price
    self.author = author
    self.isbn = isbn
    self.classCode = classCode
    self.dateSold = dateSold?.dateFromISO8601

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}
