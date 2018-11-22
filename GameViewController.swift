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
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelImageView: UIImageView!
    
    var chosenGames : [Game] = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLevelView()
        GameManagement.sharedInstance.setCopyCardsList()
        chosenGames = GameManagement.sharedInstance.chosenGames
        
        let press = UITapGestureRecognizer(target: self, action: #selector(startGameAction))
        self.view.addGestureRecognizer(press)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func startGameAction() {
//        self.levelImageView.image = nil
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
        showView()
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
}






