//
//  SummonerMasteryViewCell.swift
//  KnowYourLeague
//
//  Created by MCS on 9/10/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import UIKit

class SummonerMasteryViewCell: UITableViewCell {

  @IBOutlet weak var levelLbl: UILabel!
  @IBOutlet weak var championImgView: UIImageView!
  @IBOutlet weak var masteryImgView: UIImageView!
  @IBOutlet weak var championPoints: UILabel!
  @IBOutlet weak var championName: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
