//
//  Info.swift
//  KnowYourLeague
//
//  Created by Alex on 9/13/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation

struct Info {
    let defense: Int
    let attack: Int
    let difficulty: Int
    let magic: Int
    
    init(_ dictionary: [String:Int]) {
        // set the Optional ones
        self.defense = dictionary["defense"] ?? 0
        self.attack = dictionary["attack"] ?? 0
        self.difficulty = dictionary["difficulty"] ?? 0
        self.magic = dictionary["magic"] ?? 0
    }
}
