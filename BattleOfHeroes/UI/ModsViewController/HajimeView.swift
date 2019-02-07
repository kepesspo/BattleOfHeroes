//
//  HajimeView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/2/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class HajimeView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hajimeTextLabel: UILabel!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    
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

        Bundle.main.loadNibNamed("HajimeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
        
    }
    
    @objc func updateLevelCounterUI() {
        gameInLevelLabel.text = self.levelCounter
    }
    
    @objc func updateUI() {
        gameInfoContainerView.layer.cornerRadius = 10
        playerType.text = "Sor játék"
        hajimeTextLabel.text = "Tiltot számok: \n - Bármelyik szám, amely tartalmazza a 7 , 5 számot.  \n - A 7 és 5 számának többszörösei \n - Illetve ha valaki a Hajime szót kimondja akkor a kör megfordul."
        let randomIndex = Int(arc4random_uniform(UInt32(playerList.count)))
        playerName.text = playerList[randomIndex].playerName
        
    }
    
     
}
