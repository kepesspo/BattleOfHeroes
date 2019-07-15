//
//  AddPlayerCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/11/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon

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
        containerView.addTapGestureRecognizer(action: addPlayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashedLayer.removeFromSuperlayer()
        dashedLayer.frame = containerView.bounds
        dashedLayer.fillColor = nil
        dashedLayer.path = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.addSublayer(dashedLayer)
        playerCountLabel.text = "\(Factory.shared.playerList.count)\n Játékos"
    }
    
    @IBAction func addPlayer() {
        if Factory.shared.figuresIndex >= Factory.shared.figures.count {
            Factory.shared.figuresIndex = 0
        }
        let randomFigure = Factory.shared.figures[Factory.shared.figuresIndex]
        Factory.shared.figuresIndex = Factory.shared.figuresIndex + 1
        let randomNumber = twoDigitNumber
        Factory.shared.dataManager.createPlayer(player: Player(id: "", playerName: "Player\(randomNumber)", teamId: "", allDrink: 0, usedBonus: 0, color: randomFigure ?? "")) { (error) in
            if error != nil {
                print("Error to add player")
            } else {
                print("Success add player")
                postNotification(name: .updatePlayerList)
            }
        }
    }
    
    var twoDigitNumber: String {
        let randomRoomId = Int.random(in: 10...99)
        return "\(randomRoomId)"
    }
    
}
