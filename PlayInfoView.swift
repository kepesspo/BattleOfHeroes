//
//  PlayInfoView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/31/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class PlayInfoView: UIView {
    @IBOutlet var containerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PlayInfoView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let press = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.addGestureRecognizer(press)
        
    }
    
    @objc func dismissView() {
        postNotification(name: .activateGame)
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.playInfo)
        self.removeFromSuperview()
        
    }
    
}
