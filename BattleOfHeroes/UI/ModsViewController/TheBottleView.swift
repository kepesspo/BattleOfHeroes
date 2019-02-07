//
//  TheBottleView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class TheBottleView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var bottleImageView: UIImageView!
    @IBOutlet weak var spinButton: UIButton!
    
    var randomTimer : Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("TheBottleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.levelCounter
    }
    
    func updateUI() {
        
    }
    @IBAction func spinnTapped(_ sender: Any) {
        self.tap.isEnabled = true
        
        
        let rotateView = CABasicAnimation()
        let randonAngle = arc4random_uniform(361) + 360
        rotateView.fromValue = 0
        rotateView.toValue = Float(randonAngle) * Float(M_PI) / 180.0
        rotateView.duration = 2
        rotateView.repeatCount = 0
        rotateView.isRemovedOnCompletion = false
        rotateView.fillMode = CAMediaTimingFillMode.forwards
        rotateView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        bottleImageView.layer.add(rotateView, forKey: "transform.rotation.z")
        
        
    }

}

