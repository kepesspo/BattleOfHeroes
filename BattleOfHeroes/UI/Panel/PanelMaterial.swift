//
//  PanelMaterial.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/10/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon
import Panels
import Lottie

class PanelMaterial: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var playedGameCounter: UILabel!
    @IBOutlet weak var endGameView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var nextGameView: UIView!
    @IBOutlet weak var showRoomView: UIView!
    @IBOutlet weak var playerFigureImageView: UIImageView!
    @IBOutlet weak var figureCornerView: UIView!
    @IBOutlet weak var newPlayerView: UIView!
    @IBOutlet weak var playerAnimationView: LOTAnimationView!
    
    
    override func viewDidLoad() {
        self.view.layoutIfNeeded()
        super.viewDidLoad()
        
        endGameView.layer.cornerRadius = 10
        scoreView.layer.cornerRadius = 10
        nextGameView.layer.cornerRadius = 10
        showRoomView.layer.cornerRadius = 10
        newPlayerView.layer.cornerRadius = 10
        
        headerPanel.backgroundColor = .white
        headerPanel.curveTopCorners()
        
        figureCornerView.layer.cornerRadius = figureCornerView.frame.size.width/2
        figureCornerView.clipsToBounds = true

        figureCornerView.layer.borderColor = UIColor.white.cgColor
        figureCornerView.layer.borderWidth = 5.0
        
        subscribeForNotification(name: .updateGameData, selector: #selector(updateGameData), object: nil)
        subscribeForNotification(name: .endGame, selector: #selector(dismissGame), object: nil)
        //playAnimation()
        updateGameData()
        showRoomView.isHidden = true
        if GameManagement.sharedInstance.drininkCounterView {
            scoreView.isUserInteractionEnabled = true
            scoreView.backgroundColor = UIColor(fromHexString: "46BEA1", alpha: 1.0, useDisplayP3RGB: false)
        } else {
            scoreView.isUserInteractionEnabled = false
            scoreView.backgroundColor = UIColor(fromHexString: "46BEA1", alpha: 0.6, useDisplayP3RGB: false)
        }
        
        figureCornerView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func playAnimation() {
        playerAnimationView.loopAnimation = true
        playerAnimationView.play()
        
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
        
        infoPopVC.image = Factory.shared.actualGame?.gameImage
        infoPopVC.titleText = Factory.shared.actualGame?.name
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
        figureCornerView.isHidden = false
        playedGameCounter.text = "\(Factory.shared.playedGame)"
        PlayerName.text = Factory.shared.actuallyPlayer?.playerName
        if let image =  Factory.shared.actuallyPlayer?.color {
            playerFigureImageView.image = UIImage(named: image)
        }
    }
    
    
    @IBAction func endGameAction(_ sender: Any) {
        showEndGameView()
    }
    
    @IBAction func scoreAction(_ sender: Any) {
        showScoreView()
    }
    
    @IBAction func showInfoDesc(_ sender: Any) {
        if let gameDescription = Factory.shared.actualGame?.description {
            showInfoView(description: gameDescription)
        }
        
    }
    
    @IBAction func showRoomData(_ sender: Any) {
        
    }
    
    @IBAction func addPlayerAction(_ sender: Any) {
        let addPlayerAlert = UIAlertController(title: "Játékos Hozzáadása:", message: "Addj hozzá egy játékost a megjobb játék élményért", preferredStyle: UIAlertController.Style.alert)
        
        addPlayerAlert.addTextField { (textField) in
            textField.placeholder = "Játékos Neve:"
        }
        addPlayerAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            let textField = addPlayerAlert.textFields![0]
            let player = Player(id: "", playerName: textField.text!, teamId: "", allDrink: 0, usedBonus: 0, color: Factory.shared.figures.randomElement()!)
            Factory.shared.dataManager.createPlayer(player: player, competionBlock: { (error) in
                if error == nil {
                    print("Player added to list")
                }
            })
        }))
        
        addPlayerAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        
        present(addPlayerAlert, animated: true, completion: nil)
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

extension PanelMaterial: PanelNotifications {
    func panelDidPresented() {
        
    }
    
    func panelDidCollapse() {
    }
    
    func panelDidOpen() {
        
    }
    
    
}
