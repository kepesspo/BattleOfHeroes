//
//  GameCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import Cosmos

protocol CustomCellInfoDelegate: class {
    func sharePressed(game: Game)
}


class GameCollectionViewCell: UICollectionViewCell {
    weak var delegate: CustomCellInfoDelegate?
    
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var descriptionBtn: UIButton!
    @IBOutlet weak var gameTypeColorView: UIView!
    @IBOutlet weak var connectionImageView: UIImageView!
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var gameData : Game? {
        didSet {
            configure(with: gameData!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        connectionImageView.tintColor = .white
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 8.0
        
        shadowView.layer.cornerRadius = 8.0
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width:0,height: 3.0)
        shadowView.layer.shadowRadius = 2.0
        shadowView.layer.shadowOpacity = 1.0
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
        settingView.backgroundColor = game.gameTypeColor
        
        connectionImageView.isHidden = !game.downloadsData
        editImageView.isHidden = !game.extraOption
        ratingLabel.text = "\(game.funIndex)/5"
        
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
    
    func pulseWifiIcon() {
        UIView.animate(withDuration: 0.55, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.connectionImageView.tintColor = .red
        })
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.connectionImageView.layer.removeAllAnimations()
            self.connectionImageView.tintColor = .white
        }
    }
}
