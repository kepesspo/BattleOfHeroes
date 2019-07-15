//
//  OnlineService.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/21/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import FirebaseDatabase
import Firebase



class OnlineService: DataManager {
    func updatePlayerUseBonus(player: Player, bonus: Int, competionBlock: @escaping (Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        let playerKey = player.id
        let playerDrinks = player.allDrink
        let playerUserBonus = player.usedBonus + bonus
        var playerData: [String:Any]?
        
        playerData = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String,
                      "playerDrinks" : playerDrinks as Int,
                      "playerColor" : player.color as String,
                      "playerUsedBonus" : playerUserBonus as Int] as [String : Any]
        
        refGame.child(roomId).child("Players").child(playerKey).setValue(playerData)
        competionBlock(nil)
    }
    
    let refGame = FirebaseRefData.gameRef
    let refPlayer = FirebaseRefData.playerRef
    
    func updatePlayerDrinks(player: Player, drinks: Int, gameType: String, competionBlock: @escaping (Error?, Bool?, Player?) -> Void) {
        let gameType = gameType
        let roomId = GameManagement.sharedInstance.getRoomName()
        let playerKey = player.id
        let playerDrinks = player.allDrink + drinks
        let playerUserBonus = player.usedBonus
        var playerData: [String:Any]?
        
        
        if gameType == "winGroup" {
            playerData = ["id":playerKey,
                          "playerName": player.playerName as String,
                          "playerTeamId" : player.teamId as String,
                          "playerDrinks" : playerDrinks as Int,
                          "playerColor" : player.color as String,
                          "playerUsedBonus" : playerUserBonus as Int] as [String : Any]
            
            refGame.child(roomId).child("Players").child(playerKey).setValue(playerData)
            
        } else if gameType == "LoseGroup" {
            for losePlayer in Factory.shared.playerList {
                if losePlayer.id != player.id {
                    playerData = ["id":losePlayer.id,
                                  "playerName": losePlayer.playerName as String,
                                  "playerTeamId" : losePlayer.teamId as String,
                                  "playerDrinks" : losePlayer.allDrink + drinks as Int,
                                  "playerColor" : losePlayer.color as String,
                                  "playerUsedBonus" : losePlayer.usedBonus as Int] as [String : Any]
                    
                    refGame.child(roomId).child("Players").child(losePlayer.id).setValue(playerData)
                } else {
                    print("Player how lose the game")
                }
            }
        } else {
            playerData = ["id":playerKey,
                          "playerName": player.playerName as String,
                          "playerTeamId" : player.teamId as String,
                          "playerDrinks" : playerDrinks as Int,
                          "playerColor" : player.color as String,
                          "playerUsedBonus" : playerUserBonus as Int] as [String : Any]
            
            refGame.child(roomId).child("Players").child(playerKey).setValue(playerData)
        }
        
        
        var playData = player
        playData.allDrink = playerDrinks
        if playerDrinks > 10 {
            let bonus = playData.usedBonus + 1
            let notShowedBonus = (Double(playerDrinks) / Double(10)) / Double(bonus) > 1.0
            if playerDrinks % 10 == 0 || notShowedBonus &&  playerDrinks != 0 && Factory.shared.showBonusView == true {
                competionBlock(nil, true, playData)
            } else {
                competionBlock(nil, false, nil)
            }
        } else {
            competionBlock(nil, false, nil)
        }
    }
    
    func updatePlayer(player: Player, name: String, competionBlock: @escaping (Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        let playerKey = player.id
        let playerName = name
        let playerDrinks = player.allDrink
        let playerUserBonus = player.usedBonus
        var playerData: [String:Any]?
        
        playerData = ["id":playerKey,
                      "playerTeamId" : player.teamId as String,
                      "playerName" : playerName as String,
                      "playerDrinks" : playerDrinks as Int,
                      "playerColor" : player.color as String,
                      "playerUsedBonus" : playerUserBonus as Int] as [String : Any]
        
        refGame.child(roomId).child("Players").child(playerKey).setValue(playerData)
        competionBlock(nil)
    }
    
    func deleteRoom(room: String, competionBlock: @escaping (Error?) -> Void) {
         print("------- Delete Offline Room -----------")
        let roomId = Factory.shared.roomID
        refGame.child(roomId).removeValue()
        competionBlock(nil)
    }
    
   
    
    func deletePlayer(player: Player, competionBlock: @escaping (Error?) -> Void) {
        print("------- Delete Offline Player -----------")
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("Players").child(player.id).removeValue()
        competionBlock(nil)
    }
    
    
    
    func getPlayerList(completionBlock: @escaping (Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("Players").observe(DataEventType.value) { (snapshot) in
            Factory.shared.playerList.removeAll()
            if snapshot.childrenCount > 0 {
                for player in snapshot.children.allObjects as! [DataSnapshot] {
                    let playerObject = player.value as? [String: AnyObject]
                    let playerId = playerObject?["id"] as? String
                    let playerName  = playerObject?["playerName"] as? String
                    let playerTeam = playerObject?["playerTeamId"] as? String
                    let playerDrinks = playerObject?["playerDrinks"] as? Int
                    let playerUsedBonus = playerObject!["playerUsedBonus"] as? Int
                    let playerColor = playerObject!["playerColor"] as? String
                    
                    let player = Player(id: playerId!, playerName: playerName!, teamId: playerTeam!, allDrink: playerDrinks!, usedBonus: playerUsedBonus!, color: playerColor!)
                    Factory.shared.playerList.append(player)
                    
                }
                completionBlock(nil)
            } else {
                completionBlock(nil)
            }
        }
    }
    
    func createPlayer(player: Player, competionBlock: @escaping (Error?) -> Void) {
        print("------- Create Offline Player -----------")
        let roomId = GameManagement.sharedInstance.getRoomName()
        let playerKey = refPlayer.childByAutoId().key
        let player = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String,
                      "playerDrinks" : player.allDrink as Int,
                      "playerColor" : player.color as String,
                      "playerUsedBonus" : player.usedBonus as Int] as [String : Any]
        refGame.child(roomId).child("Players").child(playerKey ?? "").setValue(player)
        
        competionBlock(nil)
    }

    
    func createRoom(room: Room, competionBlock: @escaping (Error?) -> Void) {
     print("------- Create Online Room -----------")
        let game = ["id" : room.gameRoom,
                    "gameRoom" : room.gameRoom,
                    "randomMemberShow" : false,
                    "playerNameWhoGetDrinks" : "",
                    "HorseRace" : false,
                    "GameRun" : false] as [String : Any]
        refGame.child(room.gameRoom).setValue(game)
        Factory.shared.roomID = room.gameRoom
        competionBlock(nil)
    }
    
    
}

