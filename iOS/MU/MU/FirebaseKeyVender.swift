//
//  FirebaseKeyVender.swift
//  MU
//
//  Created by Nick Flege on 2/11/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

/// The FirebaseKeyVendor struct stores string literals for specific key paths in 
/// Firebase real-time database.
struct FirebaseKeyVendor
{
  /// Products key string
  static let productsKey      = "products"
  /// Books key string
  static let booksKey         = "book"
  /// Tickets key string
  static let ticketsKey       = "ticket"
  /// Food key string
  static let foodKey          = "food"
  /// Misc key string
  static let miscKey          = "misc"
  /// Users key string
  static let usersKey         = "users"
  /// Items key string
  static let itemsKey         = "items"
  /// User Sold Key
  static let userSoldKey      = "soldItems"
  /// User Bought Key
  static let userBoughtKey    = "boughtItems"
  /// User Type key string
  static let userTypeKey      = "type"
  /// Display Name key
  static let displayNameKey   = "displayName"

  /// Author key string
  static let authorKey        = "author"
  /// Buyer ID key string
  static let buyerIDKey       = "buyerID"
  /// Category key string
  static let categoryKey      = "category"
  /// Class Code key string
  static let classCodeKey     = "classCode"
  /// Create Date key string
  static let createDateKey    = "createDate"
  /// Creator ID key string
  static let creatorIDKey     = "creatorID"
  /// Date Sold key string
  static let dateSoldKey      = "dateSold"
  /// Description key string
  static let descriptionKey   = "description"
  /// ISBN key string
  static let isbnKey          = "isbn"
  /// Location key string
  static let locationKey      = "location"
  /// Name key string
  static let nameKey          = "name"
  /// Price key string
  static let priceKey         = "price"
  /// Sport key string
  static let sportKey         = "sport"
  /// Time key string
  static let timeKey          = "time"
  /// View Count key string
  static let viewCountKey     = "viewCount"

  /// Key for message senderID
  static let senderIdKey      = "senderID"
  /// Key for message content
  static let contentKey       = "content"
  /// Key for message date
  static let dateKey          = "date"
  /// Key for chats
  static let chatsKey         = "chats"
}

// MARK: Database paths

extension FirebaseKeyVendor
{
  /// Tickets path string
  static let ticketsPath = productsKey + "/" + ticketsKey
  /// Books path string
  static let booksPath = productsKey + "/" + booksKey
  /// Food path string
  static let foodPath = productsKey + "/" + foodKey
  /// Misc path string
  static let miscPath = productsKey + "/" + miscKey
}

/// The UserType enum for different user types available in the MU application
enum UserType: Int
{
  /// Admin user
  case admin = 1
  /// Moderator User
  case moderator = 2
  /// Normal user
  case normal = 3
}
