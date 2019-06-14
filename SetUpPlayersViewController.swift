//
//  SetUpPlayersViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/6/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import Reachability
import Panels
import Lottie

class SetUpPlayersViewController: UIViewController {
    @IBOutlet weak var playerNavigationItem: UINavigationItem!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var playerCollectionView: UICollectionView!
    @IBOutlet weak var closeRoom: UIButton!
    
    var playerList = [Player]()
    var gameMode = GameManagement.sharedInstance.selectedMode
    lazy var panelManager = Panels(target: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerCollectionView.register(UINib.init(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
         playerCollectionView.register(UINib.init(nibName: "AddPlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlayerCollectionViewCell")
        
        subscribeForNotification(name: .updatePlayerCollectionView, selector: #selector(reloadCollectionView))
        subscribeForNotification(name: .gameModeChanged, selector: #selector(gameModeChanged), object: nil)
        showPanel()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        getPlayerData(completionBlock: { (error) in
            if error != nil {
                print("hiba")
            } else {
                GameManagement.sharedInstance.getGames()
                self.checkGameParam()
            }
        })
        
        panelManager.collapsePanel()
        self.checkGameRunning()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    @IBAction func closeRoomAction(_ sender: Any) {
        let closeAlert = UIAlertController(title: "Kilépés!", message: "Biztos hogy kilépsz a szobából? Ha kilépsz már nem tudsz visszalépni.", preferredStyle: UIAlertController.Style.alert)
        
        closeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.dismiss(animated: false, completion: nil)
        }))
        
        closeAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(closeAlert, animated: true, completion: nil)
    }
    
    
    func checkGameRunning() {
        NetworkSevice.sharedInstance.getGameRunning(completionBlock: { (error, run) in
            if run == 1 {
                self.playerCollectionView.isUserInteractionEnabled = false
                postNotification(name: .updateGameIsSpectate)
            } else {
                self.playerCollectionView.isUserInteractionEnabled = true
                postNotification(name: .updateGameIsAll)
            }
        })
    }
    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelMenu")
        var panelConfiguration = PanelConfiguration(size: .custom(250))
        panelConfiguration.animateEntry = false
        panelConfiguration.panelVisibleArea = 100
        panelManager.delegate = panel as? PanelNotifications
        self.panelManager.show(panel: panel, config: panelConfiguration)
    }
    
    @objc func gameModeChanged() {
        print("Mode Changed")
       
        panelManager.collapsePanel()
        switch GameManagement.sharedInstance.selectedMode {
        case 0:
            print("Game Mode")
            GameManagement.sharedInstance.selectedMode = 0
            self.playerCollectionView.reloadData()
            self.playerCollectionView.allowsSelection = false
        default:
            print("Default")
        }
    }
    
    @objc func reloadCollectionView() {
        NetworkSevice.sharedInstance.getPlayerList { (error) in
            if error == nil {
                self.playerList = NetworkSevice.sharedInstance.playerList
                self.playerCollectionView.reloadData()
            } else {
                print("Error update collectionView")
            }
        }
        
    }
    
    func getPlayerData(completionBlock: @escaping(_ error : Error?) -> Void) {
        self.playerList = NetworkSevice.sharedInstance.playerList
        NetworkSevice.sharedInstance.getPlayerList(completionBlock: { (error) in
            if error != nil {
                print("Error")
            } else {
                self.playerList = NetworkSevice.sharedInstance.playerList
                self.playerCollectionView.reloadData()
                completionBlock(nil)
            }
        })
    }

    
    func checkGameParam() {
        if playerList.count <=  1 {
            //self.setupGameBtn.isEnabled = false
            
        } else {
            //self.setupGameBtn.isEnabled = true
            
        }
        
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

extension SetUpPlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerList.count + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == playerList.count {
            if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPlayerCollectionViewCell.identifier, for: indexPath) as? AddPlayerCollectionViewCell {
                return customCell
            }
        } else {
            if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.identifier, for: indexPath) as? PlayerCollectionViewCell {
                customCell.player = playerList[indexPath.row]
                return customCell
            }
        }
        return UICollectionViewCell()
    }
    
}

extension SetUpPlayersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: playerCollectionView.bounds.width / 3 - 4, height: playerCollectionView.bounds.height / 3 - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.uppercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
