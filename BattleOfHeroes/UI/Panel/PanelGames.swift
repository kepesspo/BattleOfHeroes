//
//  PanelGames.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/11/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import Panels
import TTSegmentedControl
import Arrows

class PanelGames: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var gameSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var arrowView: ArrowView!
    
    @IBOutlet weak var scoreCollectCheckBox: CheckboxButton!
    @IBOutlet weak var bonusCheckBox: CheckboxButton!
    @IBOutlet weak var randomPictogramCheckBox: CheckboxButton!
    @IBOutlet weak var groupDrinkCheckBox: CheckboxButton!
    
    @IBOutlet weak var bonusStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLevelCounterView()
        
        self.view.addBlurBackground()
        self.curveTopCorners()
        arrowView.update(to: .up, animated: true)
        arrowView.arrowColor = #colorLiteral(red: 0.01176470588, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        
        gameSegmentedControl.defaultTextFont = UIFont.rubic(19)
        gameSegmentedControl.selectedTextFont = UIFont.rubic(19)
        bonusStackView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        GameSetup.sharedInstance.createGame { (error) in
            if error == nil {
                print("Success to Create Game")
                postNotification(name: .gameNext)
            } else {
                print("Error to download Games")
            }
        }
        
    }
    
    @IBAction func bonusAction(_ sender: Any) {
        if bonusCheckBox.on {
            GameManagement.sharedInstance.showBonusView = true
            bonusCheckBox.on = true
            print("Bonus view ON")
        } else {
            GameManagement.sharedInstance.showBonusView = false
            bonusCheckBox.on = false
            print("Bonus view OFF")
        }
    }
    
    @IBAction func randomPictogramAction(_ sender: Any) {
        if randomPictogramCheckBox.on {
            GameManagement.sharedInstance.randomPictogramAllow = true
            randomPictogramCheckBox.on = true
            print("Random Pictogram view ON")
        } else {
            GameManagement.sharedInstance.randomPictogramAllow = false
            randomPictogramCheckBox.on = false
            print("Random Pictogram view OFF")
        }
    }
    
    @IBAction func groupDrinkAction(_ sender: Any) {
        if groupDrinkCheckBox.on {
            GameManagement.sharedInstance.groupDrinksAllow = true
            groupDrinkCheckBox.on = true
            print("Group Drink view ON")
        } else {
            GameManagement.sharedInstance.groupDrinksAllow = false
            groupDrinkCheckBox.on = false
            print("Group Drink view OFF")
        }
    }
    
    @IBAction func scoreCollectAction(_ sender: Any) {
        if scoreCollectCheckBox.on {
            //GameManagement.sharedInstance.groupDrinksAllow = true
            bonusStackView.isHidden = false
            scoreCollectCheckBox.on = true
            print("Score view ON")
        } else {
            //GameManagement.sharedInstance.groupDrinksAllow = false
            bonusStackView.isHidden = true
            scoreCollectCheckBox.on = false
            bonusCheckBox.on = false
            GameManagement.sharedInstance.showBonusView = false
            print("Score view OFF")
        }
    }
    
    func setUpLevelCounterView() {
        gameSegmentedControl.itemTitles = ["Könnyű","Közepes","Nehéz"]
        gameSegmentedControl.layer.cornerRadius = 7
        gameSegmentedControl.allowChangeThumbWidth = false
        gameSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                GameManagement.sharedInstance.gameDrinkMultiplier = 1
            case 1:

                GameManagement.sharedInstance.gameDrinkMultiplier = 2
            case 2:

                GameManagement.sharedInstance.gameDrinkMultiplier = 3
            default:
                print("Default")
            }
            print("Selected item \(index)")
        }
    }
}
extension PanelGames: PanelNotifications {
    func panelDidPresented() {
        arrowView.update(to: .middle, animated: true)
    }
    
    func panelDidCollapse() {
        arrowView.update(to: .up, animated: true)
    }
    
    func panelDidOpen() {
        arrowView.update(to: .down, animated: true)
    }
    
    
}
