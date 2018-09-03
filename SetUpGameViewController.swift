//
//  SetUpGameViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class SetUpGameViewController: UIViewController {
    
    @IBOutlet var setUpGameTableView: UITableView!
    
    var games = GameManagement.sharedInstance.getAllGameNames()
    var chosenGames = Set<GameModes>()
    
    var dataTitle: String = ""
    var dataDescription: String = ""
    
    var switches : [UISwitch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        backButton.tintColor = .red
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = .red
        
        let gameImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        gameImageView.image = #imageLiteral(resourceName: "GameTab2")
        self.navigationItem.titleView = gameImageView
        
        self.navigationItem.leftBarButtonItem?.tintColor = .red
        for game in games {
            chosenGames.update(with: game)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func doneTapped() {
        GameManagement.sharedInstance.gameModes = []
        for game in chosenGames {
            GameManagement.sharedInstance.gameModes.append(game.rawValue)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passGameData" {
            if let vc = segue.destination as? GameDetaisViewController {
                vc.descriptionData = dataDescription
                vc.titleData = dataTitle
            }
        }
    }
}

extension SetUpGameViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? games.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "JÁTÉKOK"
        case 1:
            return "EXTRA JÁTÉKOK(OK)"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("SetUpGameTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? SetUpGameTableViewCell {
            let game = games[indexPath.row]
            customCell.game = indexPath.section == 0 ? game : nil
            if indexPath.section == 1 {
                customCell.randomColorVC = true
            }
            
            if  indexPath.row % 2 == 0 {
                let lightBlueColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:0.5)
                customCell.contentView.backgroundColor = lightBlueColor
            } else {
                let lightYellowColor = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
                customCell.contentView.backgroundColor = lightYellowColor
                customCell.gameName.textColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:1.0)
            }
            
            
            customCell.switchTappedHandler = { [weak self] isOn, gameMode in
                guard let weakSelf = self else { return }
                
                guard !customCell.randomColorVC  else {
                    GameManagement.sharedInstance.randomColorSwitchIsON = isOn
                    return
                }
                
                if isOn {
                    weakSelf.chosenGames.update(with: gameMode!)
                } else {
                    weakSelf.chosenGames.remove(gameMode!)
                }
            }
            return customCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath) as? SetUpGameTableViewCell
        if let game = currentCell?.game {
            dataTitle = game.gameTitle()
            dataDescription = game.gameDiscription()
            performSegue(withIdentifier: "passGameData", sender: self)
        } 
    }
}
