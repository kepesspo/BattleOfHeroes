//
//  Game.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/27/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

struct Game {
    var id = ""
    var gameName = ""
    var isSelected = false
    var gameView = UIView()

    
    init(id : String, gameName: String, gameView: UIView, isSelected: Bool) {
        self.id = id
        self.gameName = gameName
        self.isSelected = isSelected
        self.gameView = gameView
        
    }
}
