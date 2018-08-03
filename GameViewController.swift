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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameAction(_ sender: Any) {
        showView()
    }
    
    
    func showView() {
        
        let games = [
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame),
            WheelOfFortuneView.init(frame: self.view.frame)]
        
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(games.count)))
        
//        let currentView = games[randomIndex]
//        currentView.gameInLevelLabel.text = "\(levelCounter) / \(gameInLevel)"
        
        self.view.addSubview(games[randomIndex])
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
        case levelCounter ..< gameLevels.five.rawValue:
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






