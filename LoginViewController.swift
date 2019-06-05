//
//  LoginViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import Reachability

class LoginViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var createGame: UIButton!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var gameNameTextfield: UITextField!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var offlineSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tap)
        offlineSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        offlineSwitch.isEnabled = false
        offlineSwitch.layer.borderColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func tapped() {
       gameNameTextfield.resignFirstResponder()
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn == true {
            print("Online")
            gameNameTextfield.isHidden = false
        } else {
            print("Offline")
            gameNameTextfield.isHidden = true
        }
    }
    
    
    func setUpView() {
        gameNameTextfield.layer.borderColor = UIColor.black.cgColor
        gameNameTextfield.layer.borderWidth = 4
        gameNameTextfield.layer.cornerRadius = 4
        gameNameTextfield.clipsToBounds = true
        
        
        self.gameNameTextfield.delegate = self
        
        if DevOptions.autoFill == 1 {
            gameNameTextfield.text = "1371"
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
    
    @IBAction func loginAction(_ sender: Any) {
        if validateLogin() {
            NetworkSevice.sharedInstance.roomExist(gameName: gameNameTextfield.text ?? "") { (error,success)  in
                if success == true {
                    if GameManagement.sharedInstance.isOnboardingClosed() == true {
                        UserDefaults.standard.set(self.gameNameTextfield.text, forKey: UserDefaultsKeys.roomName)
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
        if (gameNameTextfield.text?.isEmpty)! {
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
