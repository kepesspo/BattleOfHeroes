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
import TTSegmentedControl

class SetUpPlayersViewController: UIViewController {
    

    @IBOutlet weak var setUpTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var setupGameBtn: UIButton!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var playerNavigationItem: UINavigationItem!
    @IBOutlet weak var roomIdentiferLabel: UILabel!
    @IBOutlet weak var roomPassLabel: UILabel!
    
    @IBOutlet weak var setUpGameView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var gameSegmentedControl: TTSegmentedControl!
    
    var refPlayer = fireBaseRefData.playerRef
    var playerList = [Player]()
    var teamList = [Team]()

    var roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName)
    var roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
    
    var gameMode = GameManagement.sharedInstance.selectedMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView.separatorStyle = .none
        self.setupGameBtn.isEnabled = false
        dataView.layer.cornerRadius = 5
        setUpTableView.layer.cornerRadius = 5
        
        gameSegmentedControl.layer.cornerRadius = 5
        gameSegmentedControl.allowChangeThumbWidth = false
        gameSegmentedControl.itemTitles = ["Egyszerű","Összetett","Csata"]
        gameSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                print("Egyszerű")
                self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setUpGameView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.headerView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setUpTableView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setupGameBtn.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setupGameBtn.setTitle("Játék Beállitása", for: .normal)
                GameManagement.sharedInstance.selectedMode = 0
                self.setUpTableView.reloadData()
                self.setUpTableView.allowsSelection = false
            case 1:
                print("Egyszerű")
                self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setUpGameView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.headerView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setUpTableView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setupGameBtn.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
                self.setupGameBtn.setTitle("Játék Beállitása", for: .normal)
                GameManagement.sharedInstance.selectedMode = 2
                self.setUpTableView.reloadData()
                self.setUpTableView.allowsSelection = false
            case 2:
                print("Csata")
                self.setUpGameView.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
                self.headerView.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
                self.view.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
                self.setUpTableView.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
                self.setupGameBtn.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
                self.setupGameBtn.setTitle("Csata Inditása", for: .normal)
                GameManagement.sharedInstance.selectedMode = 1
                self.reloadTableView()
                self.setUpTableView.allowsSelection = true
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
            
        }
        roomPassLabel.text = "Jelszó: \(roomPass ?? "")"
        roomIdentiferLabel.text = "Név: \(roomName ?? "")"
        
        getPlayerData(completionBlock: { (error) in
            if error != nil {
                print("hiba")
            } else {
                GameManagement.sharedInstance.getGames()
                self.checkGameParam()
            }
        })
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpTableView.reloadData()
        self.setUpTableView.allowsSelection = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    func reloadTableView() {
        GameManagement.sharedInstance.battlePlayer = []
        self.setUpTableView.reloadData()
        
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
        
        // Add player
        let addPlayer = UIAlertAction(title: "Add Player", style: .default) { _ in
            if let textField = alert.textFields, let text = textField[0].text {
                self.setUpTableView.reloadData()
                let player = Player(id: "", playerName: text, teamId: "", allDrink: 0, usedBonus: 0)
                NetworkSevice.sharedInstance.addPlayerToDatabase(player: player, competionBlock: { (error) in
                    if error != nil {
                        print("Nem sikerült az adatbázisba a feltöltés")
                    } else {
                        self.checkGameParam()
                        self.setUpTableView.reloadData()
                    }
                })
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Add..."
            textField.clearButtonMode = .whileEditing
        }
        
        
        
        alert.title = "Add Player"
        alert.addAction(addPlayer)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }

    
    func getPlayerData(completionBlock: @escaping(_ error : Error?) -> Void) {
        NetworkSevice.sharedInstance.getPlayerList(completionBlock: { (error) in
            if error != nil {
                print("hiba")
            } else {
                self.playerList = NetworkSevice.sharedInstance.playerList
                self.setUpTableView.reloadData()
                completionBlock(nil)
            }
        })

        
    }
    
    
    func playerDataChanged(player : Player, team: Team) {
        NetworkSevice.sharedInstance.addTeamToPlayer(player: player, team: team) { (error) in
            if error != nil {
                print("hiba")
            } else {
                
            }
        }
    }
    
    
    
    
    @IBAction func startGameButtonAction(_ sender: Any) {
        let setUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUpGameViewController") as! SetUpGameViewController
        
        if GameManagement.sharedInstance.selectedMode == 1 {
            let battleGames = GameManagement.sharedInstance.getBattleGames()
            GameManagement.sharedInstance.chosenGames = battleGames
            NetworkSevice.sharedInstance.playerList = GameManagement.sharedInstance.battlePlayer
            if NetworkSevice.sharedInstance.playerList.count < 2 {
                let alert = UIAlertController(title: "Hiba", message: "Válasz ki két játékost aki csatázik egymással", preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okBtn)
                present(alert, animated: true, completion: nil)
                
            } else {
                self.showLoaderView()
                loadAllGameData { [weak self] in
                    self?.dissmissLoaderView()
                }
            }
            
        } else {
           NetworkSevice.sharedInstance.getPlayerList(completionBlock: { (error) in
                if error != nil {
                    print("error")
                } else {
                    print("Player List update")
                }
            })
            self.navigationController?.pushViewController(setUpVc, animated: true)
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
                self.startBattleGame()
            })
        }
        
    }
    
    
    func playersWithoutTeam() -> [Player] {
        return playerList.filter { $0.teamId == "" }
    }
    
    func players(in team: Team) -> [Player] {
        return playerList.filter { $0.teamId == team.id }
    }
    
    func checkGameParam() {
        if playerList.count <=  1 {
            self.setupGameBtn.isEnabled = false
            
        } else {
            self.setupGameBtn.isEnabled = true
            
        }
        
    }
    
    func startBattleGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
    }
    
    @IBAction func showResult(_ sender: Any) {
        let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        scorePopVC.modalPresentationStyle = .overFullScreen
        self.present(scorePopVC, animated: true, completion: nil)
    }
}

extension SetUpPlayersViewController: UITableViewDelegate ,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? playersWithoutTeam().count : players(in: teamList[section - 1]).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("SetUpPlayersTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? SetUpPlayersTableViewCell {
            let player = indexPath.section == 0 ? playersWithoutTeam()[indexPath.row] : players(in: teamList[indexPath.section - 1])[indexPath.row]
            customCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238)
            customCell.playerNameLabel.text = player.playerName
            
            return customCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            NetworkSevice.sharedInstance.deletePlayerToDatabase(player: playerList[indexPath.row], competionBlock: { (error) in
                if (error != nil) {
                    print("Hiba")
                }
            })
            playerList.remove(at: indexPath.row)
            self.setUpTableView.deleteRows(at: [indexPath], with: .fade)
            checkGameParam()
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = setUpTableView.indexPathForSelectedRow {
            let currentCell = setUpTableView.cellForRow(at: indexPath) as? SetUpPlayersTableViewCell
            let existingCell =  GameManagement.sharedInstance.battlePlayer.contains(where: {$0.playerName == playerList[indexPath.row].playerName})
            if !existingCell &&  GameManagement.sharedInstance.battlePlayer.count <= 1 {
                currentCell?.contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8431372549, blue: 0.168627451, alpha: 1)
                let updatedPlayer = playerList[indexPath.row]
                GameManagement.sharedInstance.battlePlayer.append(updatedPlayer)
            } else {
                currentCell?.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238)
                GameManagement.sharedInstance.battlePlayer.removeAll(where: {$0.playerName == playerList[indexPath.row].playerName })
                

            }
            
        }
    }
}
