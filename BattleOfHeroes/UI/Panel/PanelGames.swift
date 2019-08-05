//
//  PanelGames.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/11/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import Panels
import TTSegmentedControl
import Arrows
import MDCCommon

class PanelGames: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var gameSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var arrowView: ArrowView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scoreCollectCheckBox: CheckboxButton!
    @IBOutlet weak var bonusCheckBox: CheckboxButton!
    @IBOutlet weak var randomPictogramCheckBox: CheckboxButton!
    @IBOutlet weak var groupDrinkCheckBox: CheckboxButton!
    
    @IBOutlet weak var bonusStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLevelCounterView()
        
        //self.view.addBlurBackground()
        self.curveTopCorners()
        arrowView.update(to: .up, animated: true)
        arrowView.arrowColor = #colorLiteral(red: 0.2745098039, green: 0.7450980392, blue: 0.631372549, alpha: 1)
        nextButton.layer.cornerRadius = 8
        nextButton.titleLabel?.text = "SetUpGameViewController_nextButton".localized()
        gameSegmentedControl.defaultTextFont = UIFont.rubic(19)
        gameSegmentedControl.selectedTextFont = UIFont.rubic(19)
        bonusStackView.isHidden = false
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .down
        dataView.addGestureRecognizer(swipe)
        scoreCollectCheckBox.on = true
        GameManagement.sharedInstance.drininkCounterView = true
        
        Factory.shared.showBonusView = true
        bonusCheckBox.on = true
    }
    
    @objc func swipeDown() {
        self.panelDidCollapse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        GameSetup.sharedInstance.createGame { (error) in
            let management = GameManagement.sharedInstance
            guard management.networkAvailable || management.chosenGames.contains(where: { $0.downloadsData == false }) else {
                MDCAlertPresenter.showAlert(title: "Hiba!",
                                            message: "Nincs internetkapcsolat és nincs kiválasztva olyan játék, ami ne igényelne internet hozzáférést!",
                                            presentingViewController: self,
                                            dismissButtonTitle: "Ok")
                return
            }
            
            if error == nil {
                print("Success to Create Game")
                postNotification(name: .gameNext)
            } else {
                postNotification(name: .gameNext)
                print("Error to download Games")
            }
        }
        
    }
    
    @IBAction func bonusAction(_ sender: Any) {
        if bonusCheckBox.on {
            Factory.shared.showBonusView = true
            bonusCheckBox.on = true
            print("Bonus view ON")
        } else {
            Factory.shared.showBonusView = false
            bonusCheckBox.on = false
            print("Bonus view OFF")
        }
    }
    
    @IBAction func randomPictogramAction(_ sender: Any) {
        if randomPictogramCheckBox.on {
            Factory.shared.randomPictogramAllow = true
            randomPictogramCheckBox.on = true
            print("Random Pictogram view ON")
        } else {
            Factory.shared.randomPictogramAllow = false
            randomPictogramCheckBox.on = false
            print("Random Pictogram view OFF")
        }
    }
    
    @IBAction func groupDrinkAction(_ sender: Any) {
        if groupDrinkCheckBox.on {
            Factory.shared.groupDrinksAllow = true
            groupDrinkCheckBox.on = true
            print("Group Drink view ON")
        } else {
            Factory.shared.groupDrinksAllow = false
            groupDrinkCheckBox.on = false
            print("Group Drink view OFF")
        }
    }
    
    @IBAction func scoreCollectAction(_ sender: Any) {
        if scoreCollectCheckBox.on {
            GameManagement.sharedInstance.drininkCounterView = true
            bonusStackView.isHidden = false
            scoreCollectCheckBox.on = true
            print("Score view ON")
        } else {
            GameManagement.sharedInstance.drininkCounterView = false
            bonusStackView.isHidden = true
            scoreCollectCheckBox.on = false
            bonusCheckBox.on = false
            Factory.shared.showBonusView = false
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
                Factory.shared.gameDrinkMultiplier = 1
            case 1:

                Factory.shared.gameDrinkMultiplier = 2
            case 2:

                Factory.shared.gameDrinkMultiplier = 3
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
