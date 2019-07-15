//
//  OfflineService.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/21/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import RealmSwift

class OfflineService: DataManager {
    let realm = try! Realm()
    
    func updatePlayerUseBonus(player: Player, bonus: Int, competionBlock: @escaping (Error?) -> Void) {
        let playerUserBonus = player.usedBonus + bonus
        let players = realm.objects(Player.self).filter("playerName = %@", player.playerName)
        if let playerData = players.first {
            try! realm.write {
                playerData.usedBonus = playerUserBonus
            }
        }
        competionBlock(nil)
    }
    
    func updatePlayerDrinks(player: Player, drinks: Int, gameType: String, competionBlock: @escaping (Error?, Bool?, Player?) -> Void) {
        let gameType = gameType
        let playerKey = player.id
        let playerDrinks = player.allDrink + drinks
        let playerUserBonus = player.usedBonus
        var playerData: [String:Any]?
        
        if gameType == "winGroup" {
            let players = realm.objects(Player.self).filter("playerName = %@", player.playerName)
            if let playerData = players.first {
                try! realm.write {
                    playerData.allDrink = playerDrinks
                }
            }
            
            
        } else if gameType == "LoseGroup" {
            for losePlayer in Factory.shared.playerList {
                if losePlayer.playerName != player.playerName {
                    let players = realm.objects(Player.self).filter("playerName = %@", losePlayer.playerName)
                    if let playerData = players.first {
                        try! realm.write {
                            playerData.allDrink = losePlayer.allDrink + drinks
                        }
                    }
                } else {
                    print("Player how lose the game")
                }
            }
        } else {
            let players = realm.objects(Player.self).filter("playerName = %@", player.playerName)
            if let playerData = players.first {
                try! realm.write {
                    playerData.allDrink = playerDrinks
                }
            }
        }
        
        
        if player.allDrink > 10 {
            let bonus = player.usedBonus + 1
            let notShowedBonus = (Double(player.allDrink) / Double(10)) / Double(bonus) > 1.0
            if playerDrinks % 10 == 0 || notShowedBonus &&  player.allDrink != 0 && Factory.shared.showBonusView == true {
                competionBlock(nil, true, player)
            } else {
                competionBlock(nil, false, nil)
            }
        } else {
            competionBlock(nil, false, nil)
        }
    }
    
    
    func updatePlayer(player: Player, name: String, competionBlock: @escaping (Error?) -> Void) {
        let players = realm.objects(Player.self).filter("playerName = %@", player.playerName)
        if let playerData = players.first {
            try! realm.write {
                playerData.playerName = name
            }
        }
        competionBlock(nil)
    }
    
    func deleteRoom(room: String, competionBlock: @escaping (Error?) -> Void) {
        print("------- Delete Offline Room -----------")
        try! realm.write() {
            realm.deleteAll()
        }
        competionBlock(nil)
    }
    
    func deletePlayer(player: Player, competionBlock: @escaping (Error?) -> Void) {
        print("------- Delete Offline Player -----------")
        try! realm.write() {
            Factory.shared.playerList.removeAll(where: { $0.playerName == player.playerName})
            realm.delete(player)
            competionBlock(nil)
        }
    }
    
    func getPlayerList(completionBlock: @escaping (Error?) -> Void) {
        Factory.shared.playerList.removeAll()
        let players = realm.objects(Player.self)
        for player in players {
            Factory.shared.playerList.append(player) 
        }
        completionBlock(nil)
        
    }
    
    func createPlayer(player: Player, competionBlock: @escaping (Error?) -> Void) {
        print("------- Create Offline Player -----------")
        try! realm.write() {
            realm.add(player)
            Factory.shared.playerList.append(player)
        }
        competionBlock(nil)
    }
    
    func createRoom(room: Room, competionBlock: @escaping (Error?) -> Void) {
        print("------- Create Offline Room -----------")
        try! realm.write() {
            realm.add(room)
        }
        Factory.shared.roomID = room.gameRoom
        competionBlock(nil)
        print(room)
    }
    
  
}
