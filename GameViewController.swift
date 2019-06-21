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
    var getPlyarerWhoGetDrinks: Timer?
    var randomPictogramTimer : Timer?
    var chosenGames : [Game] = [Game]()
    var timer : Timer?
    
    lazy var panelManager = Panels(target: self)
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var letPlayText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        GameManagement.sharedInstance.isSpactate = false
        
        
        subscribeForNotification(name: .reloadGroupDrinkTimer, selector: #selector(showGroupDrinkView), object: nil)
        subscribeForNotification(name: .randomPictogram, selector: #selector(showRandomPictogram), object: nil)
        subscribeForNotification(name: .generateNewGame, selector: #selector(startGameAction), object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(startGameAction))
        levelImageView.isUserInteractionEnabled = true
        levelImageView.addGestureRecognizer(tap)
        
        GameManagement.sharedInstance.setCopyCardsList()
        chosenGames = GameManagement.sharedInstance.chosenGames
        
        showPanel()
        showPlayerWhoDrinks()
        showGroupDrinkView()
        showRandomPictogram()
        
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(showSpectatorBonus), userInfo: nil, repeats: true)
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

    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelMaterial")
        var panelConfiguration = PanelConfiguration(size: .custom(300))
        panelConfiguration.enclosedNavigationBar = true
        panelConfiguration.useSafeArea = true
        panelConfiguration.animateEntry = true
        panelConfiguration.panelVisibleArea = 90
        panelManager.delegate = panel as? PanelNotifications
        self.panelManager.show(panel: panel, config: panelConfiguration)
    }
    
    @objc func showSpectatorBonus() {
        NetworkSevice.sharedInstance.getPlayerHowGetDrinksForSpectator { (error, playerName) in
            if error == nil && playerName != "" {
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpectatePenaltyViewController") as! SpectatePenaltyViewController
                vc.name = playerName
                self.present(vc, animated: true, completion: nil)
            } else {
                print("No spectator bonus player name")
            }
        }
        
    }

    @objc func startGameAction() {
        letPlayText.isHidden = true
        showView()
    }
    
    func showPlayerWhoDrinks() {
        NetworkSevice.sharedInstance.playerHowGetDrinks(isShow: false) { (error) in
            if error == nil {
                self.getPlyarerWhoGetDrinks = Timer.scheduledTimer(withTimeInterval: TimeInterval(10), repeats: false, block: { _ in
                    NetworkSevice.sharedInstance.playerHowGetDrinks(isShow: true, completionBlock: { (error) in
                        if error == nil {
                            print("Mark")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                self.showPlayerWhoDrinks()
                            }
                        } else {
                            print("Error to show Mark")
                        }
                        
                    })
                })
                print("Add triggerd player how get drinks")
            } else {
                print("error")
            }
        }
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
            GameManagement.sharedInstance.actuallyGame = chosenGames[indexOfGame]
            print("------- Actually Game:  \(chosenGames[indexOfGame].name) ----------")
            GameManagement.sharedInstance.actuallyGameDesc = chosenGames[indexOfGame].gameMode?.gameDescription() ?? ""
            game.frame = self.view.bounds
            self.view.insertSubview(game, at: 1)
            print("Game index : \(indexOfGame)")
        }
    }
 }
