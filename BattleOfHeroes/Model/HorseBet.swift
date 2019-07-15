//
//  HorseBet.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/18/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

enum HorseColor: CaseIterable {
    case none
    case red
    case blue
    case green
    case yellow
    
    func next() -> HorseColor {
        let allCases = HorseColor.allCases
        let index = (allCases.index(of: self)! + 1) % allCases.count
        return allCases[index]
    }
    
    var uiColor: UIColor {
        switch self {
        case .none: return UIColor.white
        case .red: return UIColor.red
        case .blue: return UIColor.blue
        case .green: return UIColor.green
        case .yellow: return UIColor.yellow
        }
    }
    
    var text: String {
        switch self {
        case .none: return "Nem fogadott"
        case .red: return "Piros"
        case .blue: return "kék"
        case .green: return "Zöld"
        case .yellow: return "Sárga"
        }
    }
}

class HorseBet {
    var playerName = ""
    var drinkValue = 0
    var horseColor: HorseColor = .none
    
    init(playerName : String, drinkValue: Int, horseColor: HorseColor) {
        self.playerName = playerName
        self.drinkValue = drinkValue
        self.horseColor = horseColor
    }
    
}
