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
        let randomPlayer = Int(arc4random_uniform(UInt32(playersList.count)))
        
        let categoria = NSMutableAttributedString()
        categoria.appendColored(.black,font: .regular(20), "Következő kategória:\n ")
            .appendColored(.red, font: .regular(30), "\(categories[randomIndex])")
        categoriesTextLabel.attributedText = categoria
        
        
        let player = NSMutableAttributedString()
        player.appendColored(.black, font: .regular(20), "Játékot Kezdi:\n ").appendColored(.black, font: .bold(60),"\(playersList[randomPlayer].playerName)")
        playerTextLabel.attributedText = player

        
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
     
}
