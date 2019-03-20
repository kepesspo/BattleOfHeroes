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
    
    var personData : [String] = []
    var drinkCountToCounter = 0
    
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
        personData = GameManagement.sharedInstance.personWhoDrinks
        drinkCountToCounter = GameManagement.sharedInstance.personDrinkCount
        
        if GameManagement.sharedInstance.drininkCounterView == true {
            GameManagement.sharedInstance.leveLGameDict.removeFirst()
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrinkCounterViewController") as! DrinkCounterViewController
            popOverVC.person = personData
            popOverVC.drinkCount = drinkCountToCounter
            
            popOverVC.modalPresentationStyle = .overFullScreen
            if let topController = UIApplication.topViewController() {
                topController.present(popOverVC, animated: true, completion: {
                    self.removeFromSuperview()
                })
            }
        } else {
            GameManagement.sharedInstance.leveLGameDict.removeFirst()
            print("Drinking Counter Off")
            self.removeFromSuperview()
        }
        
        

    }
}
