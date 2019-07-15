//
//  LoginViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import Reachability
import TTSegmentedControl

class LoginViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var createGame: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var spectateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        // Defult GameType : Online
        Factory.shared.dataManager = OfflineService()
        self.spectateButton.isHidden = false
        
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
            let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String{
            versionLabel.text = "Verzió: \(appVersion) (\(version))"
        }
    }
    
    var fourDigitNumber: String {
        let randomRoomId = Int.random(in: 1000...9999)
        return "\(randomRoomId)"
    }
    
    
    @IBAction func createGameAction(_ sender: Any) {
        startEmptyLogin()
    }
    
    func startEmptyLogin() {
        let generateRoomId = fourDigitNumber
        print(generateRoomId)
        let room = Room(id: generateRoomId, gameRoom: generateRoomId, gameRun: false, randomMemberShow: false, playerNameWhoGetDrinks: "")

        Factory.shared.dataManager.createRoom(room: room) { (error) in
            if error == nil {
                UserDefaults.standard.set(generateRoomId, forKey: UserDefaultsKeys.roomName)
                print("Success created Game")
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func loginWithSpectate() {
        if validateLogin() {
            NetworkSevice.sharedInstance.roomExist(gameName: "") { (error,success)  in
                if success == true {
                    if GameManagement.sharedInstance.isOnboardingClosed() == true {
                        UserDefaults.standard.set("", forKey: UserDefaultsKeys.roomName)
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    print("Warning")
                    let alert = UIAlertController(title: "Warning".localized(),
                                                  message: error,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func validateLogin() -> Bool {
        let roomName = ""
        if (roomName.isEmpty) {
            let alert = UIAlertController(title: "Warning".localized(),
                                          message: "Minden mezőt ki kell tölteni",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
