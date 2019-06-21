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
import Alamofire

enum MyError: Error {
    case runtimeError(String)
    case emptyRoomIDError(String)
}

class NetworkSevice {
    static let sharedInstance = NetworkSevice()
    
    var playerList = [Player]()
    var teamList = [Team]()
    var famousPerson = [FamousPerson]()
    var trueOrFalse = [TrueOrFalse]()
    var haveIEverNever = [HaveIEverNever]()
    var musicRecognizer = [SongParse]()
    var anagrammaWord =  [Anagramma]()
    
    var horseRaceRun = false
    
    let refPlayer = fireBaseRefData.playerRef
    let refTeam = fireBaseRefData.teamRef
    let refGame = fireBaseRefData.gameRef
    let refFamousPerson = fireBaseRefData.famousPerson
    let refAnagrammaWord = fireBaseRefData.anagrammaWord
    let refTrueOrFalse = fireBaseRefData.trueOrFalse
    let refHaveIEverNever = fireBaseRefData.haveIEverNever
    let refMusicRecognizer = fireBaseRefData.musicRecognizer
    
    // Add Game To Database
    func addGameToDatabase(room: Room, competionBlock: @escaping(_ error: Error?) -> Void) {
        let game = ["id" : room.gameRoom,
                    "gameRoom" : room.gameRoom,
                    "randomMemberShow" : false,
                    "playerNameWhoGetDrinks" : "",
                    "HorseRace" : false,
                    "GameRun" : false] as [String : Any]
        refGame.child(room.gameRoom).setValue(game)
        competionBlock(nil)
    }
    
    
    
