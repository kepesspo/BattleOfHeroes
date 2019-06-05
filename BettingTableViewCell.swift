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
    
    var player: HorseBet? {
        didSet {
            loadData()
        }
    }
    
    var cellColor: UIColor? {
        didSet {
            setCellColor(color: cellColor ?? UIColor.white)
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
        betHorseColorLabel.text = player?.horseColor.text
        colorView.backgroundColor = player?.horseColor.uiColor
    }
    
    func setCellColor(color: UIColor) {
        self.colorView.backgroundColor = cellColor
    }
    
}
