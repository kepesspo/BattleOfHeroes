//
//  HowDrinksTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/12/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class HowDrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var drinksPlayerLabel: UILabel!
    @IBOutlet weak var drinksStepper: UIStepper!
    @IBOutlet weak var drinkCountLabel: UILabel!
    
    
    var player: Player? {
        didSet {
            loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData() {
        
        drinksPlayerLabel.text = player?.playerName
    }
    
    @IBAction func stepperChangeValue(_ sender: UIStepper) {
        var number = 0
        
        number = Int(sender.value)
        if number < 0 {
            drinksStepper.minimumValue = -3
            drinkCountLabel.text = "Élet : \(number)"
            NetworkSevice.sharedInstance.updatePlayerDrinks(player: player!, drinks: number) { (error) in
                if error != nil {
                    print("error")
                } else {
                    postNotification(name: .reloadScoreTableView)
                }
            }
        } else if number == 0 {
            drinkCountLabel.text = "\(number)"
        }
        else {
            drinkCountLabel.text = "Ivászat: \(number)"
            NetworkSevice.sharedInstance.updatePlayerDrinks(player: player!, drinks: number) { (error) in
                if error != nil {
                    print("error")
                } else {
                    postNotification(name: .reloadScoreTableView)
                }
            }
            
        }
        
    }
    
}
