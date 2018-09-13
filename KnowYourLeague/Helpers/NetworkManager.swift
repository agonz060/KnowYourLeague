//
//  NetworkManager.swift
//  KnowYourLeague
//
//  Created by Alex on 9/9/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
  
  
  func getSummonerData(_ baseUrl: URL, completion: @escaping(Any?)->())  {
    
    if var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) {
      components.queryItems = [
        URLQueryItem (name: "api_key", value : Constants.LOL_KEY)
      ]
      if let url = components.url {
        print("the URL \(url)")
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)  {
          (data, response, error)  in
          if (error != nil) {
            print(error!.localizedDescription)
          } else {
            completion(data)
          }
        }
        dataTask.resume()
      }
    }
  }
}
