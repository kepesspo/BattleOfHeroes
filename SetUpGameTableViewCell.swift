//
//  SetUpGameTableViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/13/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class SetUpGameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameSwicth: UISwitch!
    var switchTappedHandler: ((_ isOn: Bool, _ game: GameModes?) -> Void)?
    
    var game: GameModes? {
        didSet {
            loadData()
        }
    }
    var randomColorVC: Bool = false {
        didSet {
            if randomColorVC {
               gameName.text = GameManagement.sharedInstance.randomColorVC
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
    }
    
    func loadData() {
        guard game != nil, gameName != nil, gameSwicth != nil else {
            return
        }
        
        gameName.text = game?.gameTitle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchTapped(_ sender: Any) {
        switchTappedHandler?(gameSwicth.isOn, game)
    }
}
