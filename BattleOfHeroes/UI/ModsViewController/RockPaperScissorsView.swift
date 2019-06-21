//
//  RockPaperScissorsView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/13/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class RockPaperScissorsView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rockPaperScissorsViewLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("RockPaperScissorsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        if let player = GameManagement.sharedInstance.getNextGamePlayer() {
            print("Player: \(player.playerName)")
            GameManagement.sharedInstance.actuallyPlayer = player
            GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
            GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
            postNotification(name: .updateGameData)
        }
        
        let rockPaperScissors = NSMutableAttributedString()
        rockPaperScissors.appendColored(.black , font: .regular(20), "A játékot kezdéséhez válassz egy játékost jobbról vagy balról akivel megküzdesz\n\n").appendColored(.red, font: .regular(22), "- győzelemnél nem kell innod\n").appendColored(.red, font: .regular(22), " - vereségnél innod kell és megint rajtad a sor\n\n").appendColored(.black, font: .regular(20), "5 csata után a büntetéseket meg kell inni")
        rockPaperScissorsViewLabel.attributedText = rockPaperScissors
    }
}
