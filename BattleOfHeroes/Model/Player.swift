//
//  Player.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit


@objcMembers
class Player: Object {
    
    dynamic var playerId = UUID().uuidString
    dynamic var playerName = ""
    dynamic var playerRating = 0.0
    dynamic var playerAge = 0
    dynamic var teamId = "UnknownTeam"
    dynamic var isSelected = false
    dynamic var playerImage = Data()
    
    
    convenience init(playerName: String, playerRating: Double, playerAge: Int, playerTeamId : String , playerImage : Data ) {
        self.init()
        self.playerName = playerName
        self.playerRating = playerRating
        self.playerAge = playerAge
        self.teamId = playerTeamId
        self.playerImage = playerImage
    }
}
