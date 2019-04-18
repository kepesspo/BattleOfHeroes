//
//  ScoreTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/8/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerDrinksLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
