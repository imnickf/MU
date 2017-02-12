//
//  Ticket.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Ticket: Item
{
  var price: String
  var dateSold: String?
  var sport: String
  var time: String
  var location: String

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, price: String, isSold: Bool, dateSold: String?, viewCount: Int, sport: String, time: String, location: String)
  {
    self.price = price
    self.dateSold = dateSold
    self.sport = sport
    self.time = time
    self.location = location

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}

// TODO: Add sport enum
