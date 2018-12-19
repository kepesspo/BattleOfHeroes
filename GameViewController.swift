 //
 //  GameViewController.swift
 //  BattleOfHeroes
 //
 //  Created by Mark on 8/1/18.
 //  Copyright © 2018 Mark. All rights reserved.
 //
 
 import UIKit
 
 enum gameLevels : Int {
    case five = 5
    case ten = 10
    case fifty = 15
    case twenty = 20
 }
 
 class GameViewController: UIViewController {
    var levelCounter : Int = 1
    var gameInLevel : Int = 1
    var previousRandomIndex = 100
    
    @IBOutlet weak var endGameTabButton: UIButton!
    @IBOutlet weak var informationTabButton: UIButton!
    @IBOutlet weak var scoreTabButton: UIButton!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelImageView: UIImageView!
    
    @IBOutlet weak var scoreContainerView: UIView!
    @IBOutlet weak var gameContainerView: UIView!
    
    @IBOutlet weak var inofContainerView: UIView!
    var chosenGames : [Game] = [Game]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLevelView()
        subscribeForNotification(name: .endGame, selector: #selector(dismissGame), object: nil)
        
        GameManagement.sharedInstance.setCopyCardsList()
        chosenGames = GameManagement.sharedInstance.chosenGames
        
        let press = UITapGestureRecognizer(target: self, action: #selector(startGameAction))
        self.view.addGestureRecognizer(press)
        
        scoreContainerView.layer.cornerRadius = 10
        scoreContainerView.layer.masksToBounds = true
        
        gameContainerView.layer.cornerRadius = 10
        gameContainerView.layer.masksToBounds = true
        
        inofContainerView.layer.cornerRadius = 10
        inofContainerView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func startGameAction() {
        if GameManagement.sharedInstance.leveLGameDict.count != 0 {
            print("Tap want to work")
        } else {
            showView()
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
        if let game = chosenGames[indexOfGame].gameMode?.gameView() {
            game.frame = self.view.bounds
            game.levelCounter = "\(levelCounter) / \(gameInLevel)"
            game.gameInLevel = gameInLevel
            game.gameInLevel = levelCounter
            postNotification(name: .addCounterValue)
            GameManagement.sharedInstance.leveLGameDict.append(chosenGames[indexOfGame])
            
            self.view.insertSubview(game, at: 1)
        
            print("Game index : \(indexOfGame)")
            print("Level Counter: \(levelCounter)")
            
            if gameInLevel == levelCounter {
                levelCounter = levelCounter + 1
                gameInLevel = 1
                updateLevelView()

            } else {
                gameInLevel = gameInLevel + 1
                showView()
            }
        }
    }
    
    
    func updateLevelView() {
        self.levelLabel.text = "Level : \(levelCounter)"
        self.levelImageView.image = UIImage(named: "level\(levelCounter)") ?? UIImage(named: "level12")
        self.view.insertSubview(levelImageView, at: 1)
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
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func scoreAction(_ sender: Any) {
        showScoreView()
    }
    
    
    @IBAction func endGameAction(_ sender: Any) {
        showEndGameView()
    }
    
    @IBAction func showInfoDesc(_ sender: Any) {
        var gameDescription = GameManagement.sharedInstance.leveLGameDict.first?.description
        showInfoView(description: gameDescription ?? "Itt még nem látsz játékot igy nincs is hozzá leírás")
    }
 }
 
 
 
 
 
 
