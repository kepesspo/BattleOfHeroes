//
//  UpAndDownView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class UpAndDownView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var numberTextLabel: UILabel!
    @IBOutlet weak var drinksCounter: UILabel!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var cardWithValue = GameManagement.sharedInstance.cardWithValue
    let playersList = NetworkSevice.sharedInstance.playerList
    
    var randCardIndex: Int = 0
    var nextRandNumbIndex: Int = 0
    
    var nextButtonValue: Int = 0
    var drinks: Int = 0
    var isLose: Bool = false
    
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
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        Bundle.main.loadNibNamed("UpAndDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let randomPlayer = Int(arc4random_uniform(UInt32(playersList.count)))
        
        //upAndDownTextLabel.text = "Mi lesz a következő szám nagyobb vagy kissebb?"
        playerNameLabel.text = "Aki a jatékot kezdi : \(playersList[randomPlayer].playerName) \n\n Következő szám kisebb vagy nagyobb lesz,mint: (A számok 2-14-ig vannak)"
        updateLevelCounterUI()
        
        
        // First Init randNumb
        randCardIndex = Int(arc4random_uniform(UInt32(cardWithValue.count)))
        let numberValue = Array(cardWithValue.values)[randCardIndex]
        let numberValueImage = Array(cardWithValue.keys)[randCardIndex]
        randCardIndex = numberValue.cardIntValue()
        
        drinksCounter.text = "A Piák száma"
        print("Rand Number: \(numberValue.cardIntValue())")
        uppdateUI(value: numberValue, image: numberValueImage)
        
    }
    
    func uppdateUI(value: CardValue, image : UIImage) {
        if isLose {
            numberTextLabel.text = "Lose \(value.cardIntValue())"
            self.tap.isEnabled = true
        } else {
            numberTextLabel.text = "\(value.cardIntValue())"
            drinks = drinks + 1
        }
        
        switch drinks {
        case 0 ..< 2:
            drinksCounter.text = "Piák száma: 1"
        case 2 ..< 3:
            drinksCounter.text = "Piák száma: 2"
        case 3 ..< 5:
            drinksCounter.text = "Piák száma: 3"
        case 5 ..< 7:
            drinksCounter.text = "Piák száma: 4"
        case 7 ..< 1000:
            drinksCounter.text = "Piák száma: 5"
        default:
            drinksCounter.text = "Az egészet meg kell inni: Szerencséd van"
        }
        
    }
    
    
    
    func showNextRandomNumber() {
        
        nextRandNumbIndex = Int(arc4random_uniform(UInt32(cardWithValue.count)))
        let numberValue = Array(cardWithValue.values)[nextRandNumbIndex]
        let numberValueImage = Array(cardWithValue.keys)[nextRandNumbIndex]
        nextRandNumbIndex = numberValue.cardIntValue()
        print("Next Rand Number: \(numberValue.cardIntValue())")
        
        
        
        if randCardIndex > nextRandNumbIndex && nextButtonValue == 1 {
            randCardIndex = nextRandNumbIndex
            uppdateUI(value: numberValue, image: numberValueImage)
        } else if randCardIndex < nextRandNumbIndex && nextButtonValue == 2 {
            randCardIndex = nextRandNumbIndex
            uppdateUI(value: numberValue, image: numberValueImage)
        } else if randCardIndex == nextRandNumbIndex {
            showNextRandomNumber()
        } else {
            isLose = true
            uppdateUI(value: numberValue, image: numberValueImage)
            downBtn.isHidden = true
            upBtn.isHidden = true
        }
        
    }
    
    @IBAction func downBtnAction(_ sender: Any) {
        nextButtonValue = 1
        showNextRandomNumber()
    }
    
    @IBAction func upBtnAction(_ sender: Any) {
        nextButtonValue = 2
        showNextRandomNumber()
    }
    
    @objc func updateLevelCounterUI() {
        gameInLevelLabel.text = self.levelCounter
    }

}
