//
//  Food.swift
//  MU
//
//  Created by Nick Flege on 2/3/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

class Food: Item
{
  var category: String
  var location: String = "The MU in the Food Court"

  init(id: String, creatorID: String, createDate: String, desc: String, name: String, buyerID: String?, viewCount: Int, category: String)
  {
    self.category = category

    super.init(id: id, creatorID: creatorID, createDate: createDate, desc: desc, name: name, buyerID: buyerID, viewCount: viewCount)
  }
}
