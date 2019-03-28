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
    var levelCounter : String?
    var gameInLevel : Int = 1
    var gameLevel : Int = 1
    
    var tap: UITapGestureRecognizer!
    var actuallyInfo: String?
    //var infoDescription: String?
    
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

        if GameManagement.sharedInstance.drininkCounterView == true {
            GameManagement.sharedInstance.leveLGameDict.removeFirst()
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrinkCounterViewController") as! DrinkCounterViewController
            popOverVC.modalPresentationStyle = .overFullScreen
            
            if GameManagement.sharedInstance.userDefDrinkVariation == true {
                popOverVC.drinkValue = drinkSegCount
            } else {
                popOverVC.drinkValue = GameManagement.sharedInstance.drinkVariation
            }
            
            if let topController = UIApplication.topViewController() {
                topController.present(popOverVC, animated: true, completion: {
                    self.removeFromSuperview()
                })
            }
        } else {
             if GameManagement.sharedInstance.selectedMode == 1 {
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BattleResultViewController") as! BattleResultViewController
                popOverVC.modalPresentationStyle = .overFullScreen
                if let topController = UIApplication.topViewController() {
                    topController.present(popOverVC, animated: true, completion: {
                        self.removeFromSuperview()
                    })
                }
            }
            GameManagement.sharedInstance.leveLGameDict.removeFirst()
            print("Drinking Counter Off")
            self.removeFromSuperview()
        }
        
        

    }
}
