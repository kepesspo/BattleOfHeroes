//
//  TapperView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class TapperView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var tapperText: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timerOneLabel: UILabel!
    @IBOutlet weak var timerTwoLabel: UILabel!
    @IBOutlet weak var timerOneButton: UIButton!
    @IBOutlet weak var timerTwoButton: UIButton!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    var second : Double = 5.00
    var firstPlayrTap : Bool = false
    var secondPlayrTap : Bool = false
    
    weak var timer: Timer?
    var gameStartTime: Data?
    var gameEnd: Bool = false
    var gameTime: Date = Date()
    var playerOneTime: Date = Date()
    var playerTwoTime : Date = Date()
    
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
        Bundle.main.loadNibNamed("TapperView", owner: self, options: nil)
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
        tapperText.text = "Légy te a legközelebb a 0-hoz."
        timerOneLabel.text = "Start"
        timerTwoLabel.text = "Start"
        winnerLabel.isHidden = true
        containerView.layer.cornerRadius = 6
        timerTwoLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        timerTwoButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    @IBAction func timerTwoDownTap(_ sender: Any) {
        print("Second player pressed button")
        secondPlayrTap = true
        checkGameStart()
    }
    
    @IBAction func timerOneDownTap(_ sender: Any) {
        print("First player pressed button")
        firstPlayrTap = true
        checkGameStart()
        
    }
    
    @IBAction func timerTwoTouchUpAction(_ sender: Any) {
        secondPlayrTap = false
        if gameEnd {
            print("Second Player lose")
        } else {
            playerTwoTime = Date()
        }
    }
    
    @IBAction func timerOneTouchUpAction(_ sender: Any) {
        firstPlayrTap = false
        if gameEnd {
            print("First Player lose")
        } else {
            playerOneTime = Date()
        }
    }
    
    func checkGameStart() {
        if secondPlayrTap && firstPlayrTap {
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        }
    }
    
    @objc func runTimedCode() {
        if second <= 0 {
            gameEnd = true
            gameTime = Date()
            stopTimer()
            
            self.tap.isEnabled = true
        } else {
            second -= 0.05
            let timeString = String(format: "%.3f", second)
            timerTwoLabel.text = "\(timeString)"
            timerOneLabel.text = "\(timeString)"
            
        }
    }
    
    func result() {
        separateView.isHidden = true
        let playerOneRes = abs(Double((playerOneTime.timeIntervalSince(gameTime))))
        let playerTwoRes = abs(Double((playerTwoTime.timeIntervalSince(gameTime))))
        timerTwoLabel.text = String(format: "%.4f", playerTwoRes)
        timerOneLabel.text = String(format: "%.4f", playerOneRes)
        
        winnerLabel.isHidden = false
        if playerTwoRes < playerOneRes && playerTwoRes > 0 {
            winnerLabel.text = "Player Two nyert"
        } else if playerTwoRes > playerOneRes && playerOneRes > 0 {
            winnerLabel.text = "Player One nyert"
        } else {
            winnerLabel.text = "Senki sem nyert"
            timerTwoLabel.text = "Lose"
            timerOneLabel.text = "Lose"
        }
    }
    
    func stopTimer() {
        timerOneButton.isHidden = true
        timerTwoButton.isHidden = true
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        result()
    }
    
    
}
