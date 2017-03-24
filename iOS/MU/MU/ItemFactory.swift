//
//  ItemFactory.swift
//  MU
//
//  Created by Nick Flege on 2/4/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

/// The ItemFactory class is a factory class used to create Item objects. This class can create
/// items of all types from either raw dictionary data retrieved from the database or from
/// supplied typed fields.
class ItemFactory
{
  /// Creates an item of the specified type with the specified raw data
  /// - Parameter type: type of item to be created
  /// - Parameter key: unique identifier for item
  /// - Parameter data: raw dictionary data used to create item
  /// - Returns: the created item
  func makeItem(type: ItemType, key: String, data: [String : Any]) -> Item
  {
    switch type {
    case .book:
      return make(book: key, with: data)
    case .ticket:
      return make(ticket: key, with: data)
    case .food:
      return make(food: key, with: data)
    case .miscellaneous:
      return make(misc: key, with: data)
    }
  }

  /// Creates a ticket item with the supplied fields.
  func makeTicket(withDescription desc: String, location: String?, name: String, price: String, sport: String, time: Date) -> Ticket
  {
    let id = "ticket" + DatabaseGateway.createNewID(FirebaseKeyVendor.ticketsPath)
    let ticket = Ticket(id: id, creatorID: FIRAuth.auth()!.currentUser!.uid, createDate: Date().iso8601, desc: desc, name: name, buyerID: nil, price: price, dateSold: nil, viewCount: 0, sport: sport, time: time.iso8601, location: location)
    return ticket
  }

  /// Creates a book item with the supplied fields.
  func makeBook(withDescription desc: String, name: String, author: String, price: String, isbn: String?, classCode: String?) -> Book
  {
    let id = "book" + DatabaseGateway.createNewID(FirebaseKeyVendor.ticketsPath)
    let book = Book(id: id, creatorID: FIRAuth.auth()!.currentUser!.uid, createDate: Date().iso8601, desc: desc, name: name, buyerID: nil, price: price, dateSold: nil, viewCount: 0, author: author, isbn: isbn, classCode: classCode)
    return book
  }

  /// Creates a food item with the supplied fields.
  func makeFood(withDescription desc: String, name: String, category: String, location: String?, time: Date?) -> Food
  {
    let id = "food" + DatabaseGateway.createNewID(FirebaseKeyVendor.ticketsPath)
    let food = Food(id: id, creatorID: FIRAuth.auth()!.currentUser!.uid, createDate: Date().iso8601, desc: desc, location: location, name: name, time: time?.iso8601, viewCount: 0, category: category)
    return food
  }

  /// Creates a misc item with the supplied fields.
  func makeMisc(withDescription desc: String, name: String, price: String, category: String) -> Misc
  {
    let id = "misc" + DatabaseGateway.createNewID(FirebaseKeyVendor.ticketsPath)
    let misc = Misc(id: id, creatorID: FIRAuth.auth()!.currentUser!.uid, createDate: Date().iso8601, desc: desc, name: name, buyerID: nil, price: price, dateSold: nil, viewCount: 0, category: category)
    return misc
  }

  /// Creates a ticket item of the with the specified raw data
  /// - Parameter key: unique identifier for ticket
  /// - Parameter data: raw dictionary data used to create ticket
  /// - Returns: the created ticket
  fileprivate func make(ticket key: String, with data: [String : Any]) -> Ticket
  {
    let buyerID = data[FirebaseKeyVendor.buyerIDKey] as? String
    let createDate = data[FirebaseKeyVendor.createDateKey] as! String
    let creatorID = data[FirebaseKeyVendor.creatorIDKey] as! String
    let description = data[FirebaseKeyVendor.descriptionKey] as? String ?? ""
    let dateSold = data[FirebaseKeyVendor.dateSoldKey] as? String
    let location = data[FirebaseKeyVendor.locationKey] as? String
    let name = data[FirebaseKeyVendor.nameKey] as! String
    let price = data[FirebaseKeyVendor.priceKey] as! String
    let sport = data[FirebaseKeyVendor.sportKey] as! String
    let time = data[FirebaseKeyVendor.timeKey] as! String
    let viewCount = data[FirebaseKeyVendor.viewCountKey] as! Int

    let ticket = Ticket(id: key, creatorID: creatorID, createDate: createDate, desc: description, name: name, buyerID: buyerID, price: price, dateSold: dateSold, viewCount: viewCount, sport: sport, time: time, location: location)
    return ticket
  }

