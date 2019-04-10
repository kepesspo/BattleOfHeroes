//
//  CollectAndBoomView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class CollectAndBoomView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var collectAndBoomCollectionView: UICollectionView!
    @IBOutlet weak var drinkCounterLabel: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    
    var shuffledElements = [0,0,0,1,1,1,2,2,2].shuffled()
    var selected = [false,false,false,false,false,false,false,false,false]
    var drinkCount = 1
    let playersList = NetworkSevice.sharedInstance.playerList
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("CollectAndBoomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectAndBoomCollectionView.register(UINib.init(nibName: "CollectAndBoomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectAndBoomCollectionViewCell")
        collectAndBoomCollectionView.dataSource = self
        collectAndBoomCollectionView.delegate = self
        collectAndBoomCollectionView.allowsSelection = true
        drinkCounterLabel.text = ""
        updateLevelCounterUI()
        updateUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        gameInfoContainerView.layer.cornerRadius = 10
        playerLabel.text = playersList.randomElement()?.playerName
        playerType.text = "Line"
    }
}


extension CollectAndBoomView : UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectAndBoomCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectAndBoomCollectionViewCell", for: indexPath) as! CollectAndBoomCollectionViewCell
        cell.cellSelected = selected[indexPath.row]
        
        switch shuffledElements[indexPath.row] {
        case 0:
            cell.valueImageView.image = UIImage(named: "001-bomb")
        case 1:
            cell.valueImageView.image = UIImage(named: "001-number-1")
        case 2:
            cell.valueImageView.image = UIImage(named: "002-number-2")
        default:
            cell.valueImageView.image = UIImage(named: "")
        }
        
        cell.configure(with: shuffledElements[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.cellForItem(at: indexPath) as? CollectAndBoomCollectionViewCell) != nil {
            selected[indexPath.row] = true
            let selectedElementValue = shuffledElements[indexPath.row]
            if selectedElementValue == 0 {
                collectionView.allowsSelection = false
                collectionView.isUserInteractionEnabled = false
                self.tap.isEnabled = true
                drinkCounterLabel.text = "Amit meg kell inni : \(drinkCount)"
                print("Boom game ended")
                GameManagement.sharedInstance.drinkVariation = [drinkCount]
                GameManagement.sharedInstance.userDefDrinkVariation = false
            } else {
                print("Game continue")
                drinkCount += selectedElementValue
                drinkCounterLabel.text = "Amit meg kell inni : \(drinkCount)"
                
            }
        }
        
        collectAndBoomCollectionView.reloadData()
    }
    
    
}

extension CollectAndBoomView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectAndBoomCollectionView.bounds.width / 3 - 20, height: collectAndBoomCollectionView.bounds.width / 3 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    
    
}

