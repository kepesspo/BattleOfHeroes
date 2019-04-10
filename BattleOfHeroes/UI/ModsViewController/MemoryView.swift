//
//  MemoryView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/7/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class MemoryView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var memoryTextLabel: UILabel!
    @IBOutlet weak var categoriesTextLabel: UILabel!
    @IBOutlet weak var playerTextLabel: UILabel!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    
    let categories = GameManagement.sharedInstance.gamesCategories
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

        Bundle.main.loadNibNamed("MemoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateLevelCounterUI()
        updateUI()
        
    }
    func updateUI() {
        memoryTextLabel.text = "Jegyez meg minden szót!!"
        let randomIndex = Int(arc4random_uniform(UInt32(categories.count)))
        
        let categoria = NSMutableAttributedString()
        categoria.appendColored(.black,font: .regular(20), "Következő kategória:\n ")
            .appendColored(.red, font: .regular(30), "\(categories[randomIndex])")
        categoriesTextLabel.attributedText = categoria
        gameInfoContainerView.layer.cornerRadius = 10
        playerTextLabel.text = playersList.randomElement()?.playerName
        playerType.text = "Line"
        
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
     
}
