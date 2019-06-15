//
//  DrinkCounterViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/8/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import TTSegmentedControl

class DrinkCounterViewController: UIViewController {
    
    @IBOutlet weak var howDrinksTableView: UITableView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var groupScoreLabel: UILabel!
    @IBOutlet weak var groupValueLabel: UILabel!
    
    
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var personalGameView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var successCheckBox: CheckboxButton!
    @IBOutlet weak var extraCheckBox: CheckboxButton!
    @IBOutlet weak var personalSaveButton: UIButton!
    @IBOutlet weak var playerFigureImageView: UIImageView!
    
    let playersList = NetworkSevice.sharedInstance.playerList
    
    var game: Game?
    var player: Player?
    var extraDrink : Int = 0
    var actullyDrinkCount = 0
    var drinkValue : [Int] = []
    
    var selectedPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .showBonus, selector: #selector(showBonusView(notification:)), object: nil)
        
        if let gameData = game {
            print("--------- Drink Counter View passed game: \(gameData.name) -------------")
            print("--------- Drink Counter View passed game: \(gameData.addedScore) -------------")
            print("--------- Drink Counter View passed game: \(gameData.gameType) -------------")

            switch gameData.gameType!.rawValue {
            case "personal": return personalGame()
            case "winGroup": return winGroup()
            case "LoseGroup": return loseGroup()
            default:
                return personalGame()
            }
        }
        
        
        // Curve View
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
        
        let drinkV = extraDrink * GameManagement.sharedInstance.gameDrinkMultiplier
        for elem in 1...drinkV {
            let step = elem * 40
            let image = UIImage(named: "shot-glass")
            let imageView = UIImageView(image: image!)
            if elem == 1 {
                imageView.frame = CGRect(x: 40, y: 420, width: 50, height: 50)
                view.addSubview(imageView)
            } else if elem > 7 {
                imageView.frame = CGRect(x: 40, y: 490, width: 50, height: 50)
                view.addSubview(imageView)
            } else  {
                imageView.frame = CGRect(x: step, y: 420, width: 50, height: 50)
                view.addSubview(imageView)
            }
            
        }
    }
    
    func winGroup() {
        groupView.isHidden = false
        personalGameView.isHidden = true
        groupValueLabel.text = "Nyertes"
        groupScoreLabel.text = "+\(game!.addedScore) Pont"
    }
    
    func loseGroup() {
        groupView.isHidden = false
        personalGameView.isHidden = true
        groupValueLabel.text = "Vesztes"
        groupScoreLabel.text = "+\(game!.addedScore) Pont"
    }
    
    @IBAction func savePersonalGame(_ sender: Any) {
        if successCheckBox.on && extraCheckBox.on {
            let allScore = game!.addedScore + extraDrink
            NetworkSevice.sharedInstance.updatePlayerDrinks(player: player!, drinks: allScore) { (error, bonus, player) in
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
            NetworkSevice.sharedInstance.updatePlayerDrinks(player: player!, drinks: extraDrink) { (error, bonus, player)  in
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
            NetworkSevice.sharedInstance.updatePlayerDrinks(player: player!, drinks: game!.addedScore) { (error, bonus, player) in
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
        if bonus == true {
            postNotification(name: .showBonus, object: playerData)
        } else {
            print("No bonus")
        }
        
    }
    
    @IBAction func saveDrinksData(_ sender: Any) {
        if let player = selectedPlayer {
            if game?.gameType!.rawValue == "winGroup" {
                NetworkSevice.sharedInstance.updatePlayerDrinks(player: player, drinks: game!.addedScore) { (error, bonus, player)  in
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
                NetworkSevice.sharedInstance.updatePlayerDrinks(player: player, drinks: game!.addedScore) { (error, bonus, player)  in
                    if error == nil {
                        print("Success save score")
                        self.dismiss(animated: false, completion: {
                            self.checkBonus(bonus: bonus, playerData: player)
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
        if let topController = UIApplication.topViewController() {
            topController.present(vc, animated: true, completion: {
                vc.playerForBonus.append(player!)
                vc.name = player?.playerName
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
            customCell.player = playersList[indexPath.row]
            return customCell
        }
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = howDrinksTableView.indexPathForSelectedRow {
            let currentCell = howDrinksTableView.cellForRow(at: indexPath) as? HowDrinksTableViewCell
            currentCell?.contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8431372549, blue: 0.168627451, alpha: 1)
            let updatedPlayer = playersList[indexPath.row]
            selectedPlayer = updatedPlayer
        }
        
        
    }   
}

