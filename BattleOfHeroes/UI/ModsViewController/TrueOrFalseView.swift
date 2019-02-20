//
//  TrueOrFalseView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/27/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class TrueOrFalseView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var trueOrFalseLabel: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    
    var trueOrFalseList = NetworkSevice.sharedInstance.trueOrFalse
    var trueOrFalseText : String?
    let playersList = NetworkSevice.sharedInstance.playerList
    
    var gameTimer: Timer?
    var seconds = 6
    var gameIndex = 0
    
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
        Bundle.main.loadNibNamed("TrueOrFalseView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let randomIndex = Int(arc4random_uniform(UInt32(trueOrFalseList.count)))
        gameIndex = randomIndex
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {

        gameInLevelLabel.text = self.levelCounter
        
    }
    
    func updateUI() {
        
        trueOrFalseLabel.text = trueOrFalseList[gameIndex].question
        playerType.text = "Personal"
        gameInfoContainerView.layer.cornerRadius = 10
        let randomPlayer = Int(arc4random_uniform(UInt32(playersList.count)))
        playerLabel.text = playersList[randomPlayer].playerName
        GameManagement.sharedInstance.personWhoDrinks = [playersList[randomPlayer].playerName]
        GameManagement.sharedInstance.personDrinkCount = 1
        GameManagement.sharedInstance.gameSTW = true
    }
    
    @IBAction func startBtnAction(_ sender: Any) {
        startBtn.isHidden = true
        startLabel.isHidden = true
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc func runTimedCode() {
        if seconds == 0 {
            timer.text = trueOrFalseList[gameIndex].answer
            stopTimer()
            self.tap.isEnabled = true
        } else {
            seconds -= 1
            timer.text = "\(seconds)"
        }
    }
    
    func stopTimer() {
        if gameTimer != nil {
            gameTimer?.invalidate()
            gameTimer = nil
        }
    }
}
