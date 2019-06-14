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

class PanelGames: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var gameSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var levelDrinkLabel: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLevelCounterView()
        dataView.layer.cornerRadius = 10
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
    
    func setUpLevelCounterView() {
        gameSegmentedControl.itemTitles = ["Könnyű","Kőzepes","Nehéz"]
        gameSegmentedControl.layer.cornerRadius = 5
        gameSegmentedControl.allowChangeThumbWidth = false
        gameSegmentedControl.didSelectItemWith = { (index, title) -> () in
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
}
