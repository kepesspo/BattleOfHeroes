 //
 //  GameViewController.swift
 //  BattleOfHeroes
 //
 //  Created by Mark on 8/1/18.
 //  Copyright © 2018 Mark. All rights reserved.
 //
 
 import UIKit
 import MDCCommon
 import Panels
 import SpotifyLogin
 import Lottie
 
 class GameViewController: UIViewController {
    var gameCounter : Int = 0
    var previousGame: Game?
    var groupDrinkTimer : Timer?
    var getPlyarerWhoGetDrinks: Timer?
    var randomPictogramTimer : Timer?
    var timer : Timer?
    lazy var panelManager = Panels(target: self)
    
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var gameContainerView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var letPlayText: UILabel!
    @IBOutlet weak var backgroundAnimationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameManagement.sharedInstance.isSpactate = false
        
        subscribeForNotification(name: .reloadGroupDrinkTimer, selector: #selector(showGroupDrinkView), object: nil)
        subscribeForNotification(name: .randomPictogram, selector: #selector(showRandomPictogram), object: nil)
        subscribeForNotification(name: .generateNewGame, selector: #selector(startGameAction), object: nil)
        subscribeForNotification(name: .activateGame, selector: #selector(activateGame), object: nil)
        
        GameManagement.sharedInstance.setCopyCardsList()
        //backgroundAnimationView.layer.cornerRadius = 20
        backgroundAnimationView.clipsToBounds = true
        showPanel()
        showPlayerWhoDrinks()
        showGroupDrinkView()
        showRandomPictogram()
        backgroundAnimationView.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(showSpectatorBonus), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GameManagement.sharedInstance.gameStarted = true
        view.addTapGestureRecognizer(numberOfTapsRequired: 1, numberOfTouchesRequired: 5, delegate: nil) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
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

        timer?.invalidate()
        groupDrinkTimer?.invalidate()
        getPlyarerWhoGetDrinks?.invalidate()
        randomPictogramTimer?.invalidate()
    }
    
    @objc func activateGame() {
        startButton.isHidden = false
        startImageView.isHidden = false
        letPlayText.isHidden = false
    }
    
    func playAnimation() {
        backgroundAnimationView.loopAnimation = true
        backgroundAnimationView.animationSpeed = 1.6
        backgroundAnimationView.play()
        
    }
    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelMaterial")
        var panelConfiguration = PanelConfiguration(size: .custom(360))
        panelConfiguration.enclosedNavigationBar = true
        panelConfiguration.useSafeArea = true
        panelConfiguration.animateEntry = true
        panelConfiguration.panelVisibleArea = 90
        panelManager.delegate = panel as? PanelNotifications
        self.panelManager.show(panel: panel, config: panelConfiguration)
    }
    
    @objc func showSpectatorBonus() {
        if Factory.shared.isOnline {
            NetworkSevice.sharedInstance.getPlayerHowGetDrinksForSpectator { (error, playerName) in
                if error == nil && playerName != "" {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpectatePenaltyViewController") as! SpectatePenaltyViewController
                    vc.name = playerName
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print("No spectator bonus player name")
                }
            }
        } else {
            print("showSpectatorBonus not worked because it's a Offline game")
        }
    }
    
    @objc func startGameAction() {
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
    
    @IBAction func gameAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.playInfo) == false {
            letPlayText.isHidden = true
            startButton.isHidden = true
            startImageView.isHidden = true
            
            let infoView = PlayInfoView()
            infoView.frame = self.view.bounds
            infoView.clipsToBounds = true
            self.view.insertSubview(infoView, at: 0)
        } else {
            letPlayText.isHidden = true
            startButton.isHidden = true
            startImageView.isHidden = true
            showView()
        }
        
    }
    
    //Extra Game
    @objc func showGroupDrinkView() {
        let time = Factory.shared.groupDrinkTime
        if Factory.shared.groupDrinksAllow == true {
            self.groupDrinkTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time) , repeats: true, block: { _ in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GroupDrinkViewController") as! GroupDrinkViewController
                self.present(vc, animated: true, completion: nil)
                self.groupDrinkTimer?.invalidate()
                
            })
        }
    }
    
    @objc func showRandomPictogram() {
        let time = Factory.shared.randomPictogramTime
        if Factory.shared.randomPictogramAllow == true {
            self.randomPictogramTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time) , repeats: true, block: { _ in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RandomPictogramViewController") as! RandomPictogramViewController
                self.present(vc, animated: true, completion: nil)
                self.randomPictogramTimer?.invalidate()
                
            })
        }
    }
    
    func showView() {
        backgroundAnimationView.isHidden = false
        playAnimation()
        gameContainerView.isUserInteractionEnabled = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let downloadGroup = DispatchGroup()
            var availableGames = GameManagement.sharedInstance.chosenGames
            
            if !GameManagement.sharedInstance.gameDataLoaded {
                downloadGroup.enter()
                GameSetup.sharedInstance.loadAllGameData { error in
                    if error != nil {
                        availableGames = availableGames.filter({ !$0.downloadsData })
                    }
                    downloadGroup.leave()
                }
            }

            downloadGroup.wait()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if availableGames.count > 1, let previous = self.previousGame {
                    availableGames = availableGames.filter({ $0.name != previous.name})
                }
                let chosen = availableGames.randomElement()!
                self.generateViewWith(game: chosen)
                self.previousGame = chosen
            }
        }
    }
    
    
    func generateViewWith(game : Game) {
        if let gameView = game.gameMode?.gameView() {
            Factory.shared.actualGame = game
            //GameManagement.sharedInstance.actuallyGame = game
            print("------- Actual Game:  \(game.name) ----------")
            Factory.shared.actualGame?.description = game.gameMode?.gameDescription() ?? ""
            gameView.frame = self.view.bounds
            //gameView.layer.cornerRadius = 20
            gameView.clipsToBounds = true
            
            gameContainerView.insertSubview(gameView, at: 0)
            
            if gameContainerView.subviews.count > 1 {
                UIView.transition(from: gameContainerView.subviews[1],
                                  to: gameContainerView.subviews[0],
                                  duration: 0.6, options: .transitionCrossDissolve) { _ in
                                    self.gameContainerView.subviews.forEach {
                                        if $0 != gameView {
                                            $0.removeFromSuperview()
                                        }
                                    }
                }
            }
        }
    }
 }