    // Add Player To Database
    func addPlayerToDatabase(player: Player, competionBlock: @escaping(_ error: Error?) -> Void) {
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

    
    // Delete player To Database
    func deletePlayerToDatabase(player: Player, competionBlock: @escaping(_ error: Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("Players").child(player.id).removeValue()
        competionBlock(nil)
    }
    
    // UpdatePlayerDrinks
    func updatePlayerDrinks(player: Player, drinks: Int, gameType: String, competionBlock: @escaping(_ error: Error?, _ bonus: Bool?, _ player: Player?) -> Void) {
        
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
            for losePlayer in playerList {
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
        
//        playerData = ["id":playerKey,
//                      "playerName": player.playerName as String,
//                      "playerTeamId" : player.teamId as String,
//                      "playerDrinks" : playerDrinks as Int,
//                      "playerColor" : player.color as String,
//                      "playerUsedBonus" : playerUserBonus as Int] as [String : Any]
//
//        refGame.child(roomId).child("Players").child(playerKey).setValue(playerData)
        
        var playData = player
        playData.allDrink = playerDrinks
        if playerDrinks > 10 {
            let bonus = playData.usedBonus + 1
            let notShowedBonus = (Double(playerDrinks) / Double(10)) / Double(bonus) > 1.0
            if playerDrinks % 10 == 0 || notShowedBonus &&  playerDrinks != 0 && GameManagement.sharedInstance.showBonusView == true {
                competionBlock(nil, true, playData)
            } else {
                competionBlock(nil, false, nil)
            }
        } else {
            competionBlock(nil, false, nil)
        }
        
        
    }
    
    
    
    func resetPlayerData(players: [Player], competionBlock: @escaping(_ error: Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        for player in players {
            let playerKey = player.id

            var playerData: [String:Any]?
            
            playerData = ["id":playerKey,
                          "playerName": player.playerName as String,
                          "playerTeamId" : player.teamId as String,
                          "playerDrinks" : 0 as Int,
                          "playerColor" : player.color as String,
                          "playerUsedBonus" : 0 as Int] as [String : Any]
            refGame.child(roomId).child("Players").child(playerKey).setValue(playerData)
        }
        competionBlock(nil)
    }
    
    // UpdatePlayerUseBonus
    func updatePlayerUseBonus(player: Player, bonus: Int, competionBlock: @escaping(_ error: Error?) -> Void) {
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
    
    // UpdatePlayerUseBonus
    func updatePlayer(player: Player, name: String, competionBlock: @escaping(_ error: Error?) -> Void) {
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
    
    // check room Autenticate
    func roomExist(gameName: String, competionBlock: @escaping(_ error: String? , _ success: Bool) -> Void) {
        self.refGame.queryOrdered(byChild: "gameRoom")
            .queryEqual(toValue: gameName)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if ( snapshot.value is NSNull ) {
                    competionBlock("Room doesn't exist",false)
                } else {
                    print("Room Pass correct")
                    competionBlock(nil,true)
                }
            })
    }
    
    func checkCreateExistingRoom(gameName: String, competionBlock: @escaping(_ error: String? , _ success: Bool) -> Void) {
        self.refGame.queryOrdered(byChild: "gameRoom")
            .queryEqual(toValue: gameName)
            .observeSingleEvent(of: .value) { (snapshot) in
                if ( snapshot.value is NSNull ) {
                    competionBlock(nil,true)
                } else {
                    competionBlock("Room  exist",false)
                }
        }
    }

    // Get Player List
    func getPlayerList(completionBlock: @escaping(_ error : Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("Players").observe(DataEventType.value) { (snapshot) in
            self.playerList.removeAll()
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
                    self.playerList.append(player)
                    
                }
                completionBlock(nil)
            } else {
                completionBlock(nil)
            }
        }
    }
    
    // Player name update who get spectator drinks
    func playerHowGetDrinksForSpectator(playerName: String, completionBlock: @escaping(_ error : Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("playerNameWhoGetDrinks").setValue(playerName)
        completionBlock(nil)
        
    }
    
    func getPlayerHowGetDrinksForSpectator(completionBlock: @escaping(_ error : Error?,_ playerName: String) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        var playerName: String = ""
        refGame.child(roomId).observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                playerName = snapshot.childSnapshot(forPath: "playerNameWhoGetDrinks").value as! String
                completionBlock(nil,playerName)
            }
        }
    }
    
    
    
    // Update Who Get Sepectator Drinks
    func getPlayerHowGetDrinks(completionBlock: @escaping(_ error : Error?,_ playerIsShow: Int) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        var playerIsShow: Int = 0
        refGame.child(roomId).observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                playerIsShow = snapshot.childSnapshot(forPath: "randomMemberShow").value as! Int
                completionBlock(nil,playerIsShow)
            }
        }
    }
    
