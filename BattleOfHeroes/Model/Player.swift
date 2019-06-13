//
//  Player.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

struct Player {
    var id = ""
    var playerName = ""
    var teamId = "Unknown Team"
    var isSelected = false
    var allDrink = 0
    var usedBonus = 0
    var color = ""
    
    init(id : String, playerName: String, teamId: String, allDrink: Int, usedBonus: Int, color: String) {
        self.id = id
        self.playerName = playerName
        self.teamId = teamId
        self.allDrink = allDrink
        self.usedBonus = usedBonus
        self.color = color
    }
}
