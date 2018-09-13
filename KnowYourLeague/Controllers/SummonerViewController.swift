//
//  SummonerViewController.swift
//  KnowYourLeague
//
//  Created by MCS on 9/9/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import UIKit
import SwiftyJSON

class SummonerViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var levelLbl: UILabel!
  @IBOutlet weak var sumText: UITextField!
  @IBOutlet weak var profileImgView: UIImageView!
  @IBOutlet weak var userNameLbl: UILabel!
  @IBOutlet weak var searchBtn: UIButton!
  var isSearching : Bool = false
  var masteryList = [[String:String]]()
  var filteredMasteryList = [[String:String]]()
  
  var summonerName = "SnD L0L"
  override func viewDidLoad() {
  
    super.viewDidLoad()
    if summonerName == " " {
        sumText.isHidden = true
        searchBtn.isHidden = true
    }
  }
    
  
  @IBAction func SearchPressed(_ sender: Any) {
    
    if let summName =  sumText.text {
      let baseUrl = URL(fileURLWithPath: Constants.GET_USER_MAIN_DATA + summName)
      NetworkManager.shared.getSummonerData(baseUrl, completion: {
        resp in
        if let resp = resp {
          let decoder = JSONDecoder()
          do{
            let userData = try decoder.decode(UserMainData.self, from: resp as! Data)
            print(userData)
            DispatchQueue.main.async {
              self.displayUserInfo(userData)
            }
            
          } catch let err{
            NSLog("Decoder Error: \(err.localizedDescription)")
          }
        }
      })
    }
  }
  
  func displayUserInfo(_ userData: UserMainData){
    self.masteryList.removeAll()
    userNameLbl.text = userData.name
    levelLbl.text = String(userData.summonerLevel)
    if (UIImage (named: String(userData.profileIconId)) != nil) {
        profileImgView.image = UIImage(named: String(userData.profileIconId))
    } else {
      profileImgView.image = UIImage(named: "7")
    }
    
    
    let baseUrl = URL(fileURLWithPath: Constants.GET_MASTERY_CHAMPS + String(userData.id))
    NetworkManager.shared.getSummonerData(baseUrl, completion: {
      resp in
      do{
        let championsJson = try JSON(data: resp as! Data)
        for (_, v):(String, JSON) in championsJson {
          let newChamp = MapMastery.shared.getChampionData(champion: v)
          self.masteryList.append(newChamp)
        }
        DispatchQueue.main.sync {
          self.tableView.reloadData()
        }
      }catch let err{
        print("Error Parsing JSON: \(err.localizedDescription)")
      }
    })
  }

}

extension SummonerViewController: UITableViewDelegate, UITableViewDataSource {
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("Numero de registros:\(self.masteryList.count)")
    if !isSearching {
        return self.masteryList.count
    } else {
      return self.filteredMasteryList.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "summonerMasteryCell", for: indexPath) as! SummonerMasteryViewCell
    cell.masteryImgView.image = UIImage(named: "MasterBadge")
    var currentMastery = [String:String]()
    if isSearching {
       currentMastery = filteredMasteryList[indexPath.row]
    } else {
       currentMastery = masteryList[indexPath.row]
    }
    cell.levelLbl.text = currentMastery["level"]
    cell.championName.text = currentMastery["name"]
    cell.championPoints.text = currentMastery["points"]
    cell.championImgView.image = UIImage(named: currentMastery["image"]! )
    
    return cell
  }
}


extension SummonerViewController: UISearchBarDelegate{
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if !searchText.isEmpty {
      isSearching = true
      self.filteredMasteryList = self.masteryList.filter({ (e) -> Bool in
      let  element : String = e["name"]!.lowercased()
        if (element.contains(searchText.lowercased())){
          return true
        } else {
          return false
        }
      })
    } else {
      isSearching = false
    }
    self.tableView.reloadData()
  }
  
}
