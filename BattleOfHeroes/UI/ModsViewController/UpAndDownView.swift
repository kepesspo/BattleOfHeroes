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
    @IBOutlet weak var descriptionText: UILabel!
    
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
        Bundle.main.loadNibNamed("UpAndDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        descriptionText.text = "Következő szám kisebb vagy nagyobb lesz,mint:"
        
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        //GameManagement.sharedInstance.actuallyPlayerName = playersList[randomIndex].playerName
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "004-teamwork-1.png")
        postNotification(name: .updateGameData)
        
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
            drinksCounter.text = "Piák száma: \(1 * GameManagement.sharedInstance.gameDrinkMultiplier)"
        case 2 ..< 3:
            drinksCounter.text = "Piák száma: \(2 * GameManagement.sharedInstance.gameDrinkMultiplier)"
        case 3 ..< 5:
            drinksCounter.text = "Piák száma: \(3 * GameManagement.sharedInstance.gameDrinkMultiplier)"
        case 5 ..< 7:
            drinksCounter.text = "Piák száma: \(4 * GameManagement.sharedInstance.gameDrinkMultiplier)"
        case 7 ..< 1000:
            drinksCounter.text = "Piák száma: \(5 * GameManagement.sharedInstance.gameDrinkMultiplier)"
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
            GameManagement.sharedInstance.drinkVariation = [drinks * GameManagement.sharedInstance.gameDrinkMultiplier]
            GameManagement.sharedInstance.userDefDrinkVariation = false
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

}
