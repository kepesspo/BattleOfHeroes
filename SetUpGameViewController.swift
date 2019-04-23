//
//  SetUpGameViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import SpotifyLogin

class SetUpGameViewController: UIViewController {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var sectionHeader: GameSectionHeaderCollectionReusableView!
    
    var games = GameManagement.sharedInstance.games
    var groupGames : [Game] = [Game]()
    var personalGames : [Game] = [Game]()
    var LineGames : [Game] = [Game]()
    var BattleGames : [Game] = [Game]()
    
    var chosenGames : [Game] = [Game]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGame()
        GameManagement.sharedInstance.isSpactate = false
        gameCollectionView.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameCollectionViewCell")
        gameCollectionView.showsVerticalScrollIndicator  = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SpotifyLogin.shared.getAccessToken { [weak self] (token, error) in
            print("Spotify Token: \(token ?? "")")
            if(token != nil) {
                GameManagement.sharedInstance.spotifyToken = token
                
            } else {
                SpotifyLogin.shared.logout()
            }
        }
        
        if GameManagement.sharedInstance.firstRun() == false {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameInfoViewController") as! GameInfoViewController

            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NetworkSevice.sharedInstance.gameRunning(isRun: false) { (error) in
            if error == nil {
                print("Lock Screen for other player")
            } else {
                print("Error Lock Screen for other player ")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        doneTapped()
        
    }
    
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameInfoViewController") as! GameInfoViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func doneTapped() {
        if chosenGames.count == 0 {
            GameManagement.sharedInstance.chosenGames = GameManagement.sharedInstance.games
            self.showLoaderView()
            loadAllGameData { [weak self] in
                self?.dissmissLoaderView()
            }
        } else {
            GameManagement.sharedInstance.chosenGames = chosenGames
            self.showLoaderView()
            loadAllGameData { [weak self] in
                self?.dissmissLoaderView()
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
            returnedBlock(nil)
            
        }
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
            topController.dismiss(animated: true, completion: nil) 
        }
    }
    
    
    func addGame() {
        groupGames = games.filter { $0.gameType!.rawValue == "GameType_GroupGame".localized() }
        LineGames = games.filter { $0.gameType!.rawValue == "GameType_LineGame".localized() }
        personalGames = games.filter { $0.gameType!.rawValue == "GameType_PersonalGame".localized() }
        BattleGames = games.filter { $0.gameType!.rawValue == "GameType_BattleGame".localized()}
    }
    
    func removeGame(item : String) {
        chosenGames = chosenGames.filter {$0.name != item }
    }
    
    func checkSpotifyTokenGame(game : Game) -> Bool {
        var isSelectableMusicRecGame = false
        print("Set music recognizer")
        if GameManagement.sharedInstance.spotifyToken == nil {
            isSelectableMusicRecGame = false
            let alert = UIAlertController(title: "Warning", message: "Ehhez a jatékhoz spotify hozzáférés kell jelentkez be ha szeretnél játszani. ", preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
            alert.addAction(cancelAction)
            alert.addAction(UIAlertAction(title: "Spotify Login", style: .default, handler: { (action) in
                SpotifyLoginPresenter.login(from: self, scopes:
                    [.streaming,
                     .userReadTop,
                     .playlistReadPrivate,
                     .userLibraryRead])
            }))
            
            if let topController = UIApplication.topViewController() {
                topController.present(alert, animated: true)
                
            }
        } else {
            isSelectableMusicRecGame = true
        }
        return isSelectableMusicRecGame
    }
    
}

extension SetUpGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return personalGames.count
        } else if section == 1 {
            return groupGames.count
        } else if section == 2 {
            return LineGames.count
        } else {
            return BattleGames.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GameType.allValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GameSectionHeaderCollectionReusableView", for: indexPath) as? GameSectionHeaderCollectionReusableView
        
        sectionHeaderView?.typeTitle = GameType.allValues[indexPath.section].rawValue
        return sectionHeaderView!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        cell.delegate = self as CustomCellInfoDelegate
        if indexPath.section == 0 {
            cell.gameData = personalGames[indexPath.row]
        } else if indexPath.section == 1 {
            cell.gameData = groupGames[indexPath.row]
        } else if indexPath.section == 2 {
            cell.gameData = LineGames[indexPath.row]
        } else {
            cell.gameData = BattleGames[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if personalGames[indexPath.row].name == "Zene Felismerés" {
                let isSelected = checkSpotifyTokenGame(game: personalGames[indexPath.row])
                
                if isSelected == false {
                    personalGames[indexPath.row].isSelected = false
                    removeGame(item: personalGames[indexPath.row].name)
                } else if isSelected == true && personalGames[indexPath.row].isSelected == false {
                    personalGames[indexPath.row].isSelected = true
                    chosenGames.append(personalGames[indexPath.row])
                } else {
                    personalGames[indexPath.row].isSelected = false
                    removeGame(item: personalGames[indexPath.row].name)
                }
            } else {
                if personalGames[indexPath.row].isSelected == true {
                    personalGames[indexPath.row].isSelected = false
                    removeGame(item: personalGames[indexPath.row].name)
                } else {
                    personalGames[indexPath.row].isSelected = true
                    chosenGames.append(personalGames[indexPath.row])
                }
            }
            
            
        case 1:
            if groupGames[indexPath.row].isSelected == true {
                groupGames[indexPath.row].isSelected = false
                removeGame(item: groupGames[indexPath.row].name)
            } else {
                groupGames[indexPath.row].isSelected = true
                chosenGames.append(groupGames[indexPath.row])
            }
        case 2:
            if LineGames[indexPath.row].isSelected == true {
                LineGames[indexPath.row].isSelected = false
                removeGame(item: LineGames[indexPath.row].name)
            } else {
                LineGames[indexPath.row].isSelected = true
                chosenGames.append(LineGames[indexPath.row])
            }
            
        case 3:
            if BattleGames[indexPath.row].isSelected == true {
                BattleGames[indexPath.row].isSelected = false
                removeGame(item: BattleGames[indexPath.row].name)
            } else {
                BattleGames[indexPath.row].isSelected = true
                chosenGames.append(BattleGames[indexPath.row])
            }
        default:
            print("Def")
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
        return CGSize(width: gameCollectionView.bounds.width / 3 - 4, height: gameCollectionView.bounds.width / 3 + 50)
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
