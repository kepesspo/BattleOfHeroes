//
//  SwitchHandView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/13/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class SwitchHandView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var switchHandLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    
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
        Bundle.main.loadNibNamed("SwitchHandView", owner: self, options: nil)
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
        playerType.text = "Group"
        gameInfoContainerView.layer.cornerRadius = 10
        playerName.text = playersList.randomElement()?.playerName
        switchHandLabel.text = "\n1 koppintás = folytassa a sorozatot \n2 koppintás = fordított sorrend \n3 koppintás = hiányolja a következő kezét"
    }
}
