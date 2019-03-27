//
//  SetUpPlayersTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class SetUpPlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
