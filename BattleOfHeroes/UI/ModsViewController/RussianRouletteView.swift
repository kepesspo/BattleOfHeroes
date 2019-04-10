//
//  RussianRouletteView.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/20/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class RussianRouletteView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var russianRouletteLabel: UILabel!
    
    @IBOutlet weak var optionOneBtn: LottieView!
    @IBOutlet weak var optionTwoBtn: LottieView!
    @IBOutlet weak var optionThreeBtn: LottieView!
    @IBOutlet weak var optionesStackView: UIStackView!
    @IBOutlet weak var gameInfoContainerView: UIView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var elements = ["drink","favourite_app_icon","favourite_app_icon"]
    
    let playersList = NetworkSevice.sharedInstance.playerList
    
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
        Bundle.main.loadNibNamed("RussianRouletteView", owner: self, options: nil)
        
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        for button in [optionOneBtn, optionTwoBtn, optionThreeBtn] {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(generateOptions(_:)))
            button?.addGestureRecognizer(gesture)
        }
        
        updateLevelCounterUI()
        updateUI()
    }
    
    @objc func generateOptions(_ sender: UITapGestureRecognizer) {
        print("\(sender.view == optionTwoBtn ? "true" : "false")")
        showAnimation(sender)
    }
    
    func showAnimation(_ sender: UITapGestureRecognizer) {
        
        optionTwoBtn.backgroundColor = UIColor.clear
        optionOneBtn.backgroundColor = UIColor.clear
        optionThreeBtn.backgroundColor = UIColor.clear
        
        optionOneBtn.loopAnimation = true
        optionTwoBtn.loopAnimation = true
        optionThreeBtn.loopAnimation = true
        
        var elementsCopy = [String]()
        elements.forEach { element in elementsCopy.append(element) }
        var randomized = [String]()
        
        for _ in 0..<elements.count {
            let index = Int.random(in: 0..<elementsCopy.count)
            randomized.append(elementsCopy[index])
            elementsCopy.remove(at: index)

        }
        
        optionOneBtn.setAnimation(named: randomized[0])
        optionTwoBtn.setAnimation(named: randomized[1])
        optionThreeBtn.setAnimation(named: randomized[2])
        
        optionTwoBtn.play()
        optionOneBtn.play()
        optionThreeBtn.play()
        
        optionesStackView.isUserInteractionEnabled = false
        
        self.tap.isEnabled = true
        
        if let lotti = sender.view as? LottieView,
            let name = lotti.name {
            print("\(name)")
            if name == "favourite_app_icon" {
                resultLabel.text = "Megúsztad"
            } else {
                resultLabel.text = "Sajnos vesztettél. 3 ivás a büntetés"
            }
        }
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        gameInfoContainerView.layer.cornerRadius = 10
        playerType.text = "Personal"
        playerLabel.text = playersList.randomElement()?.playerName
    }
    
    
}
