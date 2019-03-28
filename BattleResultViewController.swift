//
//  BattleResultViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 3/27/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

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
    
    func checkTheWinner() -> Bool {
        if GameManagement.sharedInstance.battlePlayerOneValue == 10 {
            winnerView.isHidden = false
            nextGameBtn.setTitle("Vége", for: .normal)
            winnerLabel.text = playerList[0].playerName
            return true
        } else if GameManagement.sharedInstance.battlePlayerTwoValue == 10 {
            winnerView.isHidden = false
            nextGameBtn.setTitle("Vége", for: .normal)
            winnerLabel.text = playerList[1].playerName
            return true
        } else {
            print("No Winner")
            return false
        }
        
    }
    
    @IBAction func playerOneAction(_ sender: Any) {
        GameManagement.sharedInstance.battlePlayerOneValue = GameManagement.sharedInstance.battlePlayerOneValue + 1
        if checkTheWinner() {
            print("Winner")
            nextGameBtn.isHidden = false
        } else {
            playerOneBtn.setTitle("\(playerList[0].playerName) \(GameManagement.sharedInstance.battlePlayerOneValue) pont", for: .normal)
            nextGameBtn.isHidden = false
            playerOneBtn.isEnabled = false
        }
    }
    
    @IBAction func playerTwoAction(_ sender: Any) {
        GameManagement.sharedInstance.battlePlayerTwoValue = GameManagement.sharedInstance.battlePlayerTwoValue + 1
        if checkTheWinner() {
            print("Winner")
            nextGameBtn.isHidden = false
        } else {
            playerTwoBtn.setTitle("\(playerList[1].playerName) \(GameManagement.sharedInstance.battlePlayerTwoValue) pont", for: .normal)
            nextGameBtn.isHidden = false
            playerTwoBtn.isEnabled = false
            
        }
    }
    
    @IBAction func nextGameAction(_ sender: Any) {
        if checkTheWinner() {
            GameManagement.sharedInstance.battlePlayer = []
            self.dismiss(animated: true, completion: nil)
            postNotification(name: .endGame)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
       
    }
}
