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
    // An dictionary that is used to store an item's type with the given itemID index.
    var itemType: [String: String] = [String: String]()
    gateway.query(endpoint: FirebaseKeyVendor.usersKey + "/" + id + "/" + FirebaseKeyVendor.itemsKey) { (data, error) in
      
      if let itemData = data {
        for key in itemData.keys {
          var charset = CharacterSet()
          charset.insert(charactersIn: "-")
          var keyInfo: [String] = (itemData[key] as! String).components(separatedBy: charset)
          
          //Catches the case where "-" are in the item id.
          var itemID: String = keyInfo[1]
          if (keyInfo.count > 2) {
            
            for i in 2...(keyInfo.count - 1) {
              itemID.append("-" + keyInfo[i])
            }
          }
          
          itemType[itemID] = keyInfo[0]
        }
      }
      
      var items: [Item]? = nil
      self.fetchUserItems(forItems: itemType, completion: { (data, error) in
        items = data
      })
      if items != nil {
        completion(items!)
      } else {
        completion([])
      }
    }
  }

  /// Saves provided item to database
  /// - Parameter item: item to be saved to database
  func persist(item: Item)
  {
    switch item {
    case is Ticket:
      gateway.persist(data: translate(ticket: item as! Ticket), endpoint: FirebaseKeyVendor.ticketsPath + "/\(item.id)")
      break
    case is Book:
      gateway.persist(data: translate(book: item as! Book), endpoint: FirebaseKeyVendor.booksPath + "/\(item.id)")
      break
    case is Food:
      gateway.persist(data: translate(food: item as! Food), endpoint: FirebaseKeyVendor.foodPath + "/\(item.id)")
      break
    case is Misc:
      gateway.persist(data: translate(misc: item as! Misc), endpoint: FirebaseKeyVendor.miscPath + "/\(item.id)")
      break
    default:
      return
    }
    gateway.persist(itemId: item.id, forUserId: FIRAuth.auth()!.currentUser!.uid)
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
  
  ///Fetches the User's Items from the database.
  /// - Parameter completion: callback containing fetched items or error value
  fileprivate func fetchUserItems(forItems: [String: String] , completion: @escaping ([Item]?, Error?) -> Void)
  {
    let queueGroup = DispatchGroup()
    var endpoint: String
    var itemsArr = [Item]()
    for key in forItems.keys {
      print(forItems[key]!)
      print(key)
      endpoint = FirebaseKeyVendor.productsKey + "/" + forItems[key]! + "/" + forItems[key]! + "-" + key
      gateway.query(endpoint: endpoint) { (data, error) in
        queueGroup.enter()
        if let items = data {
          if forItems[key]!.compare("food").rawValue == 0 {
            itemsArr.append(self.factory.makeItem(type: .food, key: key, data: items))
            print("added food")
          }
          else if forItems[key]!.compare("misc").rawValue == 0 {
            itemsArr.append(self.factory.makeItem(type: .miscellaneous, key: key, data: items))
            print("added misc")
          }
          else if forItems[key]!.compare("ticket").rawValue == 0 {
            itemsArr.append(self.factory.makeItem(type: .ticket, key: key, data: items))
            print("added ticket")
          }
          else if forItems[key]!.compare("book").rawValue == 0 {
            itemsArr.append(self.factory.makeItem(type: .book, key: key, data: items))
            print("added book")
          }
          queueGroup.leave()
        } else {
          completion(nil, error)
          return
        }
      }
    }
    
    queueGroup.wait()
    print(itemsArr.count)
    completion(itemsArr, nil)
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
