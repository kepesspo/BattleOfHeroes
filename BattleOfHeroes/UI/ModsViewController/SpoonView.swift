//
//  SpoonView.swift
//  BattleOfHeroes
//
//  Created by Mark on 10/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class SpoonView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var spoonLabel: UILabel!
    
    var trueOrFalseText : String?
    var gameTimer: Timer?
    var seconds = 6
    
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
        Bundle.main.loadNibNamed("SpoonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        spoonLabel.text = ""
    }
}
