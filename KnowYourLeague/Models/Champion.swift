//
//  Champion.swift
//  KnowYourLeague
//
//  Created by Alex on 9/9/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation
import SwiftyJSON

class Champion {
    
    let id: String
    let key: String
    let name: String
    let title: String
    let image: String
    let tags: [String]
    let info: Info
    let blurb: String
    
    init(id: String, key: String, name: String, title: String, image: String, tags: [String], info: [String: Int], blurb: String) {
        self.id = id
        self.key = key
        self.name = name
        self.title = title
        self.image = image.replacingOccurrences(of: ".png", with: "")
        self.tags = tags
        self.info = Info(info)
        self.blurb = blurb.replacingOccurrences(of: "<br>", with: "\n")
    }
    
    class func build(json: JSON) -> Champion? {
        
        
        if
            let id = json["id"].string,
            let key = json["key"].string,
            let name = json["name"].string,
            let title = json["title"].string,
            let image = json["image"]["full"].string,
            let tags = json["tags"].arrayValue.map({$0.stringValue}) as? [String],
            let info = json["info"].dictionaryObject as? [String: Int],
            let blurb = json["blurb"].string
             {
            return Champion(id: id, key: key, name: name, title: title, image: image, tags: tags, info: info, blurb: blurb)
        } else {
            NSLog("bad json \(json)")
            return nil
        }
    }
}
    
    
    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? "Error"
//        self.key = try container.decodeIfPresent(Int.self, forKey: .key) ?? 0
//        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Error"
//        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Error"
//        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? ["Error"]
//        self.info = try container.decodeIfPresent([String: Int].self, forKey: .info) ?? ["Error": 0]
//        self.blurb = try container.decodeIfPresent(String.self, forKey: .blurb) ?? "Error"
//
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case key
//        case name
//        case title
//        case tags
//        case info
//        case blurb
//    }

