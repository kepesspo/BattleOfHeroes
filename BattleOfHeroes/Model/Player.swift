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
    
    init(id : String,playerName: String, teamId: String) {
        self.id = id
        self.playerName = playerName
        self.teamId = teamId
    }
}
