//
//  UserMainData.swift
//  KnowYourLeague
//
//  Created by MCS on 9/9/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation

struct UserMainData : Decodable {
  let  name: String
  let  summonerLevel : Int
  let  accountId: Int
  let  id: Int
  let  profileIconId: Int
}
