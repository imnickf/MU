//
//  Ticket.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

/// The Ticket class is an Item subclass for items of type Ticket. Ticket items will be used for tickets being sold by students.
class Ticket: Item
{
  /// Unique ID for buyer
  var buyerID: String?

  /// Date item was sold
  var dateSold: Date?

  /// Boolean value if item has been sold
  var isSold: Bool

  /// Location of event
  var location: String?

  /// Sport for ticket
  var sport: String

  /// Time of event
  var time: Date

  /// Price of item
  var price: String

  /// Create new Ticket item
  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, dateSold: String?, viewCount: Int, sport: String, time: String, location: String?)
  {
    self.price = price
    self.sport = sport
    self.location = location
    self.time = time.dateFromISO8601!
    self.dateSold = dateSold?.dateFromISO8601
    self.buyerID = buyerID
    self.isSold = buyerID != nil

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, viewCount: viewCount)
  }
}

// TODO: Add sport enum
