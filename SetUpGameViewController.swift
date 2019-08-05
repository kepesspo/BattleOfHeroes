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
    @IBOutlet weak var infoButton: UIButton!
    
    var games = GameManagement.sharedInstance.games
    var chosenGames : [Game] = [Game]()
    lazy var panelManager = Panels(target: self)
    
    var maskLayer: CALayer?
    var secondMaskLayer: CALayer?
    var thirdMaskLayer: CALayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        showPanel()
        
        GameManagement.sharedInstance.isSpactate = false
        gameCollectionView.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameCollectionViewCell")
        gameCollectionView.showsVerticalScrollIndicator  = false
        subscribeForNotification(name: .gameNext, selector: #selector(showNextView))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.firstRunClosed) == false {
            showInfoView()
        } else {
            print("Not first run")
        }
    }
    
    func showInfoView() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameInfoViewController") as! GameInfoViewController
        popOverVC.modalPresentationStyle = .overFullScreen

        // guard
        guard let firstMask = maskLayer else { return }
        guard let secondMask = secondMaskLayer else { return }
        guard let thirdMask = thirdMaskLayer else { return }
        popOverVC.masks = [
            (firstMask.convert(firstMask.bounds, to: view.layer), firstMask.cornerRadius),
            (secondMask.convert(secondMask.bounds, to: view.layer), secondMask.cornerRadius),
            (thirdMask.convert(thirdMask.bounds, to: view.layer), 30)
            
        ]
        
        if let topController = UIApplication.topViewController() {
            topController.present(popOverVC, animated: true, completion: nil)
        }
    }
    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelGames")
        var panelConfiguration = PanelConfiguration(size: .thirdQuarter)
        panelConfiguration.animateEntry = false
        panelConfiguration.panelVisibleArea = 90
        panelConfiguration.closeOutsideTap = true
        panelManager.delegate = panel as? PanelNotifications
        self.panelManager.show(panel: panel, config: panelConfiguration)
        thirdMaskLayer = panel.view.layer
    }
    
    @IBAction func infoAction(_ sender: Any) {
        let indexPath = IndexPath(item: 1, section: 0)
        
        UIView.animate(withDuration: 0, animations: {
            self.gameCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }) { _ in
            self.showInfoView()
        }
        
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
        UIImpactFeedbackGenerator().impactOccurred()
//        gameCollectionView.reloadData()
    }
    
    func addGame(item: Game) {
        GameManagement.sharedInstance.chosenGames.append(item)
        UIImpactFeedbackGenerator().impactOccurred()
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
        if indexPath.row == 1 {
            maskLayer = cell.layer
        }
        if indexPath.row == 2 {
            secondMaskLayer = cell.layer
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell else { return }
        let row = indexPath.row
        
        games[row].isSelected ? removeGame(item: games[row].name) : addGame(item: games[row])
        games[row].isSelected.toggle()
        cell.blurView.isHidden = games[row].isSelected
        cell.selecte = games[row].isSelected
        
        if games[indexPath.row].downloadsData == true && !GameManagement.sharedInstance.networkAvailable {
            print("Network Don't Working")
            cell.pulseWifiIcon()
        }
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//    }
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
        return CGSize(width: gameCollectionView.bounds.width / 2 - 6, height: gameCollectionView.bounds.height / 5 - 10)
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
