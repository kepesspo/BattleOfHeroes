//
//  BattleResultViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 3/27/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class BattleResultViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var player: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        winnerLabel.text = player?.playerName
        titleLabel.text = "A játék nyertese !"
        if let playerData = player {
            drinkLabel.text = "\(playerData.allDrink) piát ittál meg \(Factory.shared.playedGame) játék alatt"
        }
        
    }
    @IBAction func endGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
