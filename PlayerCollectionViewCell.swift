//
//  PlayerCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/7/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
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
        playerName.delegate = self as? UITextFieldDelegate
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
                GameManagement.sharedInstance.playerCount = GameManagement.sharedInstance.playerCount - 1
                postNotification(name: .updateStartButton)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        print("Save player Name")
        NetworkSevice.sharedInstance.updatePlayer(player: self.player!, name: playerName.text ?? "") { (error) in
            if error != nil {
                print("Error update player")
            } else {
                print("update player success")
                postNotification(name: .updatePlayerCollectionView)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if playerName.text?.isEmpty == true {
            print("Empty Name ")
            postNotification(name: .updatePlayerCollectionView)
        } else {
            NetworkSevice.sharedInstance.updatePlayer(player: self.player!, name: playerName.text ?? "") { (error) in
                if error != nil {
                    print("Error update player")
                } else {
                    print("update player success")
                    postNotification(name: .updatePlayerCollectionView)
                    
                }
            }
        }
        
    }
}
