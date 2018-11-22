//
//  LoginViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    
    func setUpView() {
        gameNameTextfield.layer.borderColor = UIColor.black.cgColor
        gameNameTextfield.layer.borderWidth = 4
        gameNameTextfield.layer.cornerRadius = 4
        gameNameTextfield.clipsToBounds = true
        
        gamePassTextField.layer.borderColor = UIColor.black.cgColor
        gamePassTextField.layer.borderWidth = 4
        gamePassTextField.layer.cornerRadius = 4
        gamePassTextField.clipsToBounds = true
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
            
                let room = Room(id: "", gameRoom: roomText, gamePassword: roomPassText)
                NetworkSevice.sharedInstance.addGameToDatabase(room: room) { (error) in
                    if error != nil {
                        print("Error")
                    } else {
                        print("Success created Game")
                    }
                }
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
//        if let name = gameNameTextfield.text,
//            let pass = gamePassTextField.text {
//            NetworkSevice.sharedInstance.roomExist(gameName: name,
//                                                   gamePass: pass) { (error) in
//                                                    if error != nil {
//                                                        print("sikerült")
//                                                    } else {
//                                                        print("nem")
//                                                    }
//            }
//        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
