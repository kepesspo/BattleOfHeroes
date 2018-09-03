//
//  MusicRecognizerView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/12/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class MusicRecognizerView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("MusicRecognizerView", owner: self, options: nil)
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
        
    }
}
