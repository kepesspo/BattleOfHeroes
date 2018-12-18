//
//  ThePeopleChoiceView.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class ThePeopleChoiceView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
    @IBOutlet weak var thePeopleChoiceLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var ifLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var ifBoxView: UIView!
    @IBOutlet weak var orBoxView: UIView!
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
        Bundle.main.loadNibNamed("ThePeopleChoiceView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        ifBoxView.layer.borderColor = UIColor.black.cgColor
        orBoxView.layer.borderColor = UIColor.black.cgColor
        
        ifBoxView.layer.borderWidth = 3
        orBoxView.layer.borderWidth = 3
        
        ifBoxView.layer.cornerRadius = 10
        orBoxView.layer.cornerRadius = 10
        
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
    func updateUI() {
        //let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        //playerName.text = "Aki a kört kezdi: \(playersList[randomIndex].playerName)"
        thePeopleChoiceLabel.text = "A nép szava dönt!"
        
        ifLabel.text = "akármilyen játékot ingyen letölthetnél"
        orLabel.text = "nem játszhatnál velük, csak napi 30 percet..."
    }
}
