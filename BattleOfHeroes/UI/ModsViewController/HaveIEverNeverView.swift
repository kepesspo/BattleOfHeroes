//
//  HaveIEverNeverView.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class HaveIEverNeverView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var haveIEverNeverLabel: UILabel!
    
    var trueOrFalseText : String?
    var gameTimer: Timer?
    var seconds = 6
    var haveIEverNeverList = NetworkSevice.sharedInstance.haveIEverNever
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
        self.tap.isEnabled = true
        Bundle.main.loadNibNamed("HaveIEverNeverView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    
    func updateUI() {
        let randomIndex = Int(arc4random_uniform(UInt32(haveIEverNeverList.count)))
        haveIEverNeverLabel.text = haveIEverNeverList[randomIndex].question
        
        let randomIndexForPlayer = Int(arc4random_uniform(UInt32(playersList.count)))
        GameManagement.sharedInstance.actuallyPlayerName = playersList[randomIndexForPlayer].playerName
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "004-teamwork-1.png")
        postNotification(name: .updateGameData)
        
    }
}
