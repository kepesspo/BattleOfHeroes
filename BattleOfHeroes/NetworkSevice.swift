//
//  NetworkSevice.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/9/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class NetworkSevice {
    static let sharedInstance = NetworkSevice()
    
    var playerList = [Player]()
    var teamList = [Team]()
    
    let refPlayer = fireBaseRefData.playerRef
    let refTeam = fireBaseRefData.teamRef
    let refGame = fireBaseRefData.gameRef
    
    
    // Add Game To Database
    func addGameToDatabase(room: Room, competionBlock: @escaping(_ error: Error?) -> Void) {
        let gameKey = refGame.childByAutoId().key
        let game = ["id" : gameKey,
                    "gameRoom" : room.gameRoom,
                    "gamePass" : room.gamePassword]
        refGame.child(gameKey).setValue(game)
        competionBlock(nil)
    }
    
    
    
    // Add Player To Database
    func addPlayerToDatabase(player: Player, competionBlock: @escaping(_ error: Error?) -> Void) {
        let playerKey = refPlayer.childByAutoId().key
        let player = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String,
                      "playerLife" : player.life as Int,
                      "playerDrinks" : player.allDrink as Int] as [String : Any]
        
        refPlayer.child(playerKey).setValue(player)
        
        competionBlock(nil)
    }
    
    // Delete player To Database
    func deletePlayerToDatabase(player: Player, competionBlock: @escaping(_ error: Error?) -> Void) {
        FirebaseDatabase.Database.database().reference(withPath: "Player").child(player.id).removeValue()
        competionBlock(nil)
    
    }
    
    // UpdatePlayerDrinks
    func updatePlayerDrinks(player: Player, drinks: Int, competionBlock: @escaping(_ error: Error?) -> Void) {
        let playerKey = player.id
        let playerDrinks = player.allDrink + drinks
        let playerLife = player.life + drinks
        var playerData: [String:Any]?
        
        if drinks < 0 {
            playerData = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String,
                      "playerLife" : playerLife as Int,
                      "playerDrinks" : player.allDrink as Int] as [String : Any]
        } else {
            playerData = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String,
                      "playerLife" : player.life as Int,
                      "playerDrinks" : playerDrinks as Int] as [String : Any]
        }
        
        refPlayer.child(playerKey).setValue(playerData)
        competionBlock(nil)
        
    }
    
    
    
    // Add Team To Database
    func addTeamToDataBase(team: Team, competionBlock: @escaping(_ error: Error?) -> Void) {
        let teamKey = refTeam.childByAutoId().key
        let team = ["id": teamKey,
                    "teamName": team.name as String]
        refTeam.child(teamKey).setValue(team)
        competionBlock(nil)
    }
    
    // check room Autenticate
    func roomExist(gameName: String, gamePass: String, competionBlock: @escaping(_ error: Error?) -> Void) {
        let roomKey = refGame.childByAutoId().key
        
        refGame.child(roomKey).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(gameName){
                print("user exist")
                competionBlock(nil)
            } else{
                print("user doesn't exist")
            }
        })
    }
    
    
   
    // Get Player List
    func getPlayerList(completionBlock: @escaping(_ error : Error?) -> Void) {
        refPlayer.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.playerList.removeAll()
                
                for player in snapshot.children.allObjects as! [DataSnapshot] {
                    let playerObject = player.value as? [String: AnyObject]
                    let playerId = playerObject?["id"] as? String
                    let playerName  = playerObject?["playerName"] as? String
                    let playerTeam = playerObject?["playerTeamId"] as? String
                    let playerLife = playerObject?["playerLife"] as? Int
                    let playerDrinks = playerObject?["playerDrinks"] as? Int
                    
                    
                    let player = Player(id: playerId!, playerName: playerName!, teamId: playerTeam!, life: playerLife!, allDrink: playerDrinks!)
                    self.playerList.append(player)
                    
                }
                completionBlock(nil)
            }
        }
    }
    
    // Get Team List
    func getTeamList(completionBlock: @escaping(_ error : Error?) -> Void) {
        refTeam.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.teamList.removeAll()
                
                for team in snapshot.children.allObjects as! [DataSnapshot] {
                    let teamObject = team.value as? [String: AnyObject]
                    let teamName  = teamObject?["teamName"] as? String
                    let teamId = teamObject?["id"] as? String

                    
                    let team = Team(id: teamId!, name: teamName!, rating: 0)
                    self.teamList.append(team)
                    
                }
                completionBlock(nil)
            }
            
        }
    }
    
    
    func addTeamToPlayer(player: Player, team : Team, competionBlock: @escaping(_ error: Error?) -> Void) {
        let playerData = ["id":player.id,
                      "playerName": player.playerName as String,
                      "playerTeamId" : team.id as String] as [String : Any]
        
        refPlayer.child(player.id).setValue(playerData)
        competionBlock(nil)
    }
    
    
    
    
}

