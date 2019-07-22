//
//  ShowMeView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/22/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class ShowMeView: GameView {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    
    var gameTimer: Timer?
    var gameRun = false
    var seconds = 45
    var word = ""
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
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("ShowMeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }

    
    @IBAction func downAction(_ sender: Any) {
        wordLabel.text = word
    }
    
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        word = GameManagement.sharedInstance.activityWordList.randomElement()!
        let showMe = NSMutableAttributedString()
        showMe.appendColored(.black , font: .regular(20), "Csak a mutogatás érvényes\n\n").appendColored(.black, font: .regular(22), "Vedd magadhóz a telefont és nézd meg.(Long Tap)")
        gameLabel.attributedText = showMe
        self.tap.isEnabled = false
    }
    
    @IBAction func startTapped(_ sender: Any) {
        if gameRun {
           wordLabel.text = "Mutasd"
        } else {
            wordLabel.text = "Mutasd"
            gameRun = true
            timerLabel.isHidden = true
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func runTimedCode() {
        if seconds == 0 {
            stopTimer()
            gameRun = false
            self.tap.isEnabled = true
            startButton.isEnabled = false
            timerLabel.text = "Vége"
            wordLabel.text = word
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
