//
//  SetUpPlayersViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/6/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class SetUpPlayersViewController: UIViewController {

    var gameType : Int = 0
    var players : [String] = ["kjsad","wjeshdf","audisfbh","nwqjehbr"]
    var endEditing = false
    @IBOutlet weak var setUpTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gameType)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        let alert = UIAlertController(title: "Add player",
                                      message: "Add player",
                                      preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            if let textField = alert.textFields, let text = textField[0].text {
                self.players.append(text)
                self.setUpTableView.reloadData()
                
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "player name..."
            textField.clearButtonMode = .whileEditing
        }
        
        alert.addAction(cancel)
        alert.addAction(add)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func editList(_ sender: Any) {
        if self.setUpTableView.isEditing == true {
            self.setUpTableView.isEditing = false
            
        } else {
            self.setUpTableView.isEditing = true
        }
        
        
        
    }
}

extension SetUpPlayersViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setUpTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if gameType == 1 {
            return 1
        }
        return 1 //teams.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if gameType == 1 {
            return "Players"
        }
        return "team names" //teams.name
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            players.remove(at: indexPath.row)
            self.setUpTableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = players[sourceIndexPath.row]
        players.remove(at: sourceIndexPath.row)
        players.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(players)")
        self.setUpTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
