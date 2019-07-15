//
//  TwentyOneView.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/20/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class TwentyOneView: GameView {

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
        Bundle.main.loadNibNamed("TwentyOneView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
        let twentyOne = NSMutableAttributedString()
        twentyOne.appendColored(.black , font: .regular(20), "Kezdj el számolni 1-től majd a töled jobbra ülő következik\n\n").appendColored(.red, font: .regular(22), "Ősszesen 3-om számot mondhatsz a lényeg hogy egymást kövessék\n\n").appendColored(.black, font: .regular(20), "Aki a végén kimondja a 21-et az vesztet")
       gameLabel.attributedText = twentyOne
    }
}
