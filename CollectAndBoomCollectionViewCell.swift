//
//  CollectAndBoomCollectionViewCell.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/28/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class CollectAndBoomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var randomElementLabel: UILabel!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var valueImageView: UIImageView!
    
    var cellSelected: Bool? {
        didSet {
            changeSelectedCell()
        }
    }
    
    var randomElement : Int? {
        didSet {
            configure(with: randomElement!)
        }
    }
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func changeSelectedCell() {
        if cellSelected == true {
            hideView.isHidden = true
        } else {
            hideView.isHidden = false
        }
    }
    
    
    func configure(with randomElement: Int) {
        randomElementLabel.text = "\(randomElement)"
        
    }

}
