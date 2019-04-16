 //
 //  GameViewController.swift
 //  BattleOfHeroes
 //
 //  Created by Mark on 8/1/18.
 //  Copyright © 2018 Mark. All rights reserved.
 //
 
 import UIKit
 import Panels
 import SpotifyLogin
 
 class GameViewController: UIViewController {
    var gameCounter : Int = 0
    var previousRandomIndex = 100
    var groupDrinkTimer : Timer?
    var randomPictogramTimer : Timer?
    var chosenGames : [Game] = [Game]()
    lazy var panelManager = Panels(target: self)
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var letPlayText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelMaterial")
        var panelConfiguration = PanelConfiguration(size: .oneThird)
        panelConfiguration.animateEntry = true
        self.panelManager.show(panel: panel, config: panelConfiguration)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if GameManagement.sharedInstance.gameStarted == true {
            SpotifyLogin.shared.getAccessToken { [weak self] (token, error) in
                print("Spotify Token: \(token ?? "")")
                if(token != nil) {
                    GameManagement.sharedInstance.spotifyToken = token
                    postNotification(name: .spotiTokenUpdate)
                } else {
                    SpotifyLogin.shared.logout()
                }
            }
        } else {
            GameManagement.sharedInstance.gameStarted = true
        }
        
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
        if let game = chosenGames[indexOfGame].gameMode?.gameView() {
            GameManagement.sharedInstance.actuallyGameDesc = chosenGames[indexOfGame].gameMode?.gameDescription() ?? ""
            game.frame = self.view.bounds
            self.view.insertSubview(game, at: 1)
            print("Game index : \(indexOfGame)")
        }
    }
 }
