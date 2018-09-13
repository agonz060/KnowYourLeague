//
//  ChampionManager.swift
//  KnowYourLeague
//
//  Created by Alex on 9/10/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChampionManager {
    
    private var championList = [Champion]()
    
    static let shared = ChampionManager()
    private init() {
        instantiateChampions()
    }
    
    private func instantiateChampions() {
        if let path = Bundle.main.path(forResource: "champion", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do{
                    let championsJson = try JSON(data: data)
                    
                    for (_, value) in JSON(championsJson["data"]) {
                        if let champion = Champion.build(json: value) {
                            self.championList.append(champion)
                        }
                    }
                }catch let err{
                    NSLog("Parsing error: \(err.localizedDescription)")
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func getChampionList(completionHandler: ([Champion]?) -> ()) {
        completionHandler(self.championList)
    }
    
    func printChampionList() {
        print(self.championList)
    }
    
    
    
}
