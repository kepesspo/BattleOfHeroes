//
//  GameView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/8/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class GameView : UIView {
    var gameCounter : String?
    var tap: UITapGestureRecognizer!
    var actuallyInfo: String?
    var personData : [String] = []
    var drinkSegCount = [0,1,2,3]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        GameManagement.sharedInstance.horseRaceBettingPlayer = []
        NetworkSevice.sharedInstance.horseRaceRunning(isRun: false) { (error) in
            if error == nil {
                print("Horse race with database work")
            } else {
                print("error")
            }
        }

        
        if GameManagement.sharedInstance.drininkCounterView == true {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrinkCounterViewController") as! DrinkCounterViewController
            popOverVC.modalPresentationStyle = .overFullScreen
            
            popOverVC.game = GameManagement.sharedInstance.actuallyGame
            let player = GameManagement.sharedInstance.actuallyPlayer
            
            if GameManagement.sharedInstance.actuallyGameType == 0 {
                print("Egyéni")
                popOverVC.player = player
            } else {
                print("Csapat")
                popOverVC.player = nil
            }
            
            if let topController = UIApplication.topViewController() {
                topController.present(popOverVC, animated: true, completion: {
                    self.removeFromSuperview()
                    postNotification(name: .generateNewGame)
                })
            }
        } else {
            self.removeFromSuperview()
            postNotification(name: .generateNewGame)
        }
    }
}
