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
    
    
    override func viewDidLoad() {
        subscribeForNotification(name: .updateGameData, selector: #selector(updateGameData), object: nil)
        subscribeForNotification(name: .endGame, selector: #selector(dismissGame), object: nil)

        updateGameData()
        self.view.addBlurBackground()
        curveTopCorners()
        self.view.layoutIfNeeded()
        super.viewDidLoad()
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
        infoPopVC.modalPresentationStyle = .overFullScreen
        self.present(infoPopVC, animated: true, completion: nil)
    }
    
    @objc func dismissGame() {
        if GameManagement.sharedInstance.selectedMode == 0 {
            // Simple Game
            self.dismiss(animated: true, completion: nil)
        } else if GameManagement.sharedInstance.selectedMode == 1 {
            // Combinate Game
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            // Battle Game
           self.dismiss(animated: true, completion: nil)
        }
        GameManagement.sharedInstance.selectedMode = 0
    }
    
    @objc func updateGameData() {
        playedGameCounter.text = "\(GameManagement.sharedInstance.actuallyPlayedGameCounter)"
        PlayerName.text = GameManagement.sharedInstance.actuallyPlayerName
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

extension UIView {
    func addBlurBackground() {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])

    }
}

extension UIViewController {
    func curveTopCorners() {
        let path = UIBezierPath(roundedRect: self.view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 30, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}
