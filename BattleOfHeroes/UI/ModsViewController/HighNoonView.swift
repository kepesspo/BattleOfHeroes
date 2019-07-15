//
//  HighNoonView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/12/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import AVFoundation

class HighNoonView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playerOneButton: UIButton!
    @IBOutlet weak var playerTwoButton: UIButton!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var firstPlayerTapped : Bool = false
    var secondPlayerTapped : Bool = false
    var isGameStarted: Bool = false
    var drinkIsOn = false
    
    let randomInterval = 3...15
    var timer : Timer?
    var endTime = 0
    var endGame = false
    
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
        Bundle.main.loadNibNamed("HighNoonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)

        gameLabel.text = "Nyomd a gombot várd a jelzést majd igyál és légy te a gyorsabb."
        playerTwoButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        contentView.layer.masksToBounds = true
    }
    
    @IBAction func timerTwoDownTap(_ sender: Any) {
        if drinkIsOn {
            print("Player 2 nyert")
            winnerLabel.text = "Player 2 nyert"
            playerOneButton.isEnabled = false
            playerTwoButton.isEnabled = false
            self.tap.isEnabled = true
        }
        print("Second player pressed button")
        secondPlayerTapped = true
        checkGameStart()
    }
    
    @IBAction func timerOneDownTap(_ sender: Any) {
        if drinkIsOn {
            print("Player 1 nyert")
            winnerLabel.text = "Player 1 nyert"
            playerOneButton.isEnabled = false
            playerTwoButton.isEnabled = false
            self.tap.isEnabled = true
        }
        print("First player pressed button")
        firstPlayerTapped = true
        checkGameStart()
        
    }
    
    
    @IBAction func timerTwoTouchUpAction(_ sender: Any) {
        secondPlayerTapped = false
        if isGameStarted {
            print("Second Player lose")
            winnerLabel.text = "Player 2 vesztett"
            endGame = true
            stopTimer()
        } else {
            print("")
        }
    }
    
    @IBAction func timerOneTouchUpAction(_ sender: Any) {
        firstPlayerTapped = false
        if isGameStarted {
            print("First Player lose")
            winnerLabel.text = "Player 1 vesztett"
            endGame = true
            stopTimer()
        } else {
            print("")
        }
    }
    
    func checkGameStart() {
        if secondPlayerTapped && firstPlayerTapped {
            print("Game Start")
            isGameStarted = true
            let randomTime = randomInterval.randomElement()
            endTime = randomTime ?? 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
            print(randomTime)
        }
    }
    
    @objc func runTimedCode() {
        if endTime == 0 {
            isGameStarted = false
            stopTimer()
            self.tap.isEnabled = true
        } else {
            endTime -= 1
            print(endTime)
        }
    }
    
    func stopTimer() {
        winnerLabel.text = "Igyál"
        playSound()
        drinkIsOn = true
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    func playSound() {
        let systemSoundID: SystemSoundID = 1014
        AudioServicesPlaySystemSound (systemSoundID)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
