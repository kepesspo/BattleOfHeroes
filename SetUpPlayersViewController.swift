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

class SetUpPlayersViewController: UIViewController {
    
    @IBOutlet weak var startGameBtn: UIButton!
    @IBOutlet weak var setUpTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIButton!
    
    @IBOutlet weak var playerNavigationItem: UINavigationItem!
    
    var gameType : Int = 2
    var refPlayer = fireBaseRefData.playerRef
    var playerList = [Player]()
    var teamList = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("gameType : \(gameType)")
        
        setUpTableView.separatorStyle = .none
        
        

        GameManagement.sharedInstance.defaultGameSetUp()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "JÁTÉKOS HOZZÁADÁSA"
        playerNavigationItem.prompt = " "
        let rubikFont = UIFont(name: "Rubik-Regular", size: 25)
        let attributText = [NSAttributedStringKey.font : rubikFont]
        self.navigationController?.navigationBar.titleTextAttributes = attributText as? [NSAttributedStringKey : UIFont]
    }
    
    
    @IBAction func addPlayer(_ sender: Any) {
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
        
        // Add player
        let addPlayer = UIAlertAction(title: "Add Player", style: .default) { _ in
            if let textField = alert.textFields, let text = textField[0].text {
                self.setUpTableView.reloadData()
                let player = Player(id: "", playerName: text, teamId: "", life: 3, allDrink: 0)
                NetworkSevice.sharedInstance.addPlayerToDatabase(player: player, competionBlock: { (error) in
                    if error != nil {
                        print("Nem sikerült az adatbázisba a feltöltés")
                    } else {
                        self.setUpTableView.reloadData()
                    }
                })
            }
        }
        
        // Add Team
        let addTeam = UIAlertAction(title: "Add Team", style: .default) { _ in
            if let textField = alert.textFields, let text = textField[0].text {
                self.setUpTableView.reloadData()
                let team = Team(id: "", name: text, rating: 0)
                NetworkSevice.sharedInstance.addTeamToDataBase(team: team, competionBlock: { (error) in
                    if error != nil {
                        print("Nem sikerült hozzáadni az adatbázishoz a Csapataot")
                    } else {
                        
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
        
        
        switch gameType {
        case 1:
            alert.title = " Add Team / Player"
            alert.addAction(addTeam)
            alert.addAction(addPlayer)
            alert.addAction(cancel)
            
        case 2:
            alert.title = "Add Player"
            alert.addAction(addPlayer)
            alert.addAction(cancel)
        default:
            print("")
        }
        
        present(alert, animated: true, completion: nil)
    }

    
    func reloadData() {
        NetworkSevice.sharedInstance.getPlayerList(completionBlock: { (error) in
            if error != nil {
                print("hiba")
            } else {
                self.playerList = NetworkSevice.sharedInstance.playerList
                self.setUpTableView.reloadData()
            }
        })
        
        
        NetworkSevice.sharedInstance.getTeamList { (error) in
            if error != nil {
                print("hiba")
            } else {
                self.teamList = NetworkSevice.sharedInstance.teamList
                self.setUpTableView.reloadData()
            }
        }
        
        
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
            print("Nem Mehez")
        }
    }
    
    
    @IBAction func editList(_ sender: Any) {
        if self.setUpTableView.isEditing == true {
            self.setUpTableView.isEditing = false
            
        } else {
            self.setUpTableView.isEditing = true
        }
    }
    
    func playersWithoutTeam() -> [Player] {
        return playerList.filter { $0.teamId == "" }
    }
    
    func players(in team: Team) -> [Player] {
        return playerList.filter { $0.teamId == team.id }
    }
}

extension SetUpPlayersViewController: UITableViewDelegate ,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameType == 1 ? teamList.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? playersWithoutTeam().count : players(in: teamList[section - 1]).count
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if gameType == 1 {
//            if section == 0 {
//                 return "Players"
//            } else {
//                return teamList[section - 1].name
//            }
//        }
//        return "Players"
//    }
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            NetworkSevice.sharedInstance.deletePlayerToDatabase(player: playerList[indexPath.row], competionBlock: { (error) in
                if (error != nil) {
                    print("Hiba")
                }
            })
            
            playerList.remove(at: indexPath.row)
            self.setUpTableView.deleteRows(at: [indexPath], with: .fade)
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
