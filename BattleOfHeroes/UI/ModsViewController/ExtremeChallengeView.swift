//
//  ExtremeChallengeView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/12/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import MDCCommon

class ExtremeChallengeView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var extremeLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("ExtremeChallengeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
    }
    
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
        let extremeChallenge = NSMutableAttributedString()
        extremeChallenge.appendColored(.black , font: .regular(20), "Válasz egy témakört, hivj ki valakit és mond mennyi szot tudsz az adott témakörben \n\n").appendColored(.red, font: .regular(22), "A kihivó dönt hogy elfogadja vagy ő tud többet.\n\n").appendColored(.black, font: .regular(20), "Az nyer akinek igaza lesz")
        extremeLabel.attributedText = extremeChallenge
        
        timerLabel.isHidden = true
    }
    
    @IBAction func startTapped(_ sender: Any) {
        startButton.isHidden = true
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
