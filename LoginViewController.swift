//
//  LoginViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var createGame: UIButton!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var gameNameTextfield: UITextField!
    @IBOutlet weak var gamePassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpView() {
        gameNameTextfield.layer.borderColor = UIColor.black.cgColor
        gameNameTextfield.layer.borderWidth = 4
        gameNameTextfield.layer.cornerRadius = 4
        gameNameTextfield.clipsToBounds = true
        
        gamePassTextField.layer.borderColor = UIColor.black.cgColor
        gamePassTextField.layer.borderWidth = 4
        gamePassTextField.layer.cornerRadius = 4
        gamePassTextField.clipsToBounds = true
        
        self.gamePassTextField.delegate = self
        self.gameNameTextfield.delegate = self
        
        if DevOptions.autoFill == 1 {
            gameNameTextfield.text = "TestA"
            gamePassTextField.text = "TestA"
        }
        
    }
    
    @IBAction func createGameAction(_ sender: Any) {
        
        
        
        
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
    
        
        // Add Team
        let addRoom = UIAlertAction(title: "Add Room", style: .default) { _ in
            if let textField = alert.textFields,
                let roomText = textField[0].text,
                let roomPassText = textField[1].text {
                
                if roomText.isEmpty || roomPassText.isEmpty {
                    let alert = UIAlertController(title: "Warning".localized(),
                                                  message: "Minden mező kitöltése kötelező",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                    return
                }
                
                NetworkSevice.sharedInstance.checkCreateExistingRoom(gameName: roomText, competionBlock: { (error, success) in
                    if success == true {
                        let room = Room(id: "", gameRoom: roomText, gamePassword: roomPassText)
                        NetworkSevice.sharedInstance.addGameToDatabase(room: room) { (error) in
                            if error == nil {
                                UserDefaults.standard.set("", forKey: UserDefaultsKeys.roomId)
                                print("Success created Game")
                               
                            } else {
                                 print("Error")
                            }
                        }
                    } else {
                        print("Ez a szóba már foglalt")
                        let alert = UIAlertController(title: "Warning".localized(),
                                                      message: error,
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                    }
                })
            
                
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Room Name..."
            textField.clearButtonMode = .whileEditing
        }
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Room Pass..."
            textField.clearButtonMode = .whileEditing
        }
        alert.title = " Create Room"
        alert.addAction(addRoom)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if validateLogin() {
            UserDefaults.standard.set(gameNameTextfield.text, forKey: UserDefaultsKeys.roomName)
            UserDefaults.standard.set(gamePassTextField.text, forKey: UserDefaultsKeys.roomPass)
            NetworkSevice.sharedInstance.roomExist(gameName: gameNameTextfield.text ?? "", gamePass: gamePassTextField.text ?? "") { (error,success)  in
                if success == true {
                    if GameManagement.sharedInstance.isOnboardingClosed() == true {
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
        if (gameNameTextfield.text?.isEmpty)! || (gamePassTextField.text?.isEmpty)! {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
