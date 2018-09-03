//
//  CategoriesView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/1/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class CategoriesView: GameView {
    
    let categories = GameManagement.sharedInstance.gamesCategories
    let playersList = NetworkSevice.sharedInstance.playerList


    @IBOutlet var contentView: UIView!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("CategoriesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
    @objc func updateUI() {
        let randomIndex = Int(arc4random_uniform(UInt32(categories.count)))
        let randomPlayer = Int(arc4random_uniform(UInt32(playersList.count)))
        categoriesLabel.text =  "Az kategoria a következő: \(categories[randomIndex])"
        playerLabel.text = "Aki a jatékot kezdi : \(playersList[randomPlayer].playerName)"
       
    }
}
