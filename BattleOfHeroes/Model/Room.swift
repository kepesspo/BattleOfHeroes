//
//  Room.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Room: Object {
    dynamic var id: String = ""
    dynamic var gameRoom: String = ""
    dynamic var gameRun: Bool = false
    dynamic var randomMemberShow: Bool = false
    dynamic var playerNameWhoGetDrinks: String = ""
    
    
    convenience init(id: String, gameRoom: String, gameRun: Bool, randomMemberShow: Bool, playerNameWhoGetDrinks: String) {
        self.init()
        self.id = id
        self.gameRoom = gameRoom
        self.gameRun = gameRun
        self.randomMemberShow = randomMemberShow
        self.playerNameWhoGetDrinks = playerNameWhoGetDrinks
    }
}
