//
//  PanelMenu.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/12/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import Panels

class PanelMenu: UIViewController, UIScrollViewDelegate, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var spectatorBtn: UIButton!
    @IBOutlet weak var closeRoomBtn: UIButton!
    @IBOutlet weak var dataView: UIView!
    
    var roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName)
    var roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        dataView.layer.cornerRadius = 10
        subscribeForNotification(name: .updateStartButton, selector: #selector(updateStartButton))
        
        NetworkSevice.sharedInstance.getGameRunning { (error, value) in
            if value == 1 {
                GameManagement.sharedInstance.selectedSpac = 4
                GameManagement.sharedInstance.isSpactate = true
                self.triggeredGameMode()
            } else {
                GameManagement.sharedInstance.selectedSpac = 0
                GameManagement.sharedInstance.isSpactate = false
                 self.triggeredGameMode()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
    @objc func updateStartButton() {
        if NetworkSevice.sharedInstance.playerList.count == 0 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }

    func triggeredGameMode() {
        if GameManagement.sharedInstance.selectedSpac == 4 {
            GameManagement.sharedInstance.selectedMode = 4
        } else {
            GameManagement.sharedInstance.selectedMode = 0
        }
    }
    
    @IBAction func gameButtonAction(_ sender: Any) {
        switch GameManagement.sharedInstance.selectedMode {
        case 0:
            NetworkSevice.sharedInstance.getPlayerList { (error) in
                if error == nil {
                    print("No error")
                } else {
                    print("Error")
                }
            }
            self.startGame()
        case 4:
            let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            scorePopVC.modalPresentationStyle = .overFullScreen
            self.present(scorePopVC, animated: true, completion: nil)
        default:
            print("Def switch")
        }
        
        if GameManagement.sharedInstance.selectedMode == 4 {
            print("No game Start")
        } else {
            if GameManagement.sharedInstance.selectedMode == 0 {
                updateGameRun(value: true)
            } else {
                print("No Battle Player")
            }
        }
    }

    func updateGameRun(value: Bool) {
        NetworkSevice.sharedInstance.gameRunning(isRun: true) { (error) in
            if error == nil {
                print("Lock Screen for other player")
            } else {
                print("Error Lock Screen for other player ")
            }
        }
    }
    
    
    @IBAction func normalGameAction(_ sender: Any) {
        GameManagement.sharedInstance.selectedMode = 0
        postNotification(name: .gameModeChanged)
    }
    
    @IBAction func spectatorGameAction(_ sender: Any) {
        print("Spactator")
        GameManagement.sharedInstance.selectedMode = 4
        postNotification(name: .gameModeChanged)
    }
    
    @IBAction func closeRoomAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func startGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        let setUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUpGameViewController") as! SetUpGameViewController
        self.navigationController?.pushViewController(setUpVc, animated: true)
    }
    
    
}
