//
//  EverybodyDrinksView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/2/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit


class EverybodyDrinksView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var everybodyDrinksTextLabel: UILabel!
    @IBOutlet weak var howDrinksTextLabel: UILabel!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    @IBOutlet weak var playerType: UILabel!
    
    var playerList = NetworkSevice.sharedInstance.playerList
    
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

        Bundle.main.loadNibNamed("EverybodyDrinksView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        sequencedPlayer()
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateUI() {
        gameInfoContainerView.layer.cornerRadius = 10
        everybodyDrinksTextLabel.text = "Fenékig"
        playerType.text = "Personal"
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
    func sequencedPlayer() {
        var playerIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex
        if playerIndex + 1 > playerList.count {
            GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex = 0
            
            playerIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex
            GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex + 1
            howDrinksTextLabel.text = playerList[playerIndex].playerName
        } else {
            GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex + 1
            howDrinksTextLabel.text = playerList[playerIndex].playerName
        }
    }
    
     
    
    
}

