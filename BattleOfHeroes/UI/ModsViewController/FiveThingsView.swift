//
//  FiveThingsView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class FiveThingsView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var category = GameManagement.sharedInstance.gamesCategories
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
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("FiveThingsView", owner: self, options: nil)
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
        categoryLabel.isHidden = true
        timerLabel.isHidden = true
    }
    
    @IBAction func startTapped(_ sender: Any) {
        categoryLabel.isHidden = false
        startButton.isHidden = true
        categoryLabel.text = category.randomElement()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func runTimedCode() {
        if seconds == 0 {
            stopTimer()
            self.tap.isEnabled = true
        } else {
            seconds -= 1
            timerLabel.isHidden = false
            timerLabel.text = "\(seconds)"
        }
    }
    
    func stopTimer() {
        if gameTimer != nil {
            gameTimer?.invalidate()
            gameTimer = nil
        }
    }
}
