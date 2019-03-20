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

class SetUpPlayersViewController: UIViewController {
    

    @IBOutlet weak var setUpTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var setupGameBtn: UIButton!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var playerNavigationItem: UINavigationItem!
    @IBOutlet weak var roomIdentiferLabel: UILabel!
    @IBOutlet weak var roomPassLabel: UILabel!
    
    
    var refPlayer = fireBaseRefData.playerRef
    var playerList = [Player]()
    var teamList = [Team]()

    var roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName)
    var roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView.separatorStyle = .none
        self.setupGameBtn.isEnabled = false
        dataView.layer.cornerRadius = 5
        setUpTableView.layer.cornerRadius = 5
        
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    
    
    @IBAction func addPlayer(_ sender: Any) {
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
        
        // Add player
        let addPlayer = UIAlertAction(title: "Add Player", style: .default) { _ in
            if let textField = alert.textFields, let text = textField[0].text {
                self.setUpTableView.reloadData()
                let player = Player(id: "", playerName: text, teamId: "", life: 3, allDrink: 0, usedBonus: 0)
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
        if playerList.count < 2 {
            print("Nem Mehet")
        }
        
        if GameManagement.sharedInstance.chosenGames.count == 0 {
            GameManagement.sharedInstance.chosenGames = GameManagement.sharedInstance.games
            NetworkSevice.sharedInstance.getFamousPersons { (error) in
                if error == nil {
                    print("Success FamousPersone Parse")
                }
            }
            NetworkSevice.sharedInstance.getTrueOrFalse { (error) in
                if error == nil {
                    print("Success True Or false Parse")
                }
            }
            NetworkSevice.sharedInstance.getSongs { (error) in
                if error == nil {
                    print("Success Song Parse")
                }
            }
            NetworkSevice.sharedInstance.getHaveIEverNever { (error) in
                if error == nil {
                    print("Success HaveIEverNever Parse")
                }
            }
            NetworkSevice.sharedInstance.getAnagrammaWord { (error) in
                if error == nil {
                    print("Success Annagramma Parse")
                }
            }
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
            if  indexPath.row % 2 == 0 {
                let lightBlueColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:0.5)
                customCell.contentView.backgroundColor = lightBlueColor
                //customCell.backgroundColor = lightBlueColor
            } else {
                let lightYellowColor = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
                customCell.contentView.backgroundColor = lightYellowColor
                customCell.playerNameLabel.textColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:1.0)
            }
            
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
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var playerIndex = 0
        print(playerList)
        guard sourceIndexPath != destinationIndexPath else { return }
        guard sourceIndexPath.section != destinationIndexPath.section else {
            tableView.reloadData()
            return
            
        }
        
        guard destinationIndexPath.section != 0 else {
            tableView.reloadData()
            return
        }
        
        
        if sourceIndexPath.section == 0 {
            let movedObj = playersWithoutTeam()[sourceIndexPath.row]
            if let player = playerList.index(where: { $0.id == movedObj.id}) {
                let playerIndexInPlayerList = player
                print("playerIndex in playerList : \(playerIndexInPlayerList)")
                playerIndex = playerIndexInPlayerList
            }
        } else {
            let movedObj = players(in: teamList[sourceIndexPath.section - 1])
            if let player = playerList.index(where: {$0.id == movedObj[sourceIndexPath.row].id}) {
                let playerIndexInPlayerList = player
                print("playerIndex in playerList : \(playerIndexInPlayerList)")
                playerIndex = playerIndexInPlayerList
            }
            
            
        }
        
        
        let movedObject = playerList[playerIndex]
        playerList.remove(at: sourceIndexPath.row)
        playerList.insert(movedObject, at: destinationIndexPath.row)
        
        print(movedObject)
        print("Source: \(sourceIndexPath.row)  Destination : \(destinationIndexPath.row) Team : \(teamList[destinationIndexPath.section - 1].name) ")
        playerDataChanged(player: playerList[playerIndex], team: teamList[destinationIndexPath.section - 1])
        
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \("")")
        self.setUpTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
