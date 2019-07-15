//
//  FiveThingsView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class FiveThingsView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var boardImageView: UIImageView!
    
    let playersList = NetworkSevice.sharedInstance.playerList
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
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("FiveThingsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
    }
    
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
        categoryLabel.isHidden = true
        boardImageView.isHidden = true
        timerLabel.isHidden = true
    }
    
    @IBAction func startTapped(_ sender: Any) {
        categoryLabel.isHidden = false
        startButton.isHidden = true
        boardImageView.isHidden = false
        categoryLabel.text = category.randomElement()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func runTimedCode() {
        if seconds == 0 {
            stopTimer()
            self.tap.isEnabled = true
            timerLabel.text = "Vége"
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
