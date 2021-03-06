//
//  HowDrinksTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/12/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class HowDrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var drinksPlayerLabel: UILabel!
    var select = false
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
    
}
