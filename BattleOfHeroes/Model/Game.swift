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
    var name = ""
    var description = ""
    var isSelected = false
    var gameType : GameType?
    var gameMode : GameMode?
    var gameImage : UIImage?
    var gameManagement : UIView?
    var downloadsData = false

    
    init(id : String, name: String, description: String, isSelected: Bool, gameMode: GameMode, gameType: GameType, gameImage: UIImage, gameManagement: UIView, downloadsData: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.isSelected = isSelected
        self.gameMode = gameMode
        self.gameType = gameType
        self.gameImage = gameImage
        self.gameManagement = gameManagement
        self.downloadsData = downloadsData
    }
}
