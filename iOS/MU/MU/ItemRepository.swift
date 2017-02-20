//
//  ItemProvider.swift
//  MU
//
//  Created by Nick Flege on 2/4/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class ItemRepository
{
  fileprivate var factory: ItemFactory
  fileprivate var gateway: ItemGateway

  init()
  {
    factory = ItemFactory()
    gateway = ItemGateway()
  }

  /// Gets items of specified type from database
  func getItems(_ type: ItemType, completion: @escaping ([Item]) -> Void)
  {
    switch type {
    case .ticket:
      fetchTickets() { (tickets, error) in
        if tickets != nil {
          completion(tickets!)
        } else {
          completion([])
        }
      }
    case .book:
      fetchBooks() { (books, error) in
        if books != nil {
          completion(books!)
        } else {
          completion([])
        }
      }
    case .food:
      fetchFood() { (food, error) in
        if food != nil {
          completion(food!)
        } else {
          completion([])
        }
      }

    case .miscellaneous:
      fetchMisc() { (misc, error) in
        if misc != nil {
          completion(misc!)
        } else {
          completion([])
        }
      }
    }
  }

  func presist(item: Item)
  {
    switch item {
    case is Ticket:
      gateway.persist(data: translate(ticket: item as! Ticket), endpoint: FirebaseKeyVender.ticketsPath + "/\(item.id)")
      break
    case is Book:
      gateway.persist(data: translate(book: item as! Book), endpoint: FirebaseKeyVender.booksPath + "/\(item.id)")
      break
    case is Food:
      gateway.persist(data: translate(food: item as! Food), endpoint: FirebaseKeyVender.foodPath + "/\(item.id)")
      break
    case is Misc:
      gateway.persist(data: translate(misc: item as! Misc), endpoint: FirebaseKeyVender.miscPath + "/\(item.id)")
      break
    default:
      return
    }
  }

  /// Fetches ticket items from database
  fileprivate func fetchTickets(completion: @escaping ([Ticket]?, Error?) -> Void)
  {
    gateway.query(FirebaseKeyVender.ticketsPath) { (data, error) in
      var tickets = [Ticket]()
      if let ticketsData = data {
        for key in ticketsData.keys {
          tickets.append(self.factory.makeItem(type: .ticket, key: key, data: ticketsData[key] as! [String: Any]) as! Ticket)
        }
        completion(tickets, nil)
      } else {
        completion(nil, error)
      }
    }
  }

  /// Fetches book items from database
  fileprivate func fetchBooks(completion: @escaping ([Book]?, Error?) -> Void)
  {
    gateway.query(FirebaseKeyVender.booksPath) { (data, error) in
      var books = [Book]()
      if let booksData = data {
        for key in booksData.keys {
          books.append(self.factory.makeItem(type: .book, key: key, data: booksData[key] as! [String: Any]) as! Book)
        }
        completion(books, nil)
      } else {
        completion(nil, error)
      }
    }
  }

  /// Fetches food items from database
  fileprivate func fetchFood(completion: @escaping ([Food]?, Error?) -> Void)
  {
    gateway.query(FirebaseKeyVender.foodPath) { (data, error) in
      var food = [Food]()
      if let foodData = data {
        for key in foodData.keys {
          food.append(self.factory.makeItem(type: .food, key: key, data: foodData[key] as! [String: Any]) as! Food)
        }
        completion(food, nil)
      } else {
        completion(nil, error)
      }
    }
  }

  /// Fetches miscellaneous items from database
  fileprivate func fetchMisc(completion: @escaping ([Misc]?, Error?) -> Void)
  {
    gateway.query(FirebaseKeyVender.miscPath) { (data, error) in
      var miscItems = [Misc]()
      if let miscData = data {
        for key in miscData.keys {
          miscItems.append(self.factory.makeItem(type: .miscellaneous, key: key, data: miscData[key] as! [String: Any]) as! Misc)
        }
        completion(miscItems, nil)
      } else {
        completion(nil, error)
      }
    }
  }

  /// Translates ticket into dictionary to be persisted
  /// - Parameter ticket: item to be translated
  /// - Returns: dictionary of ticket properties
  fileprivate func translate(ticket: Ticket) -> [String : Any]
  {
    var ticketData = [String : Any]()
    ticketData[FirebaseKeyVender.buyerIDKey] = ticket.buyerID ?? nil
    ticketData[FirebaseKeyVender.createDateKey] = ticket.createDate.iso8601
    ticketData[FirebaseKeyVender.creatorIDKey] = ticket.creatorID
    ticketData[FirebaseKeyVender.dateSoldKey] = ticket.dateSold?.iso8601
    ticketData[FirebaseKeyVender.descriptionKey] = ticket.description
    ticketData[FirebaseKeyVender.locationKey] = ticket.location ?? nil
    ticketData[FirebaseKeyVender.nameKey] = ticket.name
    ticketData[FirebaseKeyVender.priceKey] = ticket.price
    ticketData[FirebaseKeyVender.sportKey] = ticket.sport
    ticketData[FirebaseKeyVender.timeKey] = ticket.time.iso8601
    ticketData[FirebaseKeyVender.viewCountKey] = ticket.viewCount

    return ticketData
  }

  /// Translates book into dictionary to be persisted
  /// - Parameter book: item to be translated
  /// - Returns: dictionary of book properties
  fileprivate func translate(book: Book) -> [String : Any]
  {

    return [ : ] // TODO
  }

  /// Translates food into dictionary to be persisted
  /// - Parameter food: item to be translated
  /// - Returns: dictionary of food properties
  fileprivate func translate(food: Food) -> [String : Any]
  {

    return [ : ] // TODO
  }

  /// Translates misc item into dictionary to be persisted
  /// - Parameter misc: item to be translated
  /// - Returns: dictionary of misc item properties
  fileprivate func translate(misc: Misc) -> [String : Any]
  {

    return [ : ] // TODO
  }
}
