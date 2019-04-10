//
//  RingOfFireView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class RingOfFireView : GameView {
    @IBOutlet weak var ringOfFireLabelText: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    
    @IBOutlet weak var card1Btn: UIButton!
    @IBOutlet weak var card2Btn: UIButton!
    @IBOutlet weak var card3Btn: UIButton!
    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var nextPlayer: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    
    var cardsCopy = GameManagement.sharedInstance.copyCards
    var savedCard : UIImage?
    var savedCardString: String?
    
    var playerList = NetworkSevice.sharedInstance.playerList
    
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

        Bundle.main.loadNibNamed("RingOfFireView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addImgToCard()
        updateLevelCounterUI()
        updateUI()
        
        if cardsCopy.count == 0 {
            GameManagement.sharedInstance.copyCards = GameManagement.sharedInstance.cards
            cardsCopy = GameManagement.sharedInstance.copyCards
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(cardsCopy.count)))
        let image = Array(cardsCopy.keys)[randomIndex]
        let rule = Array(cardsCopy.values)[randomIndex]
        
        
        addCardTobtn(image: image, rule: rule)
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        //ringOfFireLabelText.text = "Ring Of Fire"
        playerType.text = "Group"
        
        gameInfoContainerView.layer.cornerRadius = 10
    }
    
    func addImgToCard() {
        card1Btn.setBackgroundImage(#imageLiteral(resourceName: "kartya1"), for: .normal)
        card2Btn.setBackgroundImage(#imageLiteral(resourceName: "kartya2"), for: .normal)
        card3Btn.setBackgroundImage(#imageLiteral(resourceName: "kartya3"), for: .normal)
    }
    
    
    func addCardTobtn(image: UIImage, rule: CardValue){
        savedCard = image
        savedCardString = rule.rulesString()
        sequencedPlayer()
        GameManagement.sharedInstance.copyCards.removeValue(forKey: savedCard!)
        
    }
    
    func showTheCardAndRule(imageBtn: UIButton) {
        imageBtn.setBackgroundImage(savedCard, for: .normal)
        ruleLabel.text = savedCardString
        UIView.transition(with: imageBtn, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        cardStackView.isUserInteractionEnabled = false
        cardsCopy = GameManagement.sharedInstance.copyCards
        print(cardsCopy.count)
        GameManagement.sharedInstance.drinkVariation = [0,1,2,3]
        
    }
    
    @IBAction func card1BtnAction(_ sender: Any) {
        showTheCardAndRule(imageBtn: card1Btn)
    }
    
    @IBAction func card2BtnAction(_ sender: Any) {
        showTheCardAndRule(imageBtn: card2Btn)
        
    }
    
    @IBAction func card3BtnAction(_ sender: Any) {
        showTheCardAndRule(imageBtn: card3Btn)
        
    }
    
    func sequencedPlayer() {
        let player : String = ""
        var playerIndex = GameManagement.sharedInstance.ringOfFirePlayerCountIndex
        if playerIndex + 1 > playerList.count {
            GameManagement.sharedInstance.ringOfFirePlayerCountIndex = 0
            
            playerIndex = GameManagement.sharedInstance.ringOfFirePlayerCountIndex
            GameManagement.sharedInstance.ringOfFirePlayerCountIndex = GameManagement.sharedInstance.ringOfFirePlayerCountIndex + 1
            nextPlayer.text = playerList[playerIndex].playerName
        } else {
            GameManagement.sharedInstance.ringOfFirePlayerCountIndex = GameManagement.sharedInstance.ringOfFirePlayerCountIndex + 1
            nextPlayer.text = playerList[playerIndex].playerName
        }
    }
    
    
}
