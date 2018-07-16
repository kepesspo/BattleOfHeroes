//
//  Constants.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/6/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct SegueIdentifiers {
    static let team = "teamSegue"
    static let person = "personSegue"
    
}

struct fireBaseRefData {
    static let playerRef = Database.database().reference().child("Player")
    static let teamRef = Database.database().reference().child("Team")
    static let gameRef = Database.database().reference().child("Game")
}
