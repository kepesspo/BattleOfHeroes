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
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
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
        let randomPlayer = Int(arc4random_uniform(UInt32(playersList.count)))
        GameManagement.sharedInstance.actuallyPlayerName = playersList[randomPlayer].playerName
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
        postNotification(name: .updateGameData)
        
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("TrueOrFalseView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(trueOrFalseList.count)))
        gameIndex = randomIndex
        trueOrFalseLabel.text = trueOrFalseList[gameIndex].question
        falseButton.isEnabled = false
        trueButton.isEnabled = false
        
    }
    
    @IBAction func startBtnAction(_ sender: Any) {
        startBtn.isHidden = true
        startLabel.isHidden = true
        
        falseButton.isEnabled = true
        trueButton.isEnabled = true
        
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
        falseButton.isEnabled = false
        trueButton.isEnabled = false
        if gameTimer != nil {
            gameTimer?.invalidate()
            gameTimer = nil
        }
    }
    
    @IBAction func trueButtonAction(_ sender: Any) {
        falseButton.isHidden = true
        trueButton.isEnabled = false
    }
    
    @IBAction func falseButtonAction(_ sender: Any) {
        trueButton.isHidden = true
        falseButton.isEnabled = false
    }
}
