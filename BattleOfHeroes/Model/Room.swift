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
    var gamePassword = ""
    
    
    init(id : String, gameRoom: String, gamePassword: String) {
        self.id = id
        self.gameRoom = gameRoom
        self.gamePassword = gamePassword
    }
}
