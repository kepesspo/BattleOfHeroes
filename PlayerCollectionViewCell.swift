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
    private var shadowLayer: CAShapeLayer!
    var color: UIColor = UIColor()
    var player : Player? {
        didSet {
            configure(with: player, color: color)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        playerName.delegate = self as? UITextFieldDelegate
        configure(with: player,color: color)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        
       self.layer.shadowColor = UIColor.lightGray.cgColor
       self.layer.shadowOffset = CGSize(width:0,height: 3.0)
       self.layer.shadowRadius = 2.0
       self.layer.shadowOpacity = 1.0
       self.layer.masksToBounds = false;
       self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    public func configure(with player: Player?, color: UIColor) {
        guard let player = player else { return }
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
        if playerName.text?.isEmpty == true {
            print("Empty Name ")
            postNotification(name: .updatePlayerCollectionView)
            return true
        } else {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        playerName.text = ""
    }
}
