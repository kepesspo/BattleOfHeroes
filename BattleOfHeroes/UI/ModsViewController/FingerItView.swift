//
//  FingerItView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/13/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class FingerItView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var fingerItViewLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("FingerItView", owner: self, options: nil)
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
        
        let fingerIt = NSMutableAttributedString()
        fingerIt.appendColored(.black , font: .regular(20), "Kezeket az asztalra\n számolj 3-ig majd mondj egy számot\n\n").appendColored(.red, font: .regular(22), "- ha jó a szám akkor megusztad és válasz uj játékost\n").appendColored(.red, font: .regular(22), "- ha rossz a szám akkor innod kell és megint te jössz\n\n").appendColored(.black, font: .regular(20), "5 kört kell játszani")
        fingerItViewLabel.attributedText = fingerIt   
    }
}
