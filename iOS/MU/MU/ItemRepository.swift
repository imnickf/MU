//
//  ItemRepository.swift
//  MU
//
//  Created by Nick Flege on 2/4/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

/// The ItemRepository class enables you to query and persist item data with the database.
/// The ItemRepository interfaces with DatabaseGateway to save and query raw JSON data. It interfaces
/// with ItemFactory to create items from raw data supplied by DatabaseGateway before returning 
/// it to the user in a usable Item object.
class ItemRepository
{
  /// ItemFactory property for creating items
  fileprivate var factory: ItemFactory

  /// DatabaseGateway for connecting to database
  fileprivate var gateway: DatabaseGateway

  /// Creates a new ItemRepository
  init()
  {
    factory = ItemFactory()
    gateway = DatabaseGateway()
  }

  /// Gets items of specified type from database
  /// - Parameter type: the type of item being queried
  /// - Parameter completion: callback containg queried items or empty array if no items found
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

  /// Gets all items created by a specified user
  /// - Parameter forUserId: userID for whose items to query
  /// - Parameter completion: callback containing queried items for specified user or empty array if none exist
  func getItems(forUserId id: String, completion: @escaping ([Item]) -> Void)
  {
    var items: [Item] = [Item]()
    gateway.query(endpoint: FirebaseKeyVendor.usersKey + "/" + id + "/" + FirebaseKeyVendor.itemsKey) { (data, error) in
      
      if let itemData = data {
        for key in itemData.keys {
          //Retrieve type.
          var keyInfo: [String] = (key).components(separatedBy: "-")
          var itemType: ItemType? = nil
          switch keyInfo[0] {
          case "food":
            itemType = .food
            
          case "ticket":
            itemType = .ticket
            
          case "book":
            itemType = .book
            
          case "misc":
            itemType = .miscellaneous
            
            default:
              return
          }
          
          items.append(self.factory.makeItem(type: itemType!, key: key, data: itemData[key]! as! [String : Any]))
          
        }
      }
      
      completion(items)
    }
  }

  func getUserID() -> String
  {
    return FIRAuth.auth()!.currentUser!.uid
  }

  /// Deletes a provided item from the databse completely
  /// - Parameter item: item to be deleted
  func delete(item: Item)
  {
    // TODO
  }

  /// Marks an item as sold in the database
  /// - Parameter item: item to be marked as sold
  /// - Parameter byUser: unique ID for the buyer of the item
  func markItemBought(_ item: Item, byUser id: String)
  {
    // TODO
  }

  /// Saves provided item to database
  /// - Parameter item: item to be saved to database
  func persist(item: Item)
  {
    switch item {
    case is Ticket:
      let data = translate(ticket: item as! Ticket)
      gateway.persist(data: data, endpoint: FirebaseKeyVendor.ticketsPath + "/\(item.id)")
      gateway.persist(item: data, forUserId: FIRAuth.auth()!.currentUser!.uid, andItemId: item.id)
      break
    case is Book:
      let data = translate(book: item as! Book)
      gateway.persist(data: data, endpoint: FirebaseKeyVendor.booksPath + "/\(item.id)")
      gateway.persist(item: data, forUserId: FIRAuth.auth()!.currentUser!.uid, andItemId: item.id)
      break
    case is Food:
      let data = translate(food: item as! Food)
      gateway.persist(data: data, endpoint: FirebaseKeyVendor.foodPath + "/\(item.id)")
      gateway.persist(item: data, forUserId: FIRAuth.auth()!.currentUser!.uid, andItemId: item.id)
      break
    case is Misc:
      let data = translate(misc: item as! Misc)
      gateway.persist(data: data, endpoint: FirebaseKeyVendor.miscPath + "/\(item.id)")
      gateway.persist(item: data, forUserId: FIRAuth.auth()!.currentUser!.uid, andItemId: item.id)
      break
    default:
      return
    }
  }

