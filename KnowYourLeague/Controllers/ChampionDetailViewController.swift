//
//  ChampionDetailViewController.swift
//  KnowYourLeague
//
//  Created by Alex on 9/11/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import UIKit
import Charts

class ChampionDetailViewController: UIViewController {

    @IBOutlet weak var splashImageView: UIImageView!
    var currentChampion: Champion?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var blurbLabel: UILabel!
    
    
    @IBOutlet weak var radarChartView: RadarChartView!
    
    var attackDataEntry = RadarChartDataEntry(value: 10.0)
    var defenseDataEntry = RadarChartDataEntry(value: 20.0)
    var magicDataEntry = RadarChartDataEntry(value: 30.0)
    var difficultyDataEntry = RadarChartDataEntry(value: 40.0)
    
    var dataEntries = [RadarChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let champion = currentChampion else { return }
        
        splashImageView.image = UIImage(named: champion.image+"_0")
        nameLabel.text = champion.name
        titleLabel.text = champion.title
        blurbLabel.text = champion.blurb
        tagsLabel.text = champion.tags.compactMap({ $0 }).joined(separator: ", ")
        
        radarChartView.chartDescription?.text = "Hey!"
        
        attackDataEntry.value = Double(champion.info.attack)
        attackDataEntry.accessibilityLabel = "Attack"
        defenseDataEntry.value = Double(champion.info.defense)
        magicDataEntry.value = Double(champion.info.magic)
        difficultyDataEntry.value = Double(champion.info.difficulty)
        
        dataEntries = [attackDataEntry, defenseDataEntry, magicDataEntry, difficultyDataEntry]
        
        updateChartData()
        

    }
    
    func updateChartData() {
        
        radarChartView.innerWebLineWidth = 2.0
        radarChartView.webColor = UIColor.blue
        
        let chartDataSet = RadarChartDataSet(values: dataEntries, label: "Hola")
        let chartData = RadarChartData(dataSet: chartDataSet)
        
        radarChartView.data = chartData
    }
    
}
