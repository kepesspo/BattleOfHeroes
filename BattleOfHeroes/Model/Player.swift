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
    var playerName = ""
    var teamId = "Unknown Team"
    var isSelected = false
    
    init(playerName: String, teamId: String) {
        self.playerName = playerName
        self.teamId = teamId
    }
}
