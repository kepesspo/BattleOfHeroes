//
//  LoginViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import Reachability
import TTSegmentedControl

class LoginViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var createGame: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var gameTypeSegmentedControl: TTSegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        gameTypeSegmentedControl.itemTitles = ["Online", "Offline"]
        gameTypeSegmentedControl.layer.cornerRadius = 7
        gameTypeSegmentedControl.defaultTextFont = UIFont.rubic(19)
        gameTypeSegmentedControl.selectedTextFont = UIFont.rubic(19)
        gameTypeSegmentedControl.defaultTextColor = #colorLiteral(red: 0.01176470588, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        gameTypeSegmentedControl.allowChangeThumbWidth = false
        gameTypeSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("Online Mode")
            case 1:
                print("Offline Mode")
            default:
                print("Default")
            }
            print("Selected item \(index)")  
        }
        
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
        NetworkSevice.sharedInstance.checkCreateExistingRoom(gameName: generateRoomId, competionBlock: { (error, success) in
            if success == true {
                let room = Room(id: "", gameRoom: generateRoomId, gameRun: false, randomMemberShow: false, playerNameWhoGetDrinks: "")
                NetworkSevice.sharedInstance.addGameToDatabase(room: room) { (error) in
                    if error == nil {
                        UserDefaults.standard.set(generateRoomId, forKey: UserDefaultsKeys.roomName)
                        print("Success created Game")
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        print("Error")
                    }
                }
            } else {
                self.startEmptyLogin()
            }
        })
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
