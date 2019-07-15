//
//  MusicRecognizerManagerView.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/28/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class MusicRecognizerManagerView: UIView {
    @IBOutlet weak var switch1980: UISwitch!
    @IBOutlet weak var switch1990: UISwitch!
    @IBOutlet weak var switch2000: UISwitch!
    @IBOutlet weak var switch2010: UISwitch!
    @IBOutlet weak var switchAll: UISwitch!
    
    @IBOutlet var contentView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("MusicRecognizerManagerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
