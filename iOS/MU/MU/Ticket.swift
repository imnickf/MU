//
//  Ticket.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

class Ticket: Item
{
  var price: String
  var dateSold: Date?
  var sport: String
  var time: Date
  var location: String?

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, dateSold: String?, viewCount: Int, sport: String, time: String, location: String?)
  {
    self.price = price
    self.sport = sport
    self.location = location
    self.time = time.dateFromISO8601!
    self.dateSold = dateSold?.dateFromISO8601

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}

// TODO: Add sport enum
