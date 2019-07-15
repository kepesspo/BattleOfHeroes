//
//  CategoriesView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/1/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import MDCCommon

class CategoriesView: GameView {
    
    let categories = GameManagement.sharedInstance.gamesCategories
    let playersList = NetworkSevice.sharedInstance.playerList


    @IBOutlet var contentView: UIView!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("CategoriesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
    }
    
    @objc func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
        let randomIndex = Int(arc4random_uniform(UInt32(categories.count)))
        categoriesLabel.text =  categories[randomIndex]
       
    }
}
