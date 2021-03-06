//
//  HorseRaceBetViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import TTSegmentedControl

class HorseRaceBetViewController: UIViewController {
    
    @IBOutlet weak var bettingTableView: UITableView!
    @IBOutlet weak var saveBet: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bettingSegmentedController: TTSegmentedControl!
    
    let playersList = NetworkSevice.sharedInstance.playerList
    var actullyDrinkCount = 0
    var drinkValue : [Int] = [1,2,3]
    var color = "Válasz Szint"
    let lightYellowColor = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
    var betPlayerData: [HorseBet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bettingSegmentedController.itemTitles = []
        bettingSegmentedController.layer.cornerRadius = 5
        bettingSegmentedController.allowChangeThumbWidth = false
        bettingTableView.separatorStyle = .none
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        for valueOfDrink in drinkValue {
            bettingSegmentedController.itemTitles.append("\(valueOfDrink)")
        }
        bettingSegmentedController.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                self.actullyDrinkCount = self.drinkValue[0]
                print("")
            case 1:
                self.actullyDrinkCount = self.drinkValue[1]
                print("")
            case 2:
                self.actullyDrinkCount = self.drinkValue[2]
                print("")
            case 3:
                self.actullyDrinkCount = self.drinkValue[3]
                print("")
            default:
                print("Default")
            }
            print("Selected item \(index)")
        }
        
        if GameManagement.sharedInstance.horseRaceBettingPlayer.count == 0 {
            for player in playersList {
                GameManagement.sharedInstance.horseRaceBettingPlayer.append(HorseBet(playerName: player.playerName,
                                                                                     drinkValue: 0,
                                                                                     horseColor: .none))
            }
        } else {
            print("Show Good Betting Stat")
        }
        betPlayerData = GameManagement.sharedInstance.horseRaceBettingPlayer
        
    }
    @IBAction func saveAction(_ sender: Any) {
        //GameManagement.sharedInstance.horseRaceBettingPlayer = []
        self.dismiss(animated: true, completion: nil)
    }
}
extension HorseRaceBetViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("BettingTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? BettingTableViewCell {
            customCell.player = GameManagement.sharedInstance.horseRaceBettingPlayer[indexPath.row]
            
            return customCell
        }
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = bettingTableView.indexPathForSelectedRow {
            let currentCell = bettingTableView.cellForRow(at: indexPath) as? BettingTableViewCell
            let color = GameManagement.sharedInstance.horseRaceBettingPlayer[indexPath.row].horseColor.next()
            currentCell?.cellColor = color.uiColor
            currentCell?.betHorseColorLabel.text = color.text

            var betPlayer = GameManagement.sharedInstance.horseRaceBettingPlayer[indexPath.row]
            betPlayer.horseColor = color
            betPlayer.drinkValue = actullyDrinkCount
        }
    }
}


