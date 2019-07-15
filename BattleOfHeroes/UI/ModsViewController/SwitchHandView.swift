//
//  SwitchHandView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/13/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import MDCCommon

class SwitchHandView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var switchHandLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("SwitchHandView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
    }
    
    func updateUI() {
        Factory.shared.getNextGamePlayer()
        Factory.shared.playedGame = Factory.shared.playedGame + 1
        postNotification(name: .updateGameData)
        
        let switchHand = NSMutableAttributedString()
        switchHand.appendColored(.black , font: .regular(20), "Rakd a melletted űlő játékosok kezén át a tiédet keresztbe.\n\n").appendColored(#colorLiteral(red: 0, green: 0.3294117647, blue: 0.5764705882, alpha: 1), font: .regular(21), "1 koppintás = folytatás\n").appendColored(#colorLiteral(red: 0, green: 0.3294117647, blue: 0.5764705882, alpha: 1), font: .regular(21), "2 koppintás = fordul az irány\n").appendColored(#colorLiteral(red: 0, green: 0.3294117647, blue: 0.5764705882, alpha: 1), font: .regular(21), "3 koppintás = kimarad egy játékos\n\n").appendColored(.black, font: .regular(20), "5 csata után a büntetéseket meg kell inni")
        switchHandLabel.attributedText = switchHand
    }
}
