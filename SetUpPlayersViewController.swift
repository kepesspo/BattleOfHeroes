//
//  SetUpPlayersViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/6/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import FirebaseDatabase
import Firebase
import Reachability
import Panels
import Lottie
import MDCCommon

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
        
        subscribeForNotification(name: .updatePlayerList, selector: #selector(reloadCollectionView))
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
            Factory.shared.dataManager.deleteRoom(room: Factory.shared.roomID, competionBlock: { (error) in
                if error == nil {
                    Factory.shared.playerList = [Player]()
                    
                    self.dismiss(animated: false, completion: nil)
                } else {
                    print("Delete room not works")
                }
            })
            
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
        panelConfiguration.enclosedNavigationBar = true
        panelConfiguration.animateEntry = false
        panelConfiguration.panelVisibleArea = 90
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
        self.playerList = Factory.shared.playerList
        Factory.shared.dataManager.getPlayerList { (error) in
            if error == nil {
                self.playerList = Factory.shared.playerList
                self.playerCollectionView.reloadData()
                postNotification(name: .updateStartButton)
            } else {
                print("Error update collectionView")
            }
        }
    }
    
    func getPlayerData(completionBlock: @escaping(_ error : Error?) -> Void) {
        self.playerList = Factory.shared.playerList
        Factory.shared.dataManager.getPlayerList { (error) in
            if error != nil {
                print("Error")
            } else {
                self.playerList = Factory.shared.playerList
                self.playerCollectionView.reloadData()
                postNotification(name: .updateStartButton)
                completionBlock(nil)
            }
        }
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
                var color : UIColor? = UIColor(hexString: "#FFFFFF")
                customCell.color = color!
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
        return 6.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: playerCollectionView.bounds.width / 3 - 6, height: playerCollectionView.bounds.height / 3 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
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
