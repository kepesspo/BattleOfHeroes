//
//  GameSetup.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/13/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class GameSetup {
    static let sharedInstance = GameSetup()
    
    
    func showLoaderView() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoaderViewController") as! LoaderViewController
        popOverVC.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.topViewController() {
            topController.present(popOverVC, animated: true, completion: nil)
            
        }
    }
    
    func dissmissLoaderView(completionBlock: @escaping() -> Void) {
        if let topController = UIApplication.topViewController() {
            topController.dismiss(animated: true, completion: {
                completionBlock()
            })
        }
    }
    
    func createGame(completionBlock: @escaping(_ error: Error?) -> Void) {
        if GameManagement.sharedInstance.chosenGames.count == 0 {
            let management = GameManagement.sharedInstance
            management.chosenGames = management.games
        }
        self.showLoaderView()
        self.dissmissLoaderView(completionBlock: {
            self.loadAllGameData { error in
                completionBlock(error)
            }
        })
    }
    
    
    func loadAllGameData(completion: ((_ error: Error?) -> Void)?) {
        guard GameManagement.sharedInstance.networkWorks else {
            completion?(MyError.noInternetAccess)
            return
        }
        
        var remainingCompletions = 0
        var errors = ""
        
        for game in GameManagement.sharedInstance.chosenGames {
            if game.downloadsData {
                remainingCompletions += 1
            }
        }
        
        let returnedBlock: ((_ error: Error?) -> Void) = { error in
            errors.append("\(error?.localizedDescription ?? "")\n")
            if remainingCompletions == 0 {
                completion?(error)
            } else {
                remainingCompletions -= 1
            }
            
        }
        
        for game in GameManagement.sharedInstance.chosenGames {
            switch game.name {
            case "Ki Vagyok Én":
                NetworkSevice.sharedInstance.getFamousPersons { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. famous person sikeresen letöltödőt.")
                    }
                }
            case "Igaz Hamis":
                NetworkSevice.sharedInstance.getTrueOrFalse { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Igaz Hamis kérdések sikeresen letöltödőt.")
                    }
                }
            case "Én még soha":
                NetworkSevice.sharedInstance.getHaveIEverNever { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Én még soha kérdések sikeresen letöltödőt.")
                    }
                }
            case "Zene Felismerés":
                NetworkSevice.sharedInstance.getSongs { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Minden zene sikeresen letöltödőt.")
                    }
                }
            case "Anagramma":
                NetworkSevice.sharedInstance.getAnagrammaWord { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Minden Anagramma sikeresen letöltödőt.")
                    }
                }
            default:
                print("Nem kell letölteni semit.")
                
            }
        }
        returnedBlock(nil)
    }
}
