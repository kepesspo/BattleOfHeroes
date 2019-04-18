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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timerOneLabel: UILabel!
    @IBOutlet weak var timerTwoLabel: UILabel!
    @IBOutlet weak var timerOneButton: UIButton!
    @IBOutlet weak var timerTwoButton: UIButton!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var tapperText: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    
    
    var second : Double = 5.00
    var firstPlayerTapped : Bool = false
    var secondPlayerTapped : Bool = false
    let playersList = NetworkSevice.sharedInstance.playerList

    weak var timer: Timer?
    var gameStartTime: Data?
    var gameEnd: Bool = false
    var gameTime: Date = Date()
    var playerOneTime: Date = Date()
    var playerTwoTime : Date = Date()
    var isGameStarted: Bool = false
    
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
        Bundle.main.loadNibNamed("TapperView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        gameInfoContainerView.layer.cornerRadius = 10
        playerLabel.text = playersList.randomElement()?.playerName
        playerType.text = "Battle"
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
        secondPlayerTapped = true
        checkGameStart()
    }
    
    @IBAction func timerOneDownTap(_ sender: Any) {
        print("First player pressed button")
        firstPlayerTapped = true
        checkGameStart()
        
    }
    
    @IBAction func timerTwoTouchUpAction(_ sender: Any) {
        secondPlayerTapped = false
        if gameEnd {
            print("Second Player lose")
        } else {
            if isGameStarted {
                if firstPlayerTapped == false {
                    timerTwoButton.isEnabled = false
                    playerTwoTime = Date()
                    stopTimer()
                } else {
                    timerTwoButton.isEnabled = false
                    playerTwoTime = Date()
                }
                
            }
            
        }
    }
    
    @IBAction func timerOneTouchUpAction(_ sender: Any) {
        firstPlayerTapped = false
        if gameEnd {
            print("First Player lose")
        } else {
            if isGameStarted {
                if secondPlayerTapped == false {
                    timerOneButton.isEnabled = false
                    playerOneTime = Date()
                    stopTimer()
                } else {
                    timerOneButton.isEnabled = false
                    playerOneTime = Date()
                }
                
            }
        }
    }
    
    func checkGameStart() {
        if secondPlayerTapped && firstPlayerTapped {
            isGameStarted = true
            gameTime = Date()
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        }
    }
    
    @objc func runTimedCode() {
        if second <= 0 {
            gameEnd = true
            stopTimer()
        } else {
            second -= 0.05
            let timeString = String(format: "%.3f", second)
            timerTwoLabel.text = "\(timeString)"
            timerOneLabel.text = "\(timeString)"
        }
    }
    
    func result() {
        self.tap.isEnabled = true
        separateView.isHidden = true
        let playerOneRes = 5 - abs(Double((playerOneTime.timeIntervalSince(gameTime))))
        let playerTwoRes = 5 - abs(Double((playerTwoTime.timeIntervalSince(gameTime))))
        //timerTwoLabel.text = String(format: "%.4f", playerTwoRes)
        //timerOneLabel.text = String(format: "%.4f", playerOneRes)
        
        if playerTwoTime.timeIntervalSince(gameTime) > 0 {
            timerTwoLabel.text = "\(String(format: "%.4f", playerTwoRes))"
        } else {
            timerTwoLabel.text = "Kifutottál az időből"
        }
        if playerOneTime.timeIntervalSince(gameTime) > 0 {
            timerOneLabel.text = "\(String(format: "%.4f", playerOneRes))"
        } else {
            timerOneLabel.text = "Kifutottál az időből"
        }
        
        winnerLabel.isHidden = false
        if playerTwoTime.timeIntervalSince(gameTime) > 0 && playerOneTime.timeIntervalSince(gameTime) > 0 {
            if playerTwoRes < playerOneRes && playerTwoRes > 0 {
                winnerLabel.text = "Player Two nyert"
            } else {
                winnerLabel.text = "Player One nyert"
            }
            
        } else if playerTwoTime.timeIntervalSince(gameTime) < 0 && playerOneTime.timeIntervalSince(gameTime) > 0 {
             winnerLabel.text = "Player One nyert"
        } else if playerOneTime.timeIntervalSince(gameTime) < 0 && playerTwoTime.timeIntervalSince(gameTime) > 0 {
            winnerLabel.text = "Player Two nyert"
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
