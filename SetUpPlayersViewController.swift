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


class SetUpPlayersViewController: UIViewController {
    @IBOutlet weak var setUpTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playerNavigationItem: UINavigationItem!
    @IBOutlet weak var headerView: UIView!
    
    var refPlayer = fireBaseRefData.playerRef
    var playerList = [Player]()
    var teamList = [Team]()

    var roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName)
    var roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
    
    var gameMode = GameManagement.sharedInstance.selectedMode
    lazy var panelManager = Panels(target: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .gameModeChanged, selector: #selector(gameModeChanged), object: nil)
        showPanel()
        
        setUpTableView.separatorStyle = .none
        getPlayerData(completionBlock: { (error) in
            if error != nil {
                print("hiba")
            } else {
                GameManagement.sharedInstance.getGames()
                self.checkGameParam()
            }
        })
    }
    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelMenu")
        var panelConfiguration = PanelConfiguration(size: .custom(450))
        panelConfiguration.animateEntry = true
        panelConfiguration.panelVisibleArea = 140
        self.panelManager.show(panel: panel, config: panelConfiguration)
    }
    
    @objc func gameModeChanged() {
        print("Mode Changed")
       
        panelManager.collapsePanel()
        switch GameManagement.sharedInstance.selectedMode {
        case 0:
            print("Egyszerű")
            self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            self.headerView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            GameManagement.sharedInstance.selectedMode = 0
            self.setUpTableView.reloadData()
            self.setUpTableView.allowsSelection = false
        case 1:
            print("Egyszerű")
            self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            self.headerView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            GameManagement.sharedInstance.selectedMode = 2
            self.setUpTableView.reloadData()
            self.setUpTableView.allowsSelection = false
        case 2:
            print("Csata")
            self.headerView.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
            self.view.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
            GameManagement.sharedInstance.selectedMode = 1
            self.reloadTableView()
            self.setUpTableView.allowsSelection = true
        default:
            print("Default")
        }
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
            if let textField = alert.textFields,
                let text = textField[0].text?.capitalizingFirstLetter() {
                self.setUpTableView.reloadData()
                let player = Player(id: "", playerName: text, teamId: "", allDrink: 0, usedBonus: 0)
                NetworkSevice.sharedInstance.addPlayerToDatabase(player: player, competionBlock: { (error) in
                    if error != nil {
                        print(error?.localizedDescription)
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
    
    func playersWithoutTeam() -> [Player] {
        return playerList.filter { $0.teamId == "" }
    }
    
    func players(in team: Team) -> [Player] {
        return playerList.filter { $0.teamId == team.id }
    }
    
    func checkGameParam() {
        if playerList.count <=  1 {
            //self.setupGameBtn.isEnabled = false
            
        } else {
            //self.setupGameBtn.isEnabled = true
            
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
    
    func startNormalGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
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
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("SetUpPlayersTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? SetUpPlayersTableViewCell {
            let player = indexPath.section == 0 ? playersWithoutTeam()[indexPath.row] : players(in: teamList[indexPath.section - 1])[indexPath.row]
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
                currentCell?.cellView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8431372549, blue: 0.168627451, alpha: 1)
                let updatedPlayer = playerList[indexPath.row]
                GameManagement.sharedInstance.battlePlayer.append(updatedPlayer)
            } else {
                currentCell?.cellView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                GameManagement.sharedInstance.battlePlayer.removeAll(where: {$0.playerName == playerList[indexPath.row].playerName })
                

            }
            
        }
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
