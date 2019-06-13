//
//  PlayerCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/7/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerName: UITextField!
    
    static let identifier = "PlayerCollectionViewCell"
    var player : Player? {
        didSet {
            configure(with: player)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configure(with: player)
    }

    public func configure(with player: Player?) {
        guard let player = player else { return }
        self.layer.cornerRadius = 10
        playerImageView.image = UIImage(named: player.color) ?? UIImage()
        playerName.text = player.playerName
    }
    
    @IBAction func deletePlayer(_ sender: Any) {
        NetworkSevice.sharedInstance.deletePlayerToDatabase(player: self.player!) { (error) in
            if error != nil {
                print("Error delete player")
            } else {
                print("Deleted player success")
                postNotification(name: .updatePlayerCollectionView)
            }
        }
    }
}
