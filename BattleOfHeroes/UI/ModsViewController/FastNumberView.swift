//
//  FastNumberView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/15/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class FastNumberView: GameView {
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
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
        Bundle.main.loadNibNamed("FastNumberView", owner: self, options: nil)
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
        fastNumber.appendColored(.black , font: .regular(20), "Kezdj el számolni 1-től. mindenki csak egy számot mondhat\n\n").appendColored(.red, font: .regular(22), "Ha úgyan azt a számot mondjátok akkor innotok kell\n\n").appendColored(.black, font: .regular(20), "Aki a végén kimondja a 10-et az vesztet")
        gameLabel.attributedText = fastNumber
    }
}
