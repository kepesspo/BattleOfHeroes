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
    var gameTypeColor: UIColor?
    var gameMode : GameMode?
    var gameImage : UIImage?
    var gameManagement : UIView?
    var downloadsData = false
    var addedScore = 0

    
    init(id : String, name: String, description: String, isSelected: Bool, gameMode: GameMode, gameType: GameType, gameTypeColor: UIColor, gameImage: UIImage, gameManagement: UIView, downloadsData: Bool = false, addedScore : Int) {
        self.id = id
        self.name = name
        self.description = description
        self.isSelected = isSelected
        self.gameMode = gameMode
        self.gameType = gameType
        self.gameTypeColor = gameTypeColor
        self.gameImage = gameImage
        self.gameManagement = gameManagement
        self.downloadsData = downloadsData
        self.addedScore = addedScore
    }
}
