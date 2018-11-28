//
//  HaveIEverNeverView.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class HaveIEverNeverView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var haveIEverNeverLabel: UILabel!
    @IBOutlet weak var gameInLevelLabel: UILabel!

    var trueOrFalseText : String?
    var gameTimer: Timer?
    var seconds = 6
    var haveIEverNeverList = NetworkSevice.sharedInstance.haveIEverNever
    
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
        Bundle.main.loadNibNamed("HaveIEverNeverView", owner: self, options: nil)
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
        let randomIndex = Int(arc4random_uniform(UInt32(haveIEverNeverList.count)))
        haveIEverNeverLabel.text = haveIEverNeverList[randomIndex].question
    }
}
