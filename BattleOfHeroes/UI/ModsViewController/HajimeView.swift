//
//  HajimeView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/2/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class HajimeView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hajimeTextLabel: UILabel!
    @IBOutlet weak var HajimeTitleText: UILabel!
    
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
        Bundle.main.loadNibNamed("HajimeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
        
    }

    @objc func updateUI() {
        
        let hajime = NSMutableAttributedString()
        hajime.appendColored(.black,font: .regular(20), "A következő számok helyett mondd:\n ").appendColored(.red, font: .regular(22), "HAJIME")
        HajimeTitleText.attributedText = hajime
        
        let numbers = NSMutableAttributedString()
        numbers.appendColored(.black, font: .regular(20), "- bármelyik szám, amely tartalmazza\naz 5 és 7 számokat").appendColored(.red, font: .regular(22), "(7,17,27...) \n").appendColored(.black, font: .regular(20), "\n- bármely szám mely osztható 5-tel \nvagy 7-tel").appendColored(.red, font: .regular(22), "(14,15,20...)").appendColored(.black, font: .regular(20), "\n\n- minden egyes ").appendColored(.red, font: .regular(22), "HAJIME").appendColored(.black, font: .regular(20), "-nél a kör megfordul.")
        hajimeTextLabel.attributedText = numbers
        
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
    }
    
     
}
