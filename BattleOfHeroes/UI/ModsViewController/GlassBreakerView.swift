//
//  GlassBreakerView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/12/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class GlassBreakerView: GameView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var gameLabel: UILabel!
    
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
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("GlassBreakerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
        let fastNumber = NSMutableAttributedString()
        fastNumber.appendColored(.black , font: .regular(20), "Törj őssze minnál több üvegkockát\n\n").appendColored(.red, font: .regular(22), "He ez a szám több mint 50\n\n").appendColored(.black, font: .regular(20), "Akkor nyertél")
        gameLabel.attributedText = fastNumber
        self.tap.isEnabled = true
    }
}
