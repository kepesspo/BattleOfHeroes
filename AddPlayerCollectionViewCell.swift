//
//  AddPlayerCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/11/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class AddPlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerCountLabel: UILabel!
    
    var dashedLayer : CAShapeLayer!
    
    static let identifier = "AddPlayerCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        dashedLayer = CAShapeLayer()
        dashedLayer.strokeColor = UIColor.white.cgColor
        dashedLayer.lineDashPattern = [11, 11]
        dashedLayer.lineWidth = 1
        dashedLayer.cornerRadius = 10
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dashedLayer.removeFromSuperlayer()
        dashedLayer.frame = containerView.bounds
        dashedLayer.fillColor = nil
        dashedLayer.path = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.addSublayer(dashedLayer)
        playerCountLabel.text = "\(GameManagement.sharedInstance.playerCount)\n Játékos"
        
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        let randomFigure = GameManagement.sharedInstance.figures.randomElement()
        let randomNumber = twoDigitNumber
        NetworkSevice.sharedInstance.addPlayerToDatabase(player: Player(id: "", playerName: "Player\(randomNumber)", teamId: "", allDrink: 0, usedBonus: 0, color: randomFigure ?? "")) { (error) in
            if error != nil {
                print("Error to add player")
            } else {
                print("Success add player")
                GameManagement.sharedInstance.playerCount = GameManagement.sharedInstance.playerCount + 1
                postNotification(name: .updateStartButton)
            }
        }
    }
    
    var twoDigitNumber: String {
        let randomRoomId = Int.random(in: 10...99)
        return "\(randomRoomId)"
    }
    
}
