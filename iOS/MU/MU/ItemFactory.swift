//
//  ItemFactory.swift
//  MU
//
//  Created by Nick Flege on 2/4/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

class ItemFactory
{
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

  func newTicket(withDescription desc: String, location: String?, name: String, price: String, sport: String, time: Date) -> Ticket
  {
    let id = "" // TODO: Figure out how we assign this
    let ticket = Ticket(id: id, creatorID: FIRAuth.auth()!.currentUser!.uid, createDate: Date().iso8601, desc: desc, name: name, buyerID: nil, price: price, dateSold: nil, viewCount: 0, sport: sport, time: time.iso8601, location: location)
    return ticket
  }

  func newBook(withDescription desc: String, name: String, author: String, price: String, isbn: String?, classCode: String?) -> Book
  {
    let id = "" // TODO: Figure out how we assign this
    let book = Book(id: id, creatorID: FIRAuth.auth()!.currentUser!.uid, createDate: Date().iso8601, desc: desc, name: name, buyerID: nil, price: price, dateSold: nil, viewCount: 0, author: author, isbn: isbn, classCode: classCode)
    return book
  }

  fileprivate func make(ticket key: String, with data: [String : Any]) -> Ticket
  {
    let buyerID = data[FirebaseKeyVender.buyerIDKey] as? String
    let createDate = data[FirebaseKeyVender.createDateKey] as! String
    let creatorID = data[FirebaseKeyVender.creatorIDKey] as! String
    let description = data[FirebaseKeyVender.descriptionKey] as! String
    let dateSold = data[FirebaseKeyVender.dateSoldKey] as? String
    let location = data[FirebaseKeyVender.locationKey] as? String
    let name = data[FirebaseKeyVender.nameKey] as! String
    let price = data[FirebaseKeyVender.priceKey] as! String
    let sport = data[FirebaseKeyVender.sportKey] as! String
    let time = data[FirebaseKeyVender.timeKey] as! String
    let viewCount = data[FirebaseKeyVender.viewCountKey] as! Int

    let ticket = Ticket(id: key, creatorID: creatorID, createDate: createDate, desc: description, name: name, buyerID: buyerID, price: price, dateSold: dateSold, viewCount: viewCount, sport: sport, time: time, location: location)
    return ticket
  }

  fileprivate func make(book key: String, with data: [String : Any]) -> Book
  {
    let author = data[FirebaseKeyVender.authorKey] as! String
    let buyerID = data[FirebaseKeyVender.buyerIDKey] as? String
    let classCode = data[FirebaseKeyVender.classCodeKey] as? String
    let createDate = data[FirebaseKeyVender.createDateKey] as! String
    let creatorID = data[FirebaseKeyVender.creatorIDKey] as! String
    let dateSold = data[FirebaseKeyVender.dateSoldKey] as? String
    let description = data[FirebaseKeyVender.descriptionKey] as! String
    let isbn = data[FirebaseKeyVender.isbnKey] as? String
    let name = data[FirebaseKeyVender.nameKey] as! String
    let price = data[FirebaseKeyVender.priceKey] as! String
    let viewCount = data[FirebaseKeyVender.viewCountKey] as! Int

    let book = Book(id: key, creatorID: creatorID, createDate: createDate, desc: description, name: name, buyerID: buyerID, price: price, dateSold: dateSold, viewCount: viewCount, author: author, isbn: isbn, classCode: classCode)
    return book
  }

  fileprivate func make(food key: String, with data: [String : Any]) -> Food
  {
    let category = data[FirebaseKeyVender.categoryKey] as! String
    let creatorID = data[FirebaseKeyVender.creatorIDKey] as! String
    let createDate = data[FirebaseKeyVender.createDateKey] as! String
    let description = data[FirebaseKeyVender.descriptionKey] as! String
    let location = data[FirebaseKeyVender.locationKey] as? String
    let name = data[FirebaseKeyVender.nameKey] as! String
    let time = data[FirebaseKeyVender.timeKey] as? String
    let viewCount = data[FirebaseKeyVender.viewCountKey] as! Int

    let food = Food(id: key, creatorID: creatorID, createDate: createDate, desc: description, location: location, name: name, time: time, viewCount: viewCount, category: category)
    return food
  }

  fileprivate func make(misc key: String, with data: [String : Any]) -> Misc
  {
    let buyerID = data[FirebaseKeyVender.buyerIDKey] as? String
    let category = data[FirebaseKeyVender.categoryKey] as! String
    let creatorID = data[FirebaseKeyVender.creatorIDKey] as! String
    let createDate = data[FirebaseKeyVender.createDateKey] as! String
    let dateSold = data[FirebaseKeyVender.dateSoldKey] as? String
    let description = data[FirebaseKeyVender.descriptionKey] as! String
    let name = data[FirebaseKeyVender.nameKey] as! String
    let price = data[FirebaseKeyVender.priceKey] as! String
    let viewCount = data[FirebaseKeyVender.viewCountKey] as! Int

    let misc = Misc(id: key, creatorID: creatorID, createDate: createDate, desc: description, name: name, buyerID: buyerID, price: price, dateSold: dateSold, viewCount: viewCount, category: category)
    return misc
  }
}
