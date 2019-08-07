//
//  DrinkCounterViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/8/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import TTSegmentedControl
import MDCCommon

class DrinkCounterViewController: UIViewController {
    
    @IBOutlet weak var howDrinksTableView: UITableView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var groupScoreLabel: UILabel!
    @IBOutlet weak var groupValueLabel: UILabel!
    
    
    @IBOutlet weak var containerVirew: UIView!
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var personalGameView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var successCheckBox: CheckboxButton!
    @IBOutlet weak var extraCheckBox: CheckboxButton!
    @IBOutlet weak var personalSaveButton: UIButton!
    @IBOutlet weak var playerFigureImageView: UIImageView!
    @IBOutlet weak var drinksStackView: UIStackView!
    
    let playersList = Factory.shared.playerList
    
    var game: Game?
    var player: Player?
    var extraDrink : Int = 0
    var actullyDrinkCount = 0
    var drinkValue : [Int] = []
    
    var selectedPlayers: [Player] = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .showBonus, selector: #selector(showBonusView(notification:)), object: nil)
        subscribeForNotification(name: .gameWinner, selector: #selector(showWinner(notification:)), object: nil)
        
        if let gameData = game {
            print("--------- Drink Counter View passed game: \(gameData.name) -------------")
            print("--------- Drink Counter View passed game: \(gameData.addedScore) -------------")
            print("--------- Drink Counter View passed game: \(gameData.gameType) -------------")
            
            howDrinksTableView.allowsMultipleSelection = false
            
            switch gameData.gameType!.rawValue {
            case "personal": return personalGame()
            case "winGroup": return winGroup()
            case "LoseGroup": return loseGroup()
            default:
                return personalGame()
            }
        }
        
        // Curve View
        containerVirew.layer.cornerRadius = 10
        containerVirew.layer.masksToBounds = true
        
        groupView.layer.cornerRadius = 10
        groupView.layer.masksToBounds = true
        
        personalGameView.layer.cornerRadius = 10
        personalGameView.layer.masksToBounds = true
        
        howDrinksTableView.separatorStyle = .none
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        containerVirew.layer.cornerRadius = 10
        containerVirew.layer.masksToBounds = true
        
        groupView.layer.cornerRadius = 10
        groupView.layer.masksToBounds = true
        
        personalGameView.layer.cornerRadius = 10
        personalGameView.layer.masksToBounds = true
        
        howDrinksTableView.separatorStyle = .none
        
    }

