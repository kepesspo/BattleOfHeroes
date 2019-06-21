//
//  PanelMaterial.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/10/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import Panels

class PanelMaterial: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var playedGameCounter: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var endGameView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var nextGameView: UIView!
    @IBOutlet weak var showRoomView: UIView!
    
    
    override func viewDidLoad() {
        subscribeForNotification(name: .updateGameData, selector: #selector(updateGameData), object: nil)
        subscribeForNotification(name: .endGame, selector: #selector(dismissGame), object: nil)

        updateGameData()
        self.view.addBlurBackground()
        self.curveTopCorners()
        self.view.layoutIfNeeded()
        super.viewDidLoad()
        
        endGameView.layer.cornerRadius = 20
        scoreView.layer.cornerRadius = 20
        nextGameView.layer.cornerRadius = 20
        showRoomView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func showScoreView() {
        let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        scorePopVC.modalPresentationStyle = .overFullScreen
        self.present(scorePopVC, animated: true, completion: nil)
    }
    
    func showEndGameView() {
        let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EndGameViewController") as! EndGameViewController
        scorePopVC.modalPresentationStyle = .overFullScreen
        self.present(scorePopVC, animated: true, completion: nil)
    }
    
    func showInfoView(description: String) {
        let infoPopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        infoPopVC.infoText = description
        //infoPopVC.image = GameManagement.sharedInstance.actuallyGame?.gameImage
        infoPopVC.modalPresentationStyle = .overFullScreen
        self.present(infoPopVC, animated: true, completion: nil)
    }
    
    @objc func dismissGame() {
        if GameManagement.sharedInstance.selectedMode == 0 {
            // Simple Game
             self.navigationController?.popToRootViewController(animated: true)
        } else if GameManagement.sharedInstance.selectedMode == 1 {
            // Combinate Game
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            // Battle Game
            self.navigationController?.popToRootViewController(animated: true)
        }
        GameManagement.sharedInstance.selectedMode = 0
    }
    
    @objc func updateGameData() {
        playedGameCounter.text = "\(GameManagement.sharedInstance.actuallyPlayedGameCounter)"
        PlayerName.text = GameManagement.sharedInstance.actuallyPlayer?.playerName
        typeImageView.image = GameManagement.sharedInstance.actuallyPlayedGameType   
    }
    
    
    @IBAction func endGameAction(_ sender: Any) {
        showEndGameView()
    }
    
    @IBAction func scoreAction(_ sender: Any) {
        showScoreView()
    }
    
    @IBAction func showInfoDesc(_ sender: Any) {
        let gameDescription = GameManagement.sharedInstance.actuallyGameDesc
        showInfoView(description: gameDescription)
    }
    
    @IBAction func showRoomData(_ sender: Any) {
        
    }
    @IBAction func skipGameAction(_ sender: Any) {
        NetworkSevice.sharedInstance.horseRaceRunning(isRun: false) { (error) in
            if error == nil {
                print("Horse race with database work")
            } else {
                print("error")
            }
        }
        
        if let topController = UIApplication.topViewController() {
            if let gameView = topController.view.subviews.filter({ $0 is GameView }).last {
                gameView.removeFromSuperview()
            }
            postNotification(name: .generateNewGame)
        }
        
    }
    
}
