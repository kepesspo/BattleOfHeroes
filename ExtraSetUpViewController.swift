//
//  ExtraSetUpViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import TTSegmentedControl

class ExtraSetUpViewController: UIViewController {
    
    @IBOutlet weak var uiOptionsView: UIView!
    @IBOutlet weak var moreDrinkingOptionsView: UIView!
    @IBOutlet weak var newOptionsView: UIView!
    @IBOutlet weak var randomPictorgram: UIButton!
    @IBOutlet weak var randomGroupDrink: UIButton!
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
        
        GameManagement.sharedInstance.drininkCounterView = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func startGame(_ sender: Any) {
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
    }
    
    func setUpView() {
        setUpDrinkCounter()
        setUpGroupDrinkView()
        setUpRandomPictogramView()
        setUpLevel()
        
        uiOptionsView.layer.cornerRadius = 10
        moreDrinkingOptionsView.layer.cornerRadius = 10
        newOptionsView.layer.cornerRadius = 10
        
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
    
    func setUpRandomPictogramView() {
        randomPictogramSegmentedControl.itemTitles = ["On","Off"]
        randomPictogramSegmentedControl.layer.cornerRadius = 5
        randomPictogramSegmentedControl.allowChangeThumbWidth = false
        randomPictogramSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("On")
                Factory.shared.randomPictogramAllow = true
            case 1:
                print("Off")
                Factory.shared.randomPictogramAllow = false

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
                Factory.shared.groupDrinksAllow = true
                
            case 1:
                print("Off")
                Factory.shared.groupDrinksAllow = false
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
        }
    }
    
    @IBAction func randomPictogramAction(_ sender: UISlider) {
        if randomPictogramChecked {
            Factory.shared.randomPictogramTime = Int.random(in: 10...30)
        } else {
            let currentValue = Int(sender.value)
            Factory.shared.randomPictogramTime = currentValue * 60
            randomPictogramLabel.text = "\(currentValue) Perc"
        }
        
    }
    
    @IBAction func randomGroupDrinkAction(_ sender: UISlider) {
        if randomGroupDrinkChecked {
            Factory.shared.groupDrinkTime = Int.random(in: 10...30)
        } else {
            let currentValue = Int(sender.value)
            Factory.shared.groupDrinkTime = currentValue * 60
            randomGroupDrinkLabel.text = "\(currentValue) Perc"
        }
        
    }
    
    
    @IBAction func randomPictogramTapped(_ sender: Any) {
        
        if randomPictogramChecked {
            randomPictogramChecked = false
            randomPictorgram.setTitle("Rand", for: .normal)
            randomPictorgram.setBackgroundImage(nil, for: .normal)
            randomPictogramSlider.isHidden = false
            randomPictogramLabel.isHidden = false
            
        } else {
            randomPictogramChecked = true
            randomPictorgram.setTitle("", for: .normal)
            randomPictorgram.setBackgroundImage(#imageLiteral(resourceName: "check-mark-button.png"), for: .normal)
            let currentValue = Int.random(in: 10...30)
            Factory.shared.groupDrinkTime = currentValue * 60
            randomPictogramSlider.isHidden = true
            randomPictogramLabel.isHidden = true
        }
    }
    
    @IBAction func randomGropDrinkTapped(_ sender: Any) {
        if randomGroupDrinkChecked {
            randomGroupDrinkChecked = false
            randomGroupDrink.setTitle("Rand", for: .normal)
            randomGroupDrink.setBackgroundImage(nil, for: .normal)
            randomGroupDrinkingSlider.isHidden = false
            randomGroupDrinkLabel.isHidden = false
        } else {
            randomGroupDrinkChecked = true
            randomGroupDrink.setTitle("", for: .normal)
            randomGroupDrink.setBackgroundImage(#imageLiteral(resourceName: "check-mark-button.png"), for: .normal)
            let currentValue = Int.random(in: 10...30)
            Factory.shared.groupDrinkTime = currentValue * 60
            randomGroupDrinkingSlider.isHidden = true
            randomGroupDrinkLabel.isHidden = true
        }
    }
}
