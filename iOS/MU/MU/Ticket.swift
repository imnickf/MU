//
//  Ticket.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Ticket: Item
{
  var sport: String
  var time: String
  var location: String

  init(id: String, sellerID: String, createDate: String, buyerID: String?, price: String, isSold: Bool, dateSold: String?, viewCount: Int, sport: String, time: String, location: String)
  {
    self.sport = sport
    self.time = time
    self.location = location

    super.init(id: id, sellerID: sellerID, createDate: createDate, buyerID: buyerID, price: price, isSold: isSold, dateSold: dateSold, viewCount: viewCount)
  }
}

// TODO: Add sport enum
