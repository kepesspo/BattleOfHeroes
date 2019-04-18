//
//  HorseBet.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/18/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

struct Bet {
    var playerName = ""
    var drinkValue = 0
    var horseColorName = ""
    var horseColor = UIColor()
    
    init(playerName : String, drinkValue: Int, horseColorName: String, horseColor: UIColor ) {
        self.playerName = playerName
        self.drinkValue = drinkValue
        self.horseColor = horseColor
        self.horseColorName = horseColorName
    }
}
