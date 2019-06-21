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
    @IBOutlet weak var bottleImageView: UIImageView!
    @IBOutlet weak var spinButton: UIButton!
    
    var randomTimer : Timer?
    let playersList = NetworkSevice.sharedInstance.playerList

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("TheBottleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
    }

    
    func updateUI() {
        if let player = GameManagement.sharedInstance.getNextGamePlayer() {
            print("Player: \(player.playerName)")
            GameManagement.sharedInstance.actuallyPlayer = player
            GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
            GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
            postNotification(name: .updateGameData)
        }
    }
    @IBAction func spinnTapped(_ sender: Any) {
        self.tap.isEnabled = true
        spinButton.isEnabled = false
        
        let rotateView = CABasicAnimation()
        let randonAngle = arc4random_uniform(361) + 360
        rotateView.fromValue = 0
        rotateView.toValue = Float(randonAngle) * .pi / 180.0
        rotateView.duration = 2
        rotateView.repeatCount = 0
        rotateView.isRemovedOnCompletion = false
        rotateView.fillMode = CAMediaTimingFillMode.forwards
        rotateView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        bottleImageView.layer.add(rotateView, forKey: "transform.rotation.z")
        
        
    }

}

