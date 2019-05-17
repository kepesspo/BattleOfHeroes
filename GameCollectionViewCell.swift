//
//  GameCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

protocol CustomCellInfoDelegate: class {
    func sharePressed(game: Game)
}


class GameCollectionViewCell: UICollectionViewCell {
    var delegate: CustomCellInfoDelegate?
    
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    
    var gameData : Game? {
        didSet {
            configure(with: gameData!)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with game: Game) {
        self.layer.cornerRadius = 10
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showDescription))
        longPressGesture.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPressGesture)
        gameNameLabel.text = game.name
        gameImageView.contentMode = .scaleAspectFit
        
        gameImageView.image = game.gameImage
        
        
        if game.isSelected == true {
            blurView.isHidden = true
        } else {
            blurView.isHidden = false
        }
    }
    
    @objc func showDescription() {
        delegate?.sharePressed(game: gameData!)
    }
}
