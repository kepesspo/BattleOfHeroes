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
    
    func addPlayerToDatabase(player: Player) {
        let playerKey = refPlayer.childByAutoId().key
        let player = ["id":playerKey,
                      "playerName": player.playerName as String,
                      "playerTeamId" : player.teamId as String] as [String : Any]
        
        refPlayer.child(playerKey).setValue(player)
    }
    
    func addTeamToDataBase(team: Team) {
        //let mok = ["asdfd","afs","DSFSG"]
        let teamKey = refTeam.childByAutoId().key
        let team = ["id": teamKey, "teamName": team.name as String, "teamPlayers": []] as [String : Any]
        refTeam.child(teamKey).setValue(team)
    }
    
    func getTeamList() -> [Team] {
        var playerList = [Player]()
        
        refPlayer.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.playerList.removeAll()
                
                for team in snapshot.children.allObjects as! [DataSnapshot] {
                    let teamObject = team.value as? [String: AnyObject]
                    
                    let teamName  = teamObject?["teamName"] as? String
                    let teamPlayers = teamObject!["teamPlayers"] as? [String: AnyObject]

                    
                    //let team = Team(name: teamName, rating: 0.0, playerList: teamPlayers)
                    //self.teamList.append(team)
                    
                }
            }
        }
        return []
    }
    
    
    func addPlayerToTeam(player : Player, team : Team) {
        refTeam.updateChildValues([
            "playerList": [
                "test3",
                "test4"]
            ])
    }
    
    
    func getPlayerList() -> [Player] {
        refPlayer.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.playerList.removeAll()
                
                for player in snapshot.children.allObjects as! [DataSnapshot] {
                    let playerObject = player.value as? [String: AnyObject]
                    let playerName  = playerObject?["playerName"] as? String
                    let playerTeam = playerObject?["playerTeamId"] as? String
                    
                    let player = Player(playerName: playerName!, teamId: playerTeam!)
                    self.playerList.append(player)
                    
                }
                
                //reloading the tableview
                
                //notification center
                //setUpTableView.reloadData()
            }
        }
        return playerList
    }
    
    
    
    
}

