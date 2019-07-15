//
//  WhoAmIManagerView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/7/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

class WhoAmIManagerView: UIView {
    
    @IBOutlet weak var footballPlayerSwitch: UISwitch!
    @IBOutlet weak var actorSwitch: UISwitch!
    @IBOutlet weak var youtubeAndInstaSwitch: UISwitch!
    @IBOutlet weak var singerSwitch: UISwitch!
    @IBOutlet weak var entrepreneurSwitch: UISwitch!
    @IBOutlet weak var otherPersonSwitch: UISwitch!

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
        Bundle.main.loadNibNamed("WhoAmIManagerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}
