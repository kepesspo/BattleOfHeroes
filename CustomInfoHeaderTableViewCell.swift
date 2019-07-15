//
//  CustomInfoHeaderTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 2/21/18.
//  Copyright © 2018 Sanoma MDC. All rights reserved.
//

import UIKit
import MDCCommon

class CustomInfoHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerInfoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
