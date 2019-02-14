//
//  ExtraSetUpViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import TTSegmentedControl

class ExtraSetUpViewController: UIViewController {
    
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var uiOptionsView: UIView!
    @IBOutlet weak var moreDrinkingOptionsView: UIView!
    @IBOutlet weak var newOptionsView: UIView!
    @IBOutlet weak var levelDrinkLabel: UILabel!
    @IBOutlet weak var randomPictorgram: UIButton!
    @IBOutlet weak var randomGroupDrink: UIButton!
    @IBOutlet weak var levelSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var bonusViewSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var drinkCounterSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var randomPictogramSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var groupDrinksSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var randomPictogramSlider: UISlider!
    @IBOutlet weak var randomGroupDrinkingSlider: UISlider!
    @IBOutlet weak var randomPictogramLabel: UILabel!
    @IBOutlet weak var randomGroupDrinkLabel: UILabel!
    @IBOutlet weak var backButton: NSLayoutConstraint!
    @IBOutlet weak var levelScreenSegmentedControl: TTSegmentedControl!
    
    var randomPictogramChecked: Bool = false
    var randomGroupDrinkChecked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        randomPictogramLabel.text = "7p"
        randomGroupDrinkLabel.text = "5p"
        
        GameManagement.sharedInstance.showBonusView = true
        GameManagement.sharedInstance.drininkCounterView = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func randomPictogramTapped(_ sender: Any) {
       
        if randomPictogramChecked {
            randomPictogramChecked = false
            randomPictorgram.setTitle("Random", for: .normal)
            randomPictorgram.setBackgroundImage(nil, for: .normal)
        } else {
            randomPictogramChecked = true
            randomPictorgram.setTitle("", for: .normal)
            randomPictorgram.setBackgroundImage(#imageLiteral(resourceName: "check-mark-button.png"), for: .normal)
        }
    }
    
    @IBAction func randomGropDrinkTapped(_ sender: Any) {
        if randomGroupDrinkChecked {
            randomGroupDrinkChecked = false
            randomGroupDrink.setTitle("Random", for: .normal)
            randomGroupDrink.setBackgroundImage(nil, for: .normal)
        } else {
            randomGroupDrinkChecked = true
            randomGroupDrink.setTitle("", for: .normal)
            randomGroupDrink.setBackgroundImage(#imageLiteral(resourceName: "check-mark-button.png"), for: .normal)
        }
    }
    
    func setUpView() {
        setUpLevelCounterView()
        setUpBonusView()
        setUpDrinkCounter()
        setUpGroupDrinkView()
        setUpRandomPictogramView()
        setUpLevel()
        
        levelView.layer.cornerRadius = 10
        uiOptionsView.layer.cornerRadius = 10
        moreDrinkingOptionsView.layer.cornerRadius = 10
        newOptionsView.layer.cornerRadius = 10
        
    }
    
    func setUpLevelCounterView() {
        levelSegmentedControl.itemTitles = ["Könnyű","Kőzepes","Nehéz"]
        levelSegmentedControl.layer.cornerRadius = 5
        levelSegmentedControl.allowChangeThumbWidth = false
        levelSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                self.levelDrinkLabel.text = "ExtraSetUpViewController_Level_easy".localized()
                GameManagement.sharedInstance.gameDrinkMultiplier = 1
            case 1:
                self.levelDrinkLabel.text = "ExtraSetUpViewController_Level_medim".localized()
                GameManagement.sharedInstance.gameDrinkMultiplier = 2
            case 2:
                self.levelDrinkLabel.text = "ExtraSetUpViewController_Level_hard".localized()
                GameManagement.sharedInstance.gameDrinkMultiplier = 3
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
            
        }
    }
    
    func setUpLevel() {
        levelScreenSegmentedControl.itemTitles = ["On", "Off"]
        levelScreenSegmentedControl.layer.cornerRadius = 5
        levelScreenSegmentedControl.allowChangeThumbWidth = false
        levelScreenSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("Level screen On")
            case 1:
                print("Level screen Off")
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
            
        }
    }
    
    func setUpDrinkCounter() {
        drinkCounterSegmentedControl.itemTitles = ["On","Off"]
        drinkCounterSegmentedControl.layer.cornerRadius = 5
        drinkCounterSegmentedControl.allowChangeThumbWidth = false
        drinkCounterSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("On")
                GameManagement.sharedInstance.drininkCounterView = true
            case 1:
                print("Off")
                GameManagement.sharedInstance.drininkCounterView = false
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
        }
    }
    
    func setUpBonusView() {
        bonusViewSegmentedControl.itemTitles = ["On","Off"]
        bonusViewSegmentedControl.layer.cornerRadius = 5
        bonusViewSegmentedControl.allowChangeThumbWidth = false
        bonusViewSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("On")
                GameManagement.sharedInstance.showBonusView = true
            case 1:
                print("Off")
                GameManagement.sharedInstance.showBonusView = false
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
        }
    }
    
    func setUpRandomPictogramView() {
        randomPictogramSegmentedControl.itemTitles = ["On","Off"]
        randomPictogramSegmentedControl.layer.cornerRadius = 5
        randomPictogramSegmentedControl.allowChangeThumbWidth = false
        randomPictogramSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("On")
                GameManagement.sharedInstance.randomPictogramAllow = true
            case 1:
                print("Off")
                GameManagement.sharedInstance.randomPictogramAllow = false

            default:
                print("Default")
            }
            print("Selected item \(index)")
            
        }
    }
    
    func setUpGroupDrinkView() {
        groupDrinksSegmentedControl.itemTitles = ["On","Off"]
        groupDrinksSegmentedControl.layer.cornerRadius = 5
        groupDrinksSegmentedControl.allowChangeThumbWidth = false
        groupDrinksSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("On")
                GameManagement.sharedInstance.groupDrinksAllow = true
                
            case 1:
                print("Off")
                GameManagement.sharedInstance.groupDrinksAllow = false
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
        }
    }
    
    @IBAction func randomPictogramAction(_ sender: UISlider) {
        if randomPictogramChecked {
            GameManagement.sharedInstance.randomPictogramTime = Int.random(in: 10...30)
        } else {
            let currentValue = Int(sender.value)
            GameManagement.sharedInstance.randomPictogramTime = currentValue
            randomPictogramLabel.text = "\(currentValue) Perc"
        }
        
    }
    
    @IBAction func randfomGroupDrinkAction(_ sender: UISlider) {
        if randomGroupDrinkChecked {
            GameManagement.sharedInstance.grouoDrinkTime = Int.random(in: 10...30)
        } else {
            let currentValue = Int(sender.value)
            GameManagement.sharedInstance.grouoDrinkTime = currentValue
            // * 60
            randomGroupDrinkLabel.text = "\(currentValue) Perc"
        }
        
    }
}
