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
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var letterOneLabel: UILabel!
    @IBOutlet weak var letterTwoLabel: UILabel!
    @IBOutlet weak var letterThreeLabel: UILabel!
    @IBOutlet weak var letterFourLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    var anagrammaList = NetworkSevice.sharedInstance.anagrammaWord
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
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("AnagramView", owner: self, options: nil)
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
        letterOneLabel.isHidden = true
        letterTwoLabel.isHidden = true
        letterThreeLabel.isHidden = true
        letterFourLabel.isHidden = true
        wordLabel.isHidden = true
        timerLabel.isHidden = true
        statButton.setTitle("Start", for: .normal
        )
        let randomWord = anagrammaList.randomElement()?.anagramma
        wordLabel.text = randomWord
        for letter in randomWord ?? "" {
            letterList.append(letter)
        }
        
        var shuffledLetters : [Character] = letterList.shuffled()
        letterOneLabel.text = "\(shuffledLetters[0])"
        letterTwoLabel.text = "\(shuffledLetters[1])"
        letterThreeLabel.text = "\(shuffledLetters[2])"
        letterFourLabel.text = "\(shuffledLetters[3])"
        
    }
    @IBAction func showAnagramAction(_ sender: Any) {
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
        
        if gameTimer != nil {
            gameTimer?.invalidate()
            gameTimer = nil
            wordLabel.isHidden = false
        }
    }
    
}
