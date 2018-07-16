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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createGameAction(_ sender: Any) {
        NetworkSevice.sharedInstance.addGameToDatabase { (error) in
            if error != nil {
                print("Error")
            } else {
                print("Success created Game")
            }
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

}
