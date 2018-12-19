//
//  SpoonView.swift
//  BattleOfHeroes
//
//  Created by Mark on 10/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

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
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        
        self.tap.isEnabled = true
        Bundle.main.loadNibNamed("SpoonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
    func updateUI() {
        spoonLabel.text = ""
    }
}
