//
//  Book.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

/// The Book class is an Item subclass for items of type Book. Book items will be used for textbooks being sold by students.
class Book: Item
{
  /// Author of book
  var author: String

  /// Unique ID for buyer
  var buyerID: String?

  /// Code for class that requires this book
  var classCode: String?

  /// Date item was sold
  var dateSold: Date?

  /// ISBN number for book
  var isbn: String?

  /// Boolean value if item has been sold
  var isSold: Bool

  /// Price of item
  var price: String

  /// Create new Book item
  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, dateSold: String?, viewCount: Int, author: String, isbn: String?, classCode: String?)
  {
    self.price = price
    self.author = author
    self.isbn = isbn
    self.classCode = classCode
    self.dateSold = dateSold?.dateFromISO8601
    self.buyerID = buyerID
    self.isSold = buyerID != nil

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, viewCount: viewCount)
  }
}
