//
//  PanelMenu.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/12/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import Panels

class PanelMenu: UIViewController, UIScrollViewDelegate, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var gameDetailsBtn: UIButton!
    
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var customBtn: UIButton!
    @IBOutlet weak var battleBtn: UIButton!
    @IBOutlet weak var spectatorBtn: UIButton!
    @IBOutlet weak var closeRoomBtn: UIButton!
    
    var roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName)
    var roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlurBackgroundToMenu()
        curveTopCornersToMenuView()
        self.view.layoutIfNeeded()
        
        subscribeForNotification(name: .updateGameIsSpectate, selector: #selector(updatePanelToInactive))
        subscribeForNotification(name: .updateGameIsAll, selector: #selector(updatePanelToActive))
        subscribeForNotification(name: .updateStartButton, selector: #selector(updateStartButton))
        
        NetworkSevice.sharedInstance.getGameRunning { (error, value) in
            if value == 1 {
                self.nextButton.layer.cornerRadius = 10
                GameManagement.sharedInstance.selectedSpac = 4
                GameManagement.sharedInstance.isSpactate = true
                self.triggeredGameMode()
            } else {
                self.nextButton.layer.cornerRadius = 10
                GameManagement.sharedInstance.selectedSpac = 0
                GameManagement.sharedInstance.isSpactate = false
                 self.triggeredGameMode()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func updatePanelToInactive() {
        normalBtn.isEnabled = false
        customBtn.isEnabled = false
        battleBtn.isEnabled = false
    }
    
    @objc func updatePanelToActive() {
        normalBtn.isEnabled = true
        customBtn.isEnabled = true
        battleBtn.isEnabled = true
    }
    
    @objc func updateStartButton() {
        if NetworkSevice.sharedInstance.playerList.count == 0 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }

    func triggeredGameMode() {
        if GameManagement.sharedInstance.selectedSpac == 4 {
            nextButton.setTitle("Adatok Mutatása", for: .normal)
            titleText.text = "Megfigyelő"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            GameManagement.sharedInstance.selectedMode = 4
        } else {
            nextButton.setTitle("Mehet", for: .normal)
            titleText.text = "Egyszerű"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
          //GameManagement.sharedInstance.selectedMode = 0
        }
    }
    
    @IBAction func gameButtonAction(_ sender: Any) {
        switch GameManagement.sharedInstance.selectedMode {
        case 0:
            NetworkSevice.sharedInstance.getPlayerList { (error) in
                if error == nil {
                    print("No error")
                } else {
                    print("Error")
                }
            }
            GameManagement.sharedInstance.chosenGames = GameManagement.sharedInstance.getGames()
            showLoaderView()
            loadAllGameData { [weak self] in
                self?.dissmissLoaderView()
            }
        case 1:
            NetworkSevice.sharedInstance.getPlayerList { (error) in
                if error == nil {
                    print("No error")
                } else {
                    print("Error")
                }
            }
            let setUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUpGameViewController") as! SetUpGameViewController
            self.navigationController?.pushViewController(setUpVc, animated: true)
        case 2:
            if GameManagement.sharedInstance.battlePlayer.count < 2 {
                let alert = UIAlertController(title: "Hiba", message: "Válasz ki két játékost aki csatázik egymással", preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
            } else {
                GameManagement.sharedInstance.battleGameRun = true
                let battleGames = GameManagement.sharedInstance.getBattleGames()
                GameManagement.sharedInstance.chosenGames = battleGames
                NetworkSevice.sharedInstance.playerList = GameManagement.sharedInstance.battlePlayer
                
                self.showLoaderView()
                self.loadAllGameData { [weak self] in
                    self?.dissmissLoaderView()
                }
                
            }
        case 3:
            print("Prev Game")
        case 4:
            let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            scorePopVC.modalPresentationStyle = .overFullScreen
            self.present(scorePopVC, animated: true, completion: nil)
        default:
            print("Def switch")
        }
        
        if GameManagement.sharedInstance.selectedMode == 4 {
            print("No game Start")
        } else {
            if GameManagement.sharedInstance.selectedMode == 2 && GameManagement.sharedInstance.battlePlayer.count > 2  {
                updateGameRun(value: true)
            }  else if GameManagement.sharedInstance.selectedMode == 0 ||
                GameManagement.sharedInstance.selectedMode == 1 ||
                GameManagement.sharedInstance.selectedMode == 3 {
                updateGameRun(value: true)
                
            } else {
                print("No Battle Player")
            }
        }
    }

    func updateGameRun(value: Bool) {
        NetworkSevice.sharedInstance.gameRunning(isRun: true) { (error) in
            if error == nil {
                print("Lock Screen for other player")
            } else {
                print("Error Lock Screen for other player ")
            }
        }
    }
    
    
    func loadAllGameData(completion: (() -> Void)?) {
        var remainingCompletions = 0
        var errors = ""
        
        for game in GameManagement.sharedInstance.chosenGames {
            if game.downloadsData {
                remainingCompletions += 1
            }
        }
        
        let returnedBlock: ((_ error: Error?) -> Void) = { error in
            errors.append("\(error?.localizedDescription ?? "")\n")
            if remainingCompletions == 0 {
                completion?()
            } else {
                remainingCompletions -= 1
            }
            
        }
        
        for game in GameManagement.sharedInstance.chosenGames {
            switch game.name {
            case "Ki Vagyok Én":
                NetworkSevice.sharedInstance.getFamousPersons { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. famous person sikeresen letöltödőt.")
                    }
                }
            case "Igaz Hamis":
                NetworkSevice.sharedInstance.getTrueOrFalse { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Igaz Hamis kérdések sikeresen letöltödőt.")
                    }
                }
            case "Én még soha":
                NetworkSevice.sharedInstance.getHaveIEverNever { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Én még soha kérdések sikeresen letöltödőt.")
                    }
                }
            case "Zene Felismerés":
                
                NetworkSevice.sharedInstance.getSongs { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Minden zene sikeresen letöltödőt.")
                    }
                }
            case "Anagramma":
                NetworkSevice.sharedInstance.getAnagrammaWord { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Minden Anagramma sikeresen letöltödőt.")
                    }
                }
            default:
                print("Nem kell letölteni semit.")
                
            }
        }
        returnedBlock(nil)
    }
    
    func showLoaderView() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoaderViewController") as! LoaderViewController
        popOverVC.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.topViewController() {
            topController.present(popOverVC, animated: true, completion: nil)
            
        }
    }
    
    func dissmissLoaderView() {
        if let topController = UIApplication.topViewController() {
            topController.dismiss(animated: true, completion: {
                if GameManagement.sharedInstance.selectedMode == 0 {
                    self.startNormalGame()
                } else {
                    self.startBattleGame()
                }
                
            })
        }
        
    }
    
    
    @IBAction func normalGameAction(_ sender: Any) {
        print("Egyszerű")
        GameManagement.sharedInstance.selectedMode = 0
        nextButton.setTitle("Mehet", for: .normal)
        titleText.text = "Egyszerű"
        postNotification(name: .gameModeChanged)
    }
    
    @IBAction func customGameAction(_ sender: Any) {
        print("Összetett")
        GameManagement.sharedInstance.selectedMode = 1
        nextButton.setTitle("Beállitás", for: .normal)
        titleText.text = "Összetett"
        postNotification(name: .gameModeChanged)
    }
    
    @IBAction func battleGameAction(_ sender: Any) {
        print("Csata")
        GameManagement.sharedInstance.selectedMode = 2
        nextButton.setTitle("Mehet", for: .normal)
        titleText.text = "Csata"
        postNotification(name: .gameModeChanged)
    }
    @IBAction func spectatorGameAction(_ sender: Any) {
        print("Spactator")
        GameManagement.sharedInstance.selectedMode = 4
        nextButton.setTitle("Adatok Mutatása", for: .normal)
        titleText.text = "Megfigyelő"
        postNotification(name: .gameModeChanged)
    }
    
    @IBAction func closeRoomAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func gameDetailsAction(_ sender: Any) {
        let alert = UIAlertController(title: "Szoba Adatok", message: "Szoba név: \(roomName!)", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        let resetScore = UIAlertAction(title: "Reset Score", style: .destructive) { (alert) in
            NetworkSevice.sharedInstance.resetPlayerData(players: NetworkSevice.sharedInstance.playerList, competionBlock: { (error) in
                if error == nil {
                    print("Reseted Player Score")
                } else {
                    print(MyError.runtimeError("Reset Player Data in game manu alert view"))
                }
            })
        }
        alert.addAction(resetScore)
        alert.addAction(okBtn)
        if let topController = UIApplication.topViewController() {
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    func startBattleGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        GameManagement.sharedInstance.selectedMode = 2
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
    }
    
    func startNormalGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
    }
    
    
}

extension UIView {
    func addBlurBackgroundToMenu() {
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
    func curveTopCornersToMenuView() {
        let path = UIBezierPath(roundedRect: self.view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 30, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}
