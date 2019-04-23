//
//  SpectateBonusViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/23/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class SpectateBonusViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okAction(_ sender: Any) {
        NetworkSevice.sharedInstance.playerHowGetDrinksForSpectator(playerName: "Mark") { (error) in
            if error == nil {
                print("Mark added")
            } else {
                print("Error when added spectator drink member")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
