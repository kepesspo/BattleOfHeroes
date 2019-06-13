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

    var dashedLayer : CAShapeLayer!
    
    static let identifier = "AddPlayerCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        dashedLayer = CAShapeLayer()
        dashedLayer.strokeColor = UIColor.black.cgColor
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
        
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        let randomFigure = GameManagement.sharedInstance.figures.randomElement()
        NetworkSevice.sharedInstance.addPlayerToDatabase(player: Player(id: "Player", playerName: "Player", teamId: "", allDrink: 0, usedBonus: 0, color: randomFigure ?? "")) { (error) in
            if error != nil {
                print("Error to add player")
            } else {
                print("Success add player")
            }
        }
    }
    
}
