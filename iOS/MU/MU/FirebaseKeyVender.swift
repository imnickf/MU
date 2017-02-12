//
//  FirebaseKeyVender.swift
//  MU
//
//  Created by Nick Flege on 2/11/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

struct FirebaseKeyVender
{
  static let productsKey      = "products"
  static let booksKey         = "book"
  static let ticketsKey       = "ticket"
  static let foodKey          = "food"
  static let miscKey          = "misc"
  static let usersKey         = "users"

  static let authorKey        = "author"
  static let buyerIDKey       = "buyerID"
  static let classCodeKey     = "classCode"
  static let createDateKey    = "createDate"
  static let creatorIDKey     = "creatorID"
  static let dateSoldKey      = "dateSold"
  static let descriptionKey   = "description"
  static let isbnKey          = "isbn"
  static let locationKey      = "location"
  static let nameKey          = "name"
  static let priceKey         = "price"
  static let sportKey         = "sport"
  static let timeKey          = "time"
  static let viewCountKey     = "viewCount"
}

// MARK: Database paths

extension FirebaseKeyVender
{
  static let ticketsPath = productsKey + "/" + ticketsKey
  static let booksPath = productsKey + "/" + booksKey
  static let foodPath = productsKey + "/" + foodKey
  static let miscPath = productsKey + "/" + miscKey
}
