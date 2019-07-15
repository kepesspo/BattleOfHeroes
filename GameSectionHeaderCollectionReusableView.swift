//
//  GameSectionHeaderCollectionReusableView.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/11/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class GameSectionHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var typeimageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    var typeTitle: String = "" {
        didSet {
           typeLabel.text = typeTitle
        }
    }
    
}
