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
    
    @IBOutlet weak var startBtn: UIButton!
    
    var levelCounter : Int = 1
    var gameInLevel : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLevelView()
        GameManagement.sharedInstance.setCopyCardsList()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameAction(_ sender: Any) {
        if levelCounter == 1 && GameManagement.sharedInstance.randomColorSwitchIsON {
            let _ = RandomColorPresenter.sharedInstance
        }
        showView()
    }
    
    
    func showView() {
        let games = GameManagement.sharedInstance.getGames()
        for game in games {
            game.frame = self.view.frame
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(games.count)))
        
        if let game = games[randomIndex] as? GameView {
            game.levelCounter = "\(levelCounter) / \(gameInLevel)"
            game.gameInLevel = gameInLevel
            game.gameInLevel = levelCounter
            postNotification(name: .addCounterValue)
            self.view.insertSubview(game, at: 1)
            //self.view.addSubview(game)
        }
        
        print(index)
        print(levelCounter)
        
        
        
        
        if gameInLevel == levelCounter {
            levelCounter = levelCounter + 1
            gameInLevel = 1
            updateLevelView()
        } else {
            gameInLevel = gameInLevel + 1
            showView()
        }
    }
    
    
    func updateLevelView() {
        switch levelCounter {
            // Valami nem jó 
        case 0 ..< gameLevels.five.rawValue:
            self.view.backgroundColor = .orange
        case gameLevels.five.rawValue ..< gameLevels.ten.rawValue:
            self.view.backgroundColor = .green
        case gameLevels.ten.rawValue ..< gameLevels.fifty.rawValue:
            self.view.backgroundColor = .blue
        case gameLevels.fifty.rawValue ..< gameLevels.twenty.rawValue:
            self.view.backgroundColor = .red
        default:
            self.view.backgroundColor = .white
        }
        
        self.startBtn.setTitle("Level : \(levelCounter)", for: .normal)
        self.startBtn.setTitleColor(.white, for: .normal)
    }
}






