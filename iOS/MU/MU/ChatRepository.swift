//
//  ChatRepository.swift
//  MU
//
//  Created by Nick Flege on 3/24/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import FirebaseAuth

class ChatRepository
{
  /// DatabaseGateway for connecting to database
  fileprivate var gateway: DatabaseGateway

  init()
  {
    gateway = DatabaseGateway()
  }

  
}
