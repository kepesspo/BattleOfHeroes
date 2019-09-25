//
//  EndGameViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 12/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class EndGameViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
    }

    @IBAction func closeAndGameView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showScoreView() {
        let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        scorePopVC.modalPresentationStyle = .overFullScreen
        self.present(scorePopVC, animated: true, completion: nil)
    }
    
    
    @IBAction func showResultView(_ sender: Any) {
        showScoreView()
    }
    
    @IBAction func endGameAction(_ sender: Any) {
        GameManagement.sharedInstance.gameStarted = false
        GameManagement.sharedInstance.chosenGames = []
        
        Factory.shared.playedGame = 0
        Factory.shared.actuallyPlayer = nil
        Factory.shared.playerIndex = 0
        
        Factory.shared.playersPaired = false
        Factory.shared.isPersonalGame = false
        Factory.shared.playerCounter = 0
        
        self.dismiss(animated: false, completion: nil)
        
        postNotification(name: .endGame)
        NetworkSevice.sharedInstance.gameRunning(isRun: false) { (error) in
            if error == nil {
                
                print("Lock Screen for other player")
            } else {
                print("Error Lock Screen for other player ")
            }
        }
        
        NetworkSevice.sharedInstance.horseRaceRunning(isRun: false) { (error) in
            if error == nil {
                print("Horse race with database work")
            } else {
                print("error")
            }
        }
    }
}
