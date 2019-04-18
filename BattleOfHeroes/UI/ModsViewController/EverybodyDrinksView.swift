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
        Bundle.main.loadNibNamed("EverybodyDrinksView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        sequencedPlayer()
        updateUI()
        
    }
    
    @objc func updateUI() {
        everybodyDrinksTextLabel.text = "Most ő iszik"
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
        postNotification(name: .updateGameData)
        
    }
    
    
    func sequencedPlayer() {
        var playerIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex
        if playerIndex + 1 > playerList.count {
            GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex = 0
            
            playerIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex
            GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex + 1
            GameManagement.sharedInstance.actuallyPlayerName  = playerList[playerIndex].playerName
        } else {
            GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex = GameManagement.sharedInstance.everyBodyDrinksPlayerCountIndex + 1
            GameManagement.sharedInstance.actuallyPlayerName  = playerList[playerIndex].playerName
        }
    }
    
     
    
    
}

