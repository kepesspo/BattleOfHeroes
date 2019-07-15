//
//  DataManager.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/21/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

protocol DataManager {
    
    // Game
    func createRoom(room: Room, competionBlock: @escaping(_ error: Error?) -> Void)
    func deleteRoom(room: String, competionBlock: @escaping(_ error: Error?) -> Void)
    
    // Player
    func createPlayer(player: Player, competionBlock: @escaping(_ error: Error?) -> Void)
    func getPlayerList(completionBlock: @escaping(_ error : Error?) -> Void)
    func deletePlayer(player: Player, competionBlock: @escaping(_ error: Error?) -> Void)
    func updatePlayer(player: Player, name: String, competionBlock: @escaping(_ error: Error?) -> Void)
    func updatePlayerDrinks(player: Player, drinks: Int, gameType: String, competionBlock: @escaping(_ error: Error?, _ bonus: Bool?, _ player: Player?) -> Void)
    func updatePlayerUseBonus(player: Player, bonus: Int, competionBlock: @escaping(_ error: Error?) -> Void)
    
}
