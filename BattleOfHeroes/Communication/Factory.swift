//
//  Factory.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/21/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class Factory {
    static let shared = Factory()
    
    var dataManager: DataManager
    var isOnline = false
    var playerList = [Player]()
    var playerIndex = 0
    var playerCount : Int {
        return playerList.count
    }
    var roomID: String = "0000"
    
    var playedGame = 0
    var actuallyPlayer: Player?
    var actuallyGame : Game?
    var actuallyGameType = 0
    
    var figures = ["black_figures-1","blue_figures-1","yellow_figures-1",
                   "pink_figures-1","green_figures-1","red_figures-1",
                   "orange_figures-1","dark_figures-1","purple_figures-1"]
    var figuresIndex = 0
    
    // Game difficulty
    var gameDrinkMultiplier : Int = 1
    
    // Game bonus View
    var showBonusView : Bool = true
    
    // Game Group Drink
    var groupDrinksAllow : Bool = true
    var groupDrinkTime : Int = 300
    
    // Game Random Pictogram
    var randomPictogramAllow : Bool = true
    var randomPictogramTime : Int = 420
    
    private init() {
        dataManager = OfflineService()
    }
    
    
    func getNextGamePlayer() {
        if  self.playerIndex == self.playerCount {
            self.playerIndex = 1
        } else {
            self.playerIndex = self.playerIndex + 1
        }
        let player = self.playerList[Factory.shared.playerIndex - 1]
        self.actuallyPlayer = player
        print("----------- Player: \(player.playerName) --------------")
    }
}
