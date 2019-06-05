//
//  Room.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

struct Room {
    var id = ""
    var gameRoom = ""
    var gameRun = false
    var randomMemberShow = false
    var playerNameWhoGetDrinks = ""
    
    
    init(id: String, gameRoom: String, gameRun: Bool, randomMemberShow: Bool, playerNameWhoGetDrinks: String) {
        self.id = id
        self.gameRoom = gameRoom
        self.gameRun = gameRun
        self.randomMemberShow = randomMemberShow
        self.playerNameWhoGetDrinks = playerNameWhoGetDrinks
    }
}
