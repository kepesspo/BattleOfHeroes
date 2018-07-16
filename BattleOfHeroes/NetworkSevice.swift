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
    func addGameToDatabase(competionBlock: @escaping(_ error: Error?) -> Void) {
        var gamePass = "1234"
        var gameRoomId = "Room"
        let gameKey = refGame.childByAutoId().key
        let game = ["id" : gameKey,
                    "gameRoom" : gameRoomId,
                    "gamePass" : gamePass]
        refGame.child(gameKey).setValue(game)
        competionBlock(nil)
    }
    
    
    
    // Add Player To Database
    func addPlayerToDatabase(player: Player, competionBlock: @escaping(_ error: Error?) -> Void) {
        let playerKey = refPlayer.childByAutoId().key
        let player = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String] as [String : Any]
        
        refPlayer.child(playerKey).setValue(player)
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
                    
                    let player = Player(id: playerId!, playerName: playerName!, teamId: playerTeam!)
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