    func playerHowGetDrinks(isShow: Bool, completionBlock: @escaping(_ error : Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("randomMemberShow").setValue(isShow)
        completionBlock(nil)
        
    }
    
    // Horse Race Show when spectate is on
    func getHorseRaceRunning(completionBlock: @escaping(_ error : Error?,_ horseRaceData: Int) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        var horseRaceData: Int = 0
        refGame.child(roomId).observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                horseRaceData = snapshot.childSnapshot(forPath: "HorseRace").value as! Int
                completionBlock(nil,horseRaceData)
            }
        }
    }
    
    func horseRaceRunning(isRun:Bool, completionBlock: @escaping(_ error : Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        refGame.child(roomId).child("HorseRace").setValue(isRun)
        completionBlock(nil)
        
    }
    
    
    // Game is running
    func gameRunning(isRun:Bool, completionBlock: @escaping(_ error : Error?) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        if roomId == "" {
            print("No room id to use")
            completionBlock(MyError.emptyRoomIDError("No room id to use error"))
        } else {
            let gameRun = refGame.child(roomId).child("GameRun")
            gameRun.setValue(isRun)
            gameRun.onDisconnectSetValue(false)
            completionBlock(nil)
        }
        
        
    }
    
    func getGameRunning(completionBlock: @escaping(_ error : Error?,_ gameRunnig: Int) -> Void) {
        let roomId = GameManagement.sharedInstance.getRoomName()
        var gameRunnigData: Int = 0
        refGame.child(roomId).observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                gameRunnigData = snapshot.childSnapshot(forPath: "GameRun").value as! Int
                completionBlock(nil,gameRunnigData)
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
    
    func getFamousPersons(completionBlock: @escaping(_ error : Error?) -> Void){
        refFamousPerson.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.famousPerson.removeAll()
                for famousPerson in snapshot.children.allObjects as! [DataSnapshot] {
                    let famousPersonObject = famousPerson.value as? [String: AnyObject]
                    let famousPersonName  = famousPersonObject?["name"] as? String
                    let famousPersonImage = famousPersonObject?["image"] as? String
                    let famousPersonOccupation = famousPersonObject?["occupation"] as? String
                    let famousPersonAge = famousPersonObject?["age"] as? String
                    
                    let famousPerson = FamousPerson(name: famousPersonName ?? "Nincs Adat", age: famousPersonAge ?? "Nincs Adat", occupation: famousPersonOccupation ?? "Nincs Adat", image: famousPersonImage ?? "")
                    self.famousPerson.append(famousPerson)
                    
                }
                completionBlock(nil)
            }
        }
    }
    
    func getAnagrammaWord(completionBlock: @escaping(_ error : Error?) -> Void){
        refAnagrammaWord.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.anagrammaWord.removeAll()
                for anagramma in snapshot.children.allObjects as! [DataSnapshot] {
                    let anagrammaObject = anagramma.value as? [String: AnyObject]
                    let anagramma = anagrammaObject?["anagramma"] as? String
                    
                    let anagrammaData = Anagramma(anagramma: anagramma ?? "Nincs adat")
                    self.anagrammaWord.append(anagrammaData)
                    
                }
                completionBlock(nil)
            }
        }
    }
    
    
    func getTrueOrFalse(completionBlock: @escaping(_ error : Error?) -> Void){
        refTrueOrFalse.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.trueOrFalse.removeAll()
                for trueOrFalse in snapshot.children.allObjects as! [DataSnapshot] {
                    let trueOrFalseObject = trueOrFalse.value as? [String: AnyObject]
                    let question = trueOrFalseObject?["question"] as? String
                    let answer = trueOrFalseObject?["answer"] as? String
                    
                    let trueOrFalseObj = TrueOrFalse(question: question ?? "Nincs Adat", answer: answer ?? "Nincs Adat")
                    self.trueOrFalse.append(trueOrFalseObj)
                    
                }
                completionBlock(nil)
            }
        }
    }
    
    func getHaveIEverNever(completionBlock: @escaping(_ error : Error?) -> Void){
        refHaveIEverNever.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.haveIEverNever.removeAll()
                for haveIEverNever in snapshot.children.allObjects as! [DataSnapshot] {
                    let haveIEverNeverObject = haveIEverNever.value as? [String: AnyObject]
                    let question = haveIEverNeverObject?["question"] as? String
                    
                    let haveIEverNever = HaveIEverNever(question: question ?? "Nincs adat")
                    self.haveIEverNever.append(haveIEverNever)
                    
                }
                completionBlock(nil)
            }
        }
    }
    
    
    func getSongs(completionBlock: @escaping(_ error : Error?) -> Void){
        refMusicRecognizer.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.musicRecognizer.removeAll()
                for songs in snapshot.children.allObjects as! [DataSnapshot] {
                    let songObject = songs.value as? [String: AnyObject]
                    let id  = songObject?["trackID"] as? String
                    let releaseDate = songObject?["release_date"] as? String
                    let song = SongParse(id: id ?? "", releaseDate: releaseDate ?? "")
                    self.musicRecognizer.append(song)
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
    
    
    func getSongJson(url : String, headers: HTTPHeaders, competionBlock: @escaping(_ error: Error? , _ response: Any?) -> Void) {
        Alamofire.request(url, headers: headers).response { (response) in
            if response.error != nil {
                competionBlock(response.error, nil)
            } else {
                competionBlock(nil, response.data)
            }
            
        }
    } 
}
