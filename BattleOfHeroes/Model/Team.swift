//
//  Team.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

struct Team {
    
    var id = ""
    var name = ""
    var rating = 0.0
    var matchNumber = 0
    var win = 0
    var draw = 0
    var lose = 0
    var goalsFor = 0
    var goalsAgainst = 0
    var point = 0
    
    init(id: String, name: String, rating: Double) {
        self.id = id
        self.name = name
        self.rating = rating
    }
}
