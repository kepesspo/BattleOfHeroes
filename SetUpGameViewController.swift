//
//  SetUpGameViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
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
        var panelConfiguration = PanelConfiguration(size: .custom(450))
        panelConfiguration.animateEntry = false
        panelConfiguration.panelVisibleArea = 90
        panelManager.delegate = panel as? PanelNotifications
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
            let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            self.navigationController?.pushViewController(gameVc, animated: true)
    }
    
    func removeGame(item : String) {
        var games = GameManagement.sharedInstance.chosenGames
        let index = games.firstIndex(where: { $0.name == item })
        if let gameIndex = index {
            games.remove(at: gameIndex)
        }
        GameManagement.sharedInstance.chosenGames = games
//        gameCollectionView.reloadData()
    }
    
    func addGame(item: Game) {
        GameManagement.sharedInstance.chosenGames.append(item)
//        gameCollectionView.reloadData()
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell else { return }
        let row = indexPath.row
        if games[indexPath.row].downloadsData == true && !GameManagement.sharedInstance.networkWorks {
            print("Network Don't Working")
            cell.pulseWifiIcon()  
        }
        games[row].isSelected ? removeGame(item: games[row].name) : addGame(item: games[row])
        games[row].isSelected.toggle()
       cell.blurView.isHidden = games[row].isSelected
    }
}

extension SetUpGameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gameCollectionView.bounds.width / 1 - 6, height: gameCollectionView.bounds.height / 5 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}


extension SetUpGameViewController: CustomCellInfoDelegate {
    func sharePressed(game: Game) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameManagementViewController") as! GameManagementViewController
        vc.game = game
        self.present(vc, animated: true, completion: nil)
    }
}
