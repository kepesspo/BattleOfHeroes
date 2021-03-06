//
//  CheersToTheGovernorView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class CheersToTheGovernorView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cheersToTheGovernorLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("CheersToTheGovernorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)

        let cheersToTheGovernor = NSMutableAttributedString()
        cheersToTheGovernor.appendColored(.white , font: .regular(25), " - Számolj 5-ig.\n").appendColored(.white, font: .regular(25), " - Igyál.\n").appendColored(.white, font: .regular(25), " - Hoz létre szabályt.\n").appendColored(.white, font: .regular(25), " - Majd tartsd be.\n\n").appendColored(.black, font: .regular(25), "Ha nem sikerül akkor is igyál")
        cheersToTheGovernorLabel.attributedText = cheersToTheGovernor
    }
}