  /// Creates a book item of the with the specified raw data
  /// - Parameter key: unique identifier for book
  /// - Parameter data: raw dictionary data used to create book
  /// - Returns: the created book
  fileprivate func make(book key: String, with data: [String : Any]) -> Book
  {
    let author = data[FirebaseKeyVendor.authorKey] as! String
    let buyerID = data[FirebaseKeyVendor.buyerIDKey] as? String
    let classCode = data[FirebaseKeyVendor.classCodeKey] as? String
    let createDate = data[FirebaseKeyVendor.createDateKey] as! String
    let creatorID = data[FirebaseKeyVendor.creatorIDKey] as! String
    let dateSold = data[FirebaseKeyVendor.dateSoldKey] as? String
    let description = data[FirebaseKeyVendor.descriptionKey] as? String ?? ""
    let isbn = data[FirebaseKeyVendor.isbnKey] as? String
    let name = data[FirebaseKeyVendor.nameKey] as! String
    let price = data[FirebaseKeyVendor.priceKey] as! String
    let viewCount = data[FirebaseKeyVendor.viewCountKey] as! Int

    let book = Book(id: key, creatorID: creatorID, createDate: createDate, desc: description, name: name, buyerID: buyerID, price: price, dateSold: dateSold, viewCount: viewCount, author: author, isbn: isbn, classCode: classCode)
    return book
  }

  /// Creates a food item of the with the specified raw data
  /// - Parameter key: unique identifier for food item
  /// - Parameter data: raw dictionary data used to create food item
  /// - Returns: the created food item
  fileprivate func make(food key: String, with data: [String : Any]) -> Food
  {
    let category = data[FirebaseKeyVendor.categoryKey] as! String
    let creatorID = data[FirebaseKeyVendor.creatorIDKey] as! String
    let createDate = data[FirebaseKeyVendor.createDateKey] as! String
    let description = data[FirebaseKeyVendor.descriptionKey] as? String ?? ""
    let location = data[FirebaseKeyVendor.locationKey] as? String
    let name = data[FirebaseKeyVendor.nameKey] as! String
    let time = data[FirebaseKeyVendor.timeKey] as? String
    let viewCount = data[FirebaseKeyVendor.viewCountKey] as! Int

    let food = Food(id: key, creatorID: creatorID, createDate: createDate, desc: description, location: location, name: name, time: time, viewCount: viewCount, category: category)
    return food
  }

  /// Creates a misc item of the with the specified raw data
  /// - Parameter key: unique identifier for misc item
  /// - Parameter data: raw dictionary data used to create misc item
  /// - Returns: the created misc item
  fileprivate func make(misc key: String, with data: [String : Any]) -> Misc
  {
    let buyerID = data[FirebaseKeyVendor.buyerIDKey] as? String
    let category = data[FirebaseKeyVendor.categoryKey] as! String
    let creatorID = data[FirebaseKeyVendor.creatorIDKey] as! String
    let createDate = data[FirebaseKeyVendor.createDateKey] as! String
    let dateSold = data[FirebaseKeyVendor.dateSoldKey] as? String
    let description = data[FirebaseKeyVendor.descriptionKey] as? String ?? ""
    let name = data[FirebaseKeyVendor.nameKey] as! String
    let price = data[FirebaseKeyVendor.priceKey] as! String
    let viewCount = data[FirebaseKeyVendor.viewCountKey] as! Int

    let misc = Misc(id: key, creatorID: creatorID, createDate: createDate, desc: description, name: name, buyerID: buyerID, price: price, dateSold: dateSold, viewCount: viewCount, category: category)
    return misc
  }
}
