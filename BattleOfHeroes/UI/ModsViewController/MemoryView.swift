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
    @IBOutlet weak var categoriesLabel: UILabel!
    
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

        Bundle.main.loadNibNamed("MemoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    func updateUI() {
        memoryTextLabel.text = "Jegyezz meg minden szót!"
        let randomIndex = Int(arc4random_uniform(UInt32(categories.count)))
        
        let categoria = NSMutableAttributedString()
        categoria.appendColored(.black,font: .regular(20), "A kategória a következő :\n ")
        categoriesTextLabel.attributedText = categoria

        
        //GameManagement.sharedInstance.actuallyPlayerName = playersList.randomElement()?.playerName ?? ""
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "004-teamwork-1.png")
        postNotification(name: .updateGameData)
        
        categoriesLabel.text = categories[randomIndex]
        
    }
     
}
