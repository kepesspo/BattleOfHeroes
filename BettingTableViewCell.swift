//
//  BettingTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/18/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class BettingTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var drinkCountLabel: UILabel!
    @IBOutlet weak var betHorseColorLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var player: Bet? {
        didSet {
            loadData()
        }
    }
    
    var cellColor: UIColor? {
        didSet {
            setCellColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData() {
        nameLabel.text = player?.playerName
        if let playerDrink = player?.drinkValue {
            drinkCountLabel.text = "\(playerDrink)"
        }
        betHorseColorLabel.text = player?.horseColorName
        colorView.backgroundColor = player?.horseColor
    }
    
    func setCellColor() {
        self.colorView.backgroundColor = cellColor
    }
    
}
