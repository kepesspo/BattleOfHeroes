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
    @IBOutlet weak var descriptionBtn: UIButton!
    @IBOutlet weak var gameTypeColorView: UIView!
    
    var gameData : Game? {
        didSet {
            configure(with: gameData!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    public func configure(with game: Game) {
        self.layer.cornerRadius = 8
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showDescription))
        longPressGesture.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPressGesture)
        gameNameLabel.text = game.name
        gameImageView.contentMode = .scaleAspectFit
        
        gameImageView.image = game.gameImage
        gameTypeColorView.backgroundColor = game.gameTypeColor
        if game.isSelected == true {
            blurView.isHidden = true
        } else {
            blurView.isHidden = false
        }
    }
    
    @objc func showDescription() {
        delegate?.sharePressed(game: gameData!)
    }
    
    @IBAction func descriptionAction(_ sender: Any) {
        delegate?.sharePressed(game: gameData!)
    }
}