    func personalGame() {
        groupView.isHidden = true
        personalGameView.isHidden = false
        playerFigureImageView.image = UIImage(named: player!.color)
        extraDrink = Int.random(in: 1...3)
        scoreLabel.text = "+\(game!.addedScore) Pont"
        extraLabel.text = "+\(extraDrink) Pont"
        playerLabel.text = player?.playerName ?? ""
        
        let drinkV = extraDrink * Factory.shared.gameDrinkMultiplier
        
        for elem in 1...drinkV {
            //let step = elem * 40
            let image = UIImage(named: "shot-glass")
            let imageView = UIImageView(image: image!)
//            imageView.addConstraint(NSLayoutConstraint(item: self, attribute: .height,
//                                                       relatedBy: .equal, toItem: nil,
//                                                       attribute: .notAnAttribute,
//                                                       multiplier: 1, constant: 40))
            
            drinksStackView.addArrangedSubview(imageView)
            imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width,
                                                       relatedBy: .equal, toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1, constant: 30))

        }
        
    }
    
    func winGroup() {
        groupView.isHidden = false
        personalGameView.isHidden = true
        groupValueLabel.text = "Válaszd ki hogy kik nyertek. Nekik nem kell innuk"
        groupScoreLabel.text = "+\(game!.addedScore) Pont"
    }
    
    func loseGroup() {
        groupView.isHidden = false
        personalGameView.isHidden = true
        groupValueLabel.text = "Válaszd ki hogy kik vesztettek. Nekik kell innuk."
        groupScoreLabel.text = "+\(game!.addedScore) Pont"
    }
    
    @IBAction func savePersonalGame(_ sender: Any) {
        if successCheckBox.on && extraCheckBox.on {
            let allScore = game!.addedScore + extraDrink
            Factory.shared.dataManager.updatePlayerDrinks(player: player!, drinks: allScore, gameType: (game?.gameType!.rawValue)!) { (error, bonus, player) in
                if error == nil {
                    print("Success save score")
                    self.dismiss(animated: false, completion: {
                        self.checkBonus(bonus: bonus, playerData: player)
                    })
                } else {
                     print("No success save score")
                }
            }
            return
        } else if extraCheckBox.on {
            Factory.shared.dataManager.updatePlayerDrinks(player: player!, drinks: extraDrink, gameType: (game?.gameType!.rawValue)!) { (error, bonus, player)  in
                if error == nil {
                    print("Success save score")
                    self.dismiss(animated: false, completion: {
                         self.checkBonus(bonus: bonus, playerData: player)
                    })
                   
                } else {
                    print("No success save score")
                }
            }
            return
        } else if successCheckBox.on {
            Factory.shared.dataManager.updatePlayerDrinks(player: player!, drinks: game!.addedScore, gameType: (game?.gameType!.rawValue)!) { (error, bonus, player) in
                if error == nil {
                    print("Success save score")
                    self.dismiss(animated: false, completion: {
                        self.checkBonus(bonus: bonus, playerData: player)
                    })
                    
                } else {
                    print("No success save score")
                }
            }
            return
        } else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
    }
    
    
    func checkBonus(bonus: Bool?, playerData: Player?) {
        guard let playerScore = player?.allDrink else { return }
        if playerScore >= GameManagement.sharedInstance.scoreRate {
            print("<-------------- Játék Vége ------------->")
            postNotification(name: .gameWinner, object: playerData)
        } else if bonus == true {
            postNotification(name: .showBonus, object: playerData)
        } else {
            print("No bonus")
        }
        
    }
    
    @IBAction func saveDrinksData(_ sender: Any) {
        guard selectedPlayers.count != 0 else {
            return self.dismiss(animated: false, completion: nil)
        }
        
        for player in selectedPlayers {
            if game?.gameType!.rawValue == "winGroup" {
                Factory.shared.dataManager.updatePlayerDrinks(player: player,
                                                                drinks: game!.addedScore,
                                                                gameType: (game?.gameType!.rawValue)! ) { (error, bonus, player)  in
                    if error == nil {
                        print("Success save score")
                        self.dismiss(animated: false, completion: {
                            self.checkBonus(bonus: bonus, playerData: player)
                        })
                        
                    } else {
                        print("No success save score")
                    }
                }
            } else {
                Factory.shared.dataManager.updatePlayerDrinks(player: player,
                                                              drinks: game!.addedScore,
                                                              gameType: (game?.gameType!.rawValue)!) { (error, bonus, player)  in
                    if error == nil {
                        print("Success save score")
                        self.dismiss(animated: false, completion: {
                            //self.checkBonus(bonus: bonus, playerData: player)
                        })
                        
                    } else {
                        print("No success save score")
                    }
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    @objc func showBonusView(notification : Notification) {
        let player = notification.object as? Player
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BonusViewController") as! BonusViewController
        vc.playerForBonus.append(player!)
        if let topController = UIApplication.topViewController() {
            topController.present(vc, animated: true, completion: {
            })
        }   
    }
    
    @objc func showWinner(notification : Notification) {
        let player = notification.object as? Player
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BattleResultViewController") as! BattleResultViewController
        vc.player = player
        if let topController = UIApplication.topViewController() {
            topController.present(vc, animated: true, completion: {
            })
        }
    }
    

}

extension DrinkCounterViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if let customCell = Bundle.main.loadNibNamed("HowDrinksTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? HowDrinksTableViewCell {
            customCell.selectionStyle = .none
            customCell.player = playersList[indexPath.row]
            return customCell
        }
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = howDrinksTableView.indexPathForSelectedRow {
            let currentCell = howDrinksTableView.cellForRow(at: indexPath) as? HowDrinksTableViewCell
            
            let updatedPlayer = playersList[indexPath.row]
            
            if currentCell!.select {
                currentCell?.contentView.backgroundColor = UIColor(hexString: "#FFD393")
                selectedPlayers.removeAll(where: {$0.playerName == updatedPlayer.playerName})
                currentCell?.select = false
            } else {
                currentCell?.contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8431372549, blue: 0.168627451, alpha: 1)
                selectedPlayers.append(updatedPlayer)
                currentCell?.select = true
            }
        }
    }   
}

