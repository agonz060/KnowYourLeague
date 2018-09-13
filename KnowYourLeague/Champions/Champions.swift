//
//  Champions.swift
//  KnowYourLeague
//
//  Created by MCS on 9/9/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation
import SwiftyJSON

class Champions {
  
  var championsList = [JSON]()
  
  func getData() -> JSON? {
    if let path = Bundle.main.path(forResource: "champion", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        do{
          let championsJson = try JSON(data: data)
          return championsJson["data"]
        }catch let err{
          NSLog("Parsing error: \(err)")
        }
      } catch let error {
        print("parse error: \(error.localizedDescription)")
      }
    } else {
      print("Invalid filename/path.")
    }
    return nil
  }
  
  
  func getChampions()  {
    let champs = getData()
    for (_, value)  in champs! {
      championsList.append(value)
    }
  }
  
  
  func getChampion(byId: Int )->JSON? {
    if championsList.count < 1 { getChampions()}
    let champs = championsList
    for c in champs{
      if let champId = c["key"].string {
        if champId == String(byId){ return c}
      }
    }
    return nil
  }
  
  func getChampion(byName: String) -> JSON? {
    if championsList.count < 1 { getChampions() }
    let champs = championsList
    for c in champs{
      if let champId = c["name"].string {
        if champId == byName{ return c}
      }
    }
    return nil
  }
}
