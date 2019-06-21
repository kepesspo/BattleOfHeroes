//
//  ThePeopleChoiceView.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class ThePeopleChoiceView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
    @IBOutlet weak var thePeopleChoiceLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var ifLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var ifBoxView: UIView!
    @IBOutlet weak var orBoxView: UIView!
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
        Bundle.main.loadNibNamed("ThePeopleChoiceView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        ifBoxView.layer.borderColor = UIColor.black.cgColor
        orBoxView.layer.borderColor = UIColor.black.cgColor
        
        ifBoxView.layer.borderWidth = 3
        orBoxView.layer.borderWidth = 3
        
        ifBoxView.layer.cornerRadius = 10
        orBoxView.layer.cornerRadius = 10
        
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        if let player = GameManagement.sharedInstance.getNextGamePlayer() {
            print("Player: \(player.playerName)")
            GameManagement.sharedInstance.actuallyPlayer = player
            GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
            GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
            postNotification(name: .updateGameData)
        }
        thePeopleChoiceLabel.text = "A nép szava dönt!"
        
        ifLabel.text = "akármilyen játékot ingyen letölthetnél"
        orLabel.text = "nem játszhatnál velük, csak napi 30 percet..."
    }
}
