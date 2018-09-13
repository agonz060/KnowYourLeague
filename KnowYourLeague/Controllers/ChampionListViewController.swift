//
//  ChampionViewController.swift
//  KnowYourLeague
//
//  Created by Alex on 9/9/18.
//  Copyright © 2018 PickleRicks. All rights reserved.
//

import UIKit

class ChampionListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var championList = [Champion]()
    
        
    let columnLayout = CVFlowLayout(cellsPerRow: 3, minimumInterItemSpacing: 10, minimumLineSpacing: 10, sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
        // XIB
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "championCell")
        
        ChampionManager.shared.getChampionList { (championList) in
            guard let championList = championList else { return }
            self.championList = championList
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ChampionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return championList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "championCell", for: indexPath) as! CollectionViewCell
        
        let currentChamp = championList[indexPath.row]

        cell.backgroundColor = UIColor.blue
        cell.nameLabel.text = currentChamp.name
        cell.imgView.image = UIImage(named: currentChamp.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toChampionDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChampionDetail" {
            if let viewController = segue.destination as?
                ChampionDetailViewController {
                
                guard let currentRow = collectionView.indexPathsForSelectedItems?.first?.row else { return }
                
                //                guard let currentRow = collectionView.indexPathForSelectedRow?.row else {
                //                    return
                //                }
                
                viewController.currentChampion = championList[currentRow]
                
            }
        }
    }
    
}
