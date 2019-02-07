//
//  ShiptripView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class ShiptripView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var gameSoundsLabel: UILabel!
    @IBOutlet weak var lastButton: UIButton!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var randomCaptanLabel: UILabel!
    
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
        self.tap.isEnabled = true
        Bundle.main.loadNibNamed("ShiptripView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    @IBAction func LastAction(_ sender: Any) {
        lastButton.isHidden = true
        lastLabel.text = ""
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
    func updateUI() {
        gameSoundsLabel.text = "Vezényszavak: \n Vihar \n Hajótöröttek \n Részeg tengerész \n Vitorlát bonts"
        let captain = playersList.randomElement()?.playerName
    }
}
