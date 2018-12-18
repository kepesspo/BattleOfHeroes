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
    var infoDescription: String?
    var buttonInfo: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //subscribeForNotification(name: .dismissGame, selector: #selector(tapped), object: nil)
        configure()
        addInfoButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        addInfoButton()
    }
    
    
    
    func configure() {
        tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tap)
        
        
    }
    
    func addInfoButton() {
        buttonInfo = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        buttonInfo.backgroundColor = .green
        buttonInfo.setTitle("Test Button", for: .normal)
        buttonInfo.addTarget(self, action: #selector(self.showInfo), for: .touchUpInside)
        
    }
    
    @objc func showInfo() {
        let infoPopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        infoPopVC.modalPresentationStyle = .overFullScreen
        infoPopVC.infoText = infoDescription
        if let topController = UIApplication.topViewController() {
            topController.present(infoPopVC, animated: false, completion: {
                self.removeFromSuperview()
            })
            
        }
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