  /// Fetches ticket items from database
  /// - Parameter completion: callback containing fetched ticket items or error value
  fileprivate func fetchTickets(completion: @escaping ([Ticket]?, Error?) -> Void)
  {
    gateway.query(endpoint: FirebaseKeyVendor.ticketsPath) { (data, error) in
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
  /// - Parameter completion: callback containing fetched book item or error value
  fileprivate func fetchBooks(completion: @escaping ([Book]?, Error?) -> Void)
  {
    gateway.query(endpoint: FirebaseKeyVendor.booksPath) { (data, error) in
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
  /// - Parameter completion: callback containing fetched food items or error value
  fileprivate func fetchFood(completion: @escaping ([Food]?, Error?) -> Void)
  {
    gateway.query(endpoint: FirebaseKeyVendor.foodPath) { (data, error) in
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
  /// - Parameter completion: callback containing fetched misc items or error value
  fileprivate func fetchMisc(completion: @escaping ([Misc]?, Error?) -> Void)
  {
    gateway.query(endpoint: FirebaseKeyVendor.miscPath) { (data, error) in
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
  
  /// Translates ticket into raw data dictionary to be persisted
  /// - Parameter ticket: item to be translated
  /// - Returns: dictionary of ticket properties
  fileprivate func translate(ticket: Ticket) -> [String : Any]
  {
    var ticketData = [String : Any]()
    ticketData[FirebaseKeyVendor.buyerIDKey] = ticket.buyerID ?? nil
    ticketData[FirebaseKeyVendor.createDateKey] = ticket.createDate.iso8601
    ticketData[FirebaseKeyVendor.creatorIDKey] = ticket.creatorID
    ticketData[FirebaseKeyVendor.dateSoldKey] = ticket.dateSold?.iso8601
    ticketData[FirebaseKeyVendor.descriptionKey] = ticket.description
    ticketData[FirebaseKeyVendor.locationKey] = ticket.location ?? nil
    ticketData[FirebaseKeyVendor.nameKey] = ticket.name
    ticketData[FirebaseKeyVendor.priceKey] = ticket.price
    ticketData[FirebaseKeyVendor.sportKey] = ticket.sport
    ticketData[FirebaseKeyVendor.timeKey] = ticket.time.iso8601
    ticketData[FirebaseKeyVendor.viewCountKey] = ticket.viewCount

    return ticketData
  }

  /// Translates book into raw data dictionary to be persisted
  /// - Parameter book: item to be translated
  /// - Returns: dictionary of book properties
  fileprivate func translate(book: Book) -> [String : Any]
  {
    var bookData = [String : Any]()
    bookData[FirebaseKeyVendor.authorKey] = book.author
    bookData[FirebaseKeyVendor.buyerIDKey] = book.buyerID ?? nil
    bookData[FirebaseKeyVendor.classCodeKey] = book.classCode ?? nil
    bookData[FirebaseKeyVendor.createDateKey] = book.createDate.iso8601
    bookData[FirebaseKeyVendor.creatorIDKey] = book.creatorID
    bookData[FirebaseKeyVendor.dateSoldKey] = book.dateSold?.iso8601
    bookData[FirebaseKeyVendor.descriptionKey] = book.description
    bookData[FirebaseKeyVendor.isbnKey] = book.isbn ?? nil
    bookData[FirebaseKeyVendor.nameKey] = book.name
    bookData[FirebaseKeyVendor.priceKey] = book.price
    bookData[FirebaseKeyVendor.viewCountKey] = book.viewCount

    return bookData
  }

  /// Translates food into raw data dictionary to be persisted
  /// - Parameter food: item to be translated
  /// - Returns: dictionary of food properties
  fileprivate func translate(food: Food) -> [String : Any]
  {
    var foodData = [String : Any]()
    foodData[FirebaseKeyVendor.categoryKey] = food.category
    foodData[FirebaseKeyVendor.createDateKey] = food.createDate.iso8601
    foodData[FirebaseKeyVendor.creatorIDKey] = food.creatorID
    foodData[FirebaseKeyVendor.descriptionKey] = food.description
    foodData[FirebaseKeyVendor.locationKey] = food.location ?? nil
    foodData[FirebaseKeyVendor.nameKey] = food.name
    foodData[FirebaseKeyVendor.timeKey] = food.time?.iso8601
    foodData[FirebaseKeyVendor.viewCountKey] = food.viewCount

    return foodData
  }

  /// Translates misc item into raw data dictionary to be persisted
  /// - Parameter misc: item to be translated
  /// - Returns: dictionary of misc item properties
  fileprivate func translate(misc: Misc) -> [String : Any]
  {
    var miscData = [String : Any]()
    miscData[FirebaseKeyVendor.buyerIDKey] = misc.buyerID ?? nil
    miscData[FirebaseKeyVendor.categoryKey] = misc.category
    miscData[FirebaseKeyVendor.createDateKey] = misc.createDate.iso8601
    miscData[FirebaseKeyVendor.creatorIDKey] = misc.creatorID
    miscData[FirebaseKeyVendor.descriptionKey] = misc.description
    miscData[FirebaseKeyVendor.dateSoldKey] = misc.dateSold?.iso8601
    miscData[FirebaseKeyVendor.nameKey] = misc.name
    miscData[FirebaseKeyVendor.priceKey] = misc.price
    miscData[FirebaseKeyVendor.viewCountKey] = misc.viewCount

    return miscData
  }
}
