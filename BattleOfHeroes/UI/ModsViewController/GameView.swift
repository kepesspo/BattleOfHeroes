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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //subscribeForNotification(name: .dismissGame, selector: #selector(tapped), object: nil)
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
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrinkCounterViewController") as! DrinkCounterViewController
        popOverVC.modalPresentationStyle = .overFullScreen
        
        if let topController = UIApplication.topViewController() {
            topController.present(popOverVC, animated: false, completion: {
                self.removeFromSuperview()
            })
            
        }
        

    }
}
