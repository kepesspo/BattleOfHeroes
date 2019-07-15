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

    @IBOutlet weak var playerOneBtn: UIButton!
    @IBOutlet weak var playerTwoBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextGameBtn: UIButton!
    @IBOutlet weak var winnerView: UIView!
    @IBOutlet weak var winnerLabel: UILabel!
    let playerList = NetworkSevice.sharedInstance.playerList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        nextGameBtn.isHidden = true
        winnerView.isHidden = true
        winnerView.layer.cornerRadius = 10
        
        playerOneBtn.layer.cornerRadius = 10
        playerTwoBtn.layer.cornerRadius = 10
        playerOneBtn.setTitle(playerList[0].playerName, for: .normal)
        playerTwoBtn.setTitle(playerList[1].playerName, for: .normal)
    }
}
