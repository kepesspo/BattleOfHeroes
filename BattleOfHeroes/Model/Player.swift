//
//  Player.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import RealmSwift

@objcMembers
class Player: Object {
    dynamic var id = ""
    dynamic var playerName = ""
    dynamic var teamId = "Unknown Team"
    dynamic var isSelected = false
    dynamic var allDrink = 0
    dynamic var usedBonus = 0
    dynamic var color = ""
    
    convenience init(id : String, playerName: String, teamId: String, allDrink: Int, usedBonus: Int, color: String) {
        self.init()
        self.id = id
        self.playerName = playerName
        self.teamId = teamId
        self.allDrink = allDrink
        self.usedBonus = usedBonus
        self.color = color
    }
}
