//
//  SetUpGameViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import SpotifyLogin
import Panels

class SetUpGameViewController: UIViewController {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    var games = GameManagement.sharedInstance.games
    var chosenGames : [Game] = [Game]()
    lazy var panelManager = Panels(target: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPanel()
        
        GameManagement.sharedInstance.isSpactate = false
        gameCollectionView.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameCollectionViewCell")
        gameCollectionView.showsVerticalScrollIndicator  = false
        subscribeForNotification(name: .gameNext, selector: #selector(showNextView))
    }
    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelGames")
        var panelConfiguration = PanelConfiguration(size: .custom(350))
        panelConfiguration.animateEntry = false
        panelConfiguration.panelVisibleArea = 100
        self.panelManager.show(panel: panel, config: panelConfiguration)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        NetworkSevice.sharedInstance.gameRunning(isRun: false) { (error) in
            if error == nil {
                print("Lock Screen for other player")
            } else {
                print("Error Lock Screen for other player ")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showNextView() {
        if GameManagement.sharedInstance.showExtraSetUp == false {
            let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExtraSetUpViewController") as! ExtraSetUpViewController
            self.navigationController?.pushViewController(gameVc, animated: true)
        } else {
            let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            self.present(gameVc, animated: true, completion: nil)
        }
       
    }
    
    func removeGame(item : String) {
        GameManagement.sharedInstance.chosenGames = chosenGames.filter {$0.name != item }
    }
    
    func addGame(item: Game) {
        GameManagement.sharedInstance.chosenGames.append(item)
    }
}

extension SetUpGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        cell.delegate = self as CustomCellInfoDelegate
        cell.gameData = games[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if games[indexPath.row].isSelected == true {
            games[indexPath.row].isSelected = false
            removeGame(item: games[indexPath.row].name)
        } else {
            games[indexPath.row].isSelected = true
            addGame(item: games[indexPath.row])
        }
        gameCollectionView.reloadData()
    }
}

extension SetUpGameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gameCollectionView.bounds.width / 3 - 4, height: gameCollectionView.bounds.height / 3 - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
}


extension SetUpGameViewController: CustomCellInfoDelegate {
    func sharePressed(game: Game) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameManagementViewController") as! GameManagementViewController
        vc.game = game
        self.present(vc, animated: true, completion: nil)
    }
}
