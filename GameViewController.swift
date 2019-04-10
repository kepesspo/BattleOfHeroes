 //
 //  GameViewController.swift
 //  BattleOfHeroes
 //
 //  Created by Mark on 8/1/18.
 //  Copyright © 2018 Mark. All rights reserved.
 //
 
 import UIKit
 
 class GameViewController: UIViewController {
    var gameCounter : Int = 0
    var previousRandomIndex = 100
    var chosenGames : [Game] = [Game]()
    
    @IBOutlet weak var endGameTabButton: UIButton!
    @IBOutlet weak var scoreTabButton: UIButton!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var letPlayText: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    
    
    var groupDrinkTimer : Timer?
    var randomPictogramTimer : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.isHidden = true
        subscribeForNotification(name: .endGame, selector: #selector(dismissGame), object: nil)
        subscribeForNotification(name: .reloadGroupDrinkTimer, selector: #selector(showGroupDrinkView), object: nil)
        subscribeForNotification(name: .randomPictogram, selector: #selector(showRandomPictogram), object: nil)
        subscribeForNotification(name: .generateNewGame, selector: #selector(startGameAction), object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(startGameAction))
        levelImageView.isUserInteractionEnabled = true
        levelImageView.addGestureRecognizer(tap)
        
        GameManagement.sharedInstance.setCopyCardsList()
        chosenGames = GameManagement.sharedInstance.chosenGames

        showGroupDrinkView()
        showRandomPictogram()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func startGameAction() {
            letPlayText.isHidden = true
            showView()
    }
    
    //Extra Game
    @objc func showGroupDrinkView() {
        let time = GameManagement.sharedInstance.groupDrinkTime
        if GameManagement.sharedInstance.groupDrinksAllow == true {
            self.groupDrinkTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time) , repeats: true, block: { _ in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GroupDrinkViewController") as! GroupDrinkViewController
                self.present(vc, animated: true, completion: nil)
                self.groupDrinkTimer?.invalidate()
                
            })
        }
    }
    
    @objc func showRandomPictogram() {
        let time = GameManagement.sharedInstance.randomPictogramTime
        if GameManagement.sharedInstance.randomPictogramAllow == true {
            self.randomPictogramTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time) , repeats: true, block: { _ in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RandomPictogramViewController") as! RandomPictogramViewController
                self.present(vc, animated: true, completion: nil)
                self.randomPictogramTimer?.invalidate()
                
            })
        }
    }
    
    
    func showView() {
        let randomIndex = Int(arc4random_uniform(UInt32(chosenGames.count)))
        if chosenGames.count == 1 {
            print("Only 1 game")
            generateView(indexOfGame: randomIndex)
        } else {
            print("More than 1 game")
            if previousRandomIndex == randomIndex {
                print("Equal Game")
                showView()
            } else {
                previousRandomIndex = randomIndex
                print("Minden rendbe")
                generateView(indexOfGame: randomIndex)
            }
        }
        
        
    }
    
    
    func generateView(indexOfGame : Int) {
        menuView.isHidden = false
        if let game = chosenGames[indexOfGame].gameMode?.gameView() {
            game.frame = self.view.bounds
            gameCounter = gameCounter + 1
            game.gameCounter = "\(gameCounter)"
            postNotification(name: .addCounterValue)
            GameManagement.sharedInstance.leveLGameDict.append(chosenGames[indexOfGame])
            self.view.insertSubview(game, at: 1)
            print("Game index : \(indexOfGame)")
        }
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
        if GameManagement.sharedInstance.selectedMode == 1 {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    
    @IBAction func scoreAction(_ sender: Any) {
        showScoreView()
    }
    
    @IBAction func endGameAction(_ sender: Any) {
        showEndGameView()
    }
    
    @IBAction func showInfoDesc(_ sender: Any) {
        let gameDescription = GameManagement.sharedInstance.leveLGameDict.first?.description
        showInfoView(description: gameDescription ?? "Itt még nem látsz játékot igy nincs is hozzá leírás")
    }
 }
 
 
 
 
 
 
