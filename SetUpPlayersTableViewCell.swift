//
//  SetUpPlayersTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class SetUpPlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
