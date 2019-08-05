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
        createGame.titleLabel?.text = "LoginViewController_LoginButton".localized()
        // Defult GameType : Online
        Factory.shared.dataManager = OfflineService()
        self.spectateButton.isHidden = false
        
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
            let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String{
            let version = "LoginViewController_VersionLabel".localized()
            versionLabel.text = "\(version): \(appVersion)"
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
    
    @IBAction func instagramAction(_ sender: Any) {
        let instagramProfile = "instagram://user?username=bottleofheroes"
        let instagramUrl = URL(string: instagramProfile)
        if let instaUrl = instagramUrl, UIApplication.shared.canOpenURL(instagramUrl!) {
            UIApplication.shared.open(instaUrl, options: [:], completionHandler: nil)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.open(URL(string: "http://instagram.com/bottleofheroes")!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        // text to share
        let text = "Még ne oszd meg a játékot mert tesztelés alatt van"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.mail, UIActivity.ActivityType.message]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func languangeAction(_ sender: Any) {
        let hun = MDCAlertAction.init(title: "Magyar")
        let english = MDCAlertAction.init(title: "Angol")
        let ok = MDCAlertAction.init(title: "OK",style: .destructive)
        MDCAlertPresenter.showAlert(title: "Nyelv választó!",
                                    message:  "Válasz a nyevek kőzűl.",
                                    presentingViewController: self,
                                    actions: [hun,english,ok])
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
