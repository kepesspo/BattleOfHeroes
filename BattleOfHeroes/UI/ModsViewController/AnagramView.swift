//
//  AnagramView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class AnagramView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var letterOneLabel: UILabel!
    @IBOutlet weak var letterTwoLabel: UILabel!
    @IBOutlet weak var letterThreeLabel: UILabel!
    @IBOutlet weak var letterFourLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    var anagrammaList = NetworkSevice.sharedInstance.anagrammaWord
    let playersList = NetworkSevice.sharedInstance.playerList

    @IBOutlet weak var letterOneImageView: UIImageView!
    @IBOutlet weak var lettertwoImageView: UIImageView!
    @IBOutlet weak var letterThreeImageView: UIImageView!
    @IBOutlet weak var letterFourImageView: UIImageView!
    var letterList : [Character] = []
    
    
    var gameTimer: Timer?
    var seconds = 4
    
    
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
        Bundle.main.loadNibNamed("AnagramView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }

    
    func updateUI() {
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        GameManagement.sharedInstance.actuallyPlayerName = playersList[randomIndex].playerName
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea")
        postNotification(name: .updateGameData)
        letterOneImageView.isHidden = true
        lettertwoImageView.isHidden = true
        letterThreeImageView.isHidden = true
        letterFourImageView.isHidden = true
        
        
        
        letterOneLabel.isHidden = true
        letterTwoLabel.isHidden = true
        letterThreeLabel.isHidden = true
        letterFourLabel.isHidden = true
        wordLabel.isHidden = true
        timerLabel.isHidden = true

        
        statButton.setTitle("Start", for: .normal)
        let randomWord = anagrammaList.randomElement()?.anagramma
        let upperWord = randomWord?.uppercased()
        wordLabel.text = upperWord
        for letter in upperWord ?? "" {
            letterList.append(letter)
        }
        
        var shuffledLetters : [Character] = letterList.shuffled()
        letterOneLabel.text = "\(shuffledLetters[0])"
        letterTwoLabel.text = "\(shuffledLetters[1])"
        letterThreeLabel.text = "\(shuffledLetters[2])"
        letterFourLabel.text = "\(shuffledLetters[3])"
        
    }
    @IBAction func showAnagramAction(_ sender: Any) {
        letterOneImageView.isHidden = false
        lettertwoImageView.isHidden = false
        letterThreeImageView.isHidden = false
        letterFourImageView.isHidden = false
        
        letterOneLabel.isHidden = false
        letterTwoLabel.isHidden = false
        letterThreeLabel.isHidden = false
        letterFourLabel.isHidden = false
        timerLabel.isHidden = false
        statButton.isHidden = true
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func runTimedCode() {
        if seconds == 0 {
            stopTimer()
            self.tap.isEnabled = true
        } else {
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }
    
    func stopTimer() {
        statButton.isEnabled = false
        timerLabel.isHidden = true
        if gameTimer != nil {
            gameTimer?.invalidate()
            gameTimer = nil
            wordLabel.isHidden = false
        }
    }
    
}
