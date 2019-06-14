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
    static let anagrammaWord = Database.database().reference().child("Anagramma")
}

struct UserDefaultsKeys {
    static let spotifyToken = "spotifyToken"
    static let onboardingClosed = "onboardingClosed"
    static let firstRunClosed = "firstRunClosed"
    static let roomId = "roomId"
    static let roomName = "roomName"
    static let roomPass = "roomPass"
}

struct DevOptions {
    static let autoFill = 1
}



extension Notification.Name {
    static let reloadScoreTableView = Notification.Name("reloadScoreTableView")
    static let dismissGame = Notification.Name("dismissGame")
    static let internetChange = Notification.Name("internetChange")
    static let showBonus = Notification.Name("showBonus")
    static let endGame = Notification.Name("endGame")
    static let getGameDescription = Notification.Name("getGameDescription")
    static let reloadGroupDrinkTimer = Notification.Name("reloadGroupDrinkTimer")
    static let randomPictogram = Notification.Name("randomPictogram")
    static let generateNewGame = Notification.Name("generateNewGame")
    static let updateGameData = Notification.Name("updateGameData")
    static let gameModeChanged = Notification.Name("gameModeChanged")
    static let spotiTokenUpdate = Notification.Name("spotiTokenUpdate")
    static let updateGameIsSpectate = Notification.Name("updateGameIsSpectate")
    static let updateGameIsAll = Notification.Name("updateGameIsAll")
    static let updateStartButton = Notification.Name("updateStartButton")
    static let updatePlayerCollectionView = Notification.Name("updatePlayerCollectionView")
    
    static let gameNext = Notification.Name("gameNext")
}


