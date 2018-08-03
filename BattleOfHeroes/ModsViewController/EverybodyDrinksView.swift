//
//  EverybodyDrinksView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/2/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit


class EverybodyDrinksView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var everybodyDrinksTextLabel: UILabel!
    @IBOutlet weak var howDrinksTextLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("EverybodyDrinksView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        showRandomPlayer()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        contentView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func showRandomPlayer() {
        everybodyDrinksTextLabel.text = "Egyszer mindenki iszik most: "
        let randomIndex = Int(arc4random_uniform(UInt32(playerList.count)))
        
        let player = NSMutableAttributedString()
        player.appendColored(.white, font: .bold(60), "\(playerList[randomIndex].playerName)")
        howDrinksTextLabel.attributedText = player
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    
}

