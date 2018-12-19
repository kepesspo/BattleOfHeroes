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
    static let goToPlayerView = "goToPlayerView"
    
}

struct fireBaseRefData {
    static let playerRef = Database.database().reference().child("Player")
    static let teamRef = Database.database().reference().child("Team")
    static let gameRef = Database.database().reference().child("Game")
    static let famousPerson = Database.database().reference().child("FamousPerson")
    static let trueOrFalse = Database.database().reference().child("TrueOrFalse")
    static let haveIEverNever = Database.database().reference().child("HaveIEverNever")
    static let musicRecognizer = Database.database().reference().child("Song")
}

struct UserDefaultsKeys {
    static let spotifyToken = "spotifyToken"
}


extension Notification.Name {
    static let addCounterValue = Notification.Name("addCounterValue")
    static let reloadScoreTableView = Notification.Name("reloadScoreTableView")
    static let dismissGame = Notification.Name("dismissGame")
    static let internetChange = Notification.Name("internetChange")
    static let showBonus = Notification.Name("showBonus")
    static let endGame = Notification.Name("endGame")
    static let getGameDescription = Notification.Name("getGameDescription")
}
