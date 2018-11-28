//
//  CheersToTheGovernorView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class CheersToTheGovernorView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
    @IBOutlet weak var cheersToTheGovernorLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
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
        Bundle.main.loadNibNamed("CheersToTheGovernorView", owner: self, options: nil)
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
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        playerName.text = "Aki a kört kezdi: \(playersList[randomIndex].playerName)"
        cheersToTheGovernorLabel.text = "1-10-ig kell számolni. Utánna Cheers"
    }
}
