//
//  MapMastery.swift
//  KnowYourLeague
//
//  Created by MCS on 9/10/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation
import SwiftyJSON

class MapMastery {
  
  static let shared = MapMastery()
  private init(){}
  
  func getChampionData(champion : JSON) -> [String : String] {
    let champs = Champions()
    let champ = champs.getChampion(byId: champion["championId"].int!)
    print(champ!["name"] )
    print(champ!["image"]["full"])
    let response: [String : String] = [
      "name": champ!["name"].stringValue,
      "image" : champ!["image"]["full"].stringValue,
      "id": champion["championId"].stringValue,
      "level" : champion["championLevel"].stringValue,
      "points" : champion["championPoints"].stringValue
    ]
    return response
  }
  
  
}
