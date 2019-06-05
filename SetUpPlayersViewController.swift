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
    @IBOutlet weak var setUpTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playerNavigationItem: UINavigationItem!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var plusButtonImageView: UIImageView!
    @IBOutlet weak var personAnimationView: LOTAnimationView!
    @IBOutlet weak var gameStartLabel: UILabel!
    
    var refPlayer = fireBaseRefData.playerRef
    var playerList = [Player]()
    var teamList = [Team]()
    var gameMode = GameManagement.sharedInstance.selectedMode
    lazy var panelManager = Panels(target: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView.isHidden = true
        
        
        if playerList.count == 0 {
            setUpTableView.isHidden = true
            personAnimationView.loopAnimation = true
            personAnimationView.play()
        } else {
            personAnimationView.isHidden = true
            setUpTableView.isHidden = false
        }
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        panelManager.collapsePanel()
        self.checkGameRunning()
        self.setUpTableView.reloadData()
        self.setUpTableView.allowsSelection = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func checkGameRunning() {
        NetworkSevice.sharedInstance.getGameRunning(completionBlock: { (error, run) in
            if run == 1 {
                self.addPlayerButton.isHidden = true
                self.setUpTableView.isUserInteractionEnabled = false
                self.plusButtonImageView.isHidden = true
                postNotification(name: .updateGameIsSpectate)
            } else {
                self.addPlayerButton.isHidden = false
                self.setUpTableView.isUserInteractionEnabled = true
                self.plusButtonImageView.isHidden = false
                postNotification(name: .updateGameIsAll)
            }
        })
    }
    
    func showPanel() {
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelMenu")
        var panelConfiguration = PanelConfiguration(size: .custom(450))
        panelConfiguration.animateEntry = true
        panelConfiguration.panelVisibleArea = 100
        self.panelManager.show(panel: panel, config: panelConfiguration)
    }
    
    @objc func gameModeChanged() {
        print("Mode Changed")
       
        panelManager.collapsePanel()
        switch GameManagement.sharedInstance.selectedMode {
        case 0:
            print("Egyszerű játékmod")
            GameManagement.sharedInstance.selectedMode = 0
            self.setUpTableView.reloadData()
            self.setUpTableView.allowsSelection = false
        case 1:
            print("Összetett játékmod")
            GameManagement.sharedInstance.selectedMode = 1
            self.setUpTableView.reloadData()
            self.setUpTableView.allowsSelection = false
        case 2:
            print("Csata játékmod")
            GameManagement.sharedInstance.selectedMode = 2
            self.reloadTableView()
            self.setUpTableView.allowsSelection = true
        default:
            print("Default")
        }
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
                        self.updateView()
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
                self.updateView()
                self.setUpTableView.reloadData()
                completionBlock(nil)
            }
        })
    }
    
    func updateView() {
        if playerList.count == 0 {
            setUpTableView.isHidden = true
            gameStartLabel.isHidden = false
            personAnimationView.isHidden = false
            personAnimationView.loopAnimation = true
            personAnimationView.play()
        } else {
            personAnimationView.isHidden = true
            setUpTableView.isHidden = false
            gameStartLabel.isHidden = true
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
                } else {
                    postNotification(name: .updateStartButton)
                }
            })
            playerList.remove(at: indexPath.row)
            self.setUpTableView.deleteRows(at: [indexPath], with: .fade)
            updateView()
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
