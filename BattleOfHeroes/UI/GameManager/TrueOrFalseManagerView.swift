//
//  TrueOrFalseManagerView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/11/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class TrueOrFalseManagerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var animalSwitch: UISwitch!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("TrueOrFalseManagerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
