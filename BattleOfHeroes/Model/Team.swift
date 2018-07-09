//
//  Team.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

struct Team: Codable {
   
    var teamId = UUID().uuidString
    var name = ""
    var rating = 0.0
    var playerList: [Player] = []
    var matchNumber = 0
    var win = 0
    var draw = 0
    var lose = 0
    var goalsFor = 0
    var goalsAgainst = 0
    var point = 0
    
    enum CodingKeys: String, CodingKey {
        case teamId
        case name
        case rating
        case playerList
        case matchNumber
        case win
        case draw
        case lose
        case goalsFor
        case goalsAgainst
        case point
    }
    
    init(name: String, rating: Double, playerList : [Player]) {
        self.name = name
        self.rating = rating
        self.playerList = playerList
    }
}
