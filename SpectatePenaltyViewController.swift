//
//  SpectatePenaltyViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class SpectatePenaltyViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        nameLabel.text = name
        // Do any additional setup after loading the view.
    }
    

    @IBAction func okAction(_ sender: Any) {
        NetworkSevice.sharedInstance.playerHowGetDrinksForSpectator(playerName: "", completionBlock: { (error) in
            if error == nil {
                print("update spectator bonus name to empty")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error to update spectator bonus name to empty")
            }
        })
        
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
