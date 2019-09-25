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
    @IBOutlet weak var modeSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var arrowView: ArrowView!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scoreCollectCheckBox: CheckboxButton!
    @IBOutlet weak var bonusCheckBox: CheckboxButton!
    @IBOutlet weak var extraGameCheckBox: CheckboxButton!
    
    @IBOutlet weak var bonusStackView: UIStackView!
    @IBOutlet weak var scoreStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLevelCounterView()
        
        //self.view.addBlurBackground()
        self.curveTopCorners()
        arrowView.update(to: .up, animated: true)
        arrowView.arrowColor = #colorLiteral(red: 0.1960784314, green: 0.2588235294, blue: 0.3176470588, alpha: 1)
        nextButton.layer.cornerRadius = 8
        nextButton.titleLabel?.text = "SetUpGameViewController_nextButton".localized()
        gameSegmentedControl.defaultTextFont = UIFont.rubic(19)
        gameSegmentedControl.selectedTextFont = UIFont.rubic(19)
        
        modeSegmentedControl.defaultTextFont = UIFont.rubic(19)
        modeSegmentedControl.selectedTextFont = UIFont.rubic(19)
        modeSegmentedControl.selectItemAt(index: 0)
        
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .down
        dataView.addGestureRecognizer(swipe)
        
        GameManagement.sharedInstance.drininkCounterView = false
        Factory.shared.showBonusView = false
        bonusStackView.isHidden = true
        scoreStackView.isHidden = true
        
        sliderValue.text = "10"
        
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
    
    @IBAction func extraGameAction(_ sender: Any) {
        if extraGameCheckBox.on {
            Factory.shared.randomPictogramAllow = true
            Factory.shared.groupDrinksAllow = true
            extraGameCheckBox.on = true
            print("Random Pictogram view ON")
        } else {
            Factory.shared.randomPictogramAllow = false
            Factory.shared.groupDrinksAllow = false
            extraGameCheckBox.on = false
            print("Random Pictogram view OFF")
        }
    }

    
    
    func setUpLevelCounterView() {
        modeSegmentedControl.itemTitles = ["Sima","Pontgyüjtés"]
        modeSegmentedControl.layer.cornerRadius = 7
        modeSegmentedControl.allowChangeThumbWidth = false
        modeSegmentedControl.didSelectItemWith = { (index, title) -> ()in
            switch index {
            case 0:
                print("Sima")
                GameManagement.sharedInstance.drininkCounterView = false
                GameManagement.sharedInstance.scoreRateIsOn = false
                Factory.shared.showBonusView = false
                self.bonusStackView.isHidden = true
                self.scoreStackView.isHidden = true
                self.bonusCheckBox.on = false
                
            case 1:
                print("Pontgyüjtés")
                GameManagement.sharedInstance.drininkCounterView = true
                GameManagement.sharedInstance.scoreRateIsOn = true
                Factory.shared.showBonusView = true
                self.bonusStackView.isHidden = false
                self.scoreStackView.isHidden = false
                self.bonusCheckBox.on = true
                print("Score view ON")
            default:
                print("Default")
            }
            print("Selected item \(index)")
        }
        
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
    
    @IBAction func sliderValueChange(_ sender: Any) {
        let score = Int(slider.value)
        sliderValue.text = "\(score)"
        GameManagement.sharedInstance.scoreRate = score
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
