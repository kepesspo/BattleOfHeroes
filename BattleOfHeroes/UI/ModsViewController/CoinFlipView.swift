//
//  CoinFlipView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class CoinFlipView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var gameInfoContainerView: UIView!
    
    var back: UIImageView!
    var front: UIImageView!
    var timer: Timer?
    var firstSpin: Bool = true
    
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
        Bundle.main.loadNibNamed("CoinFlipView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        
        gameInLevelLabel.text = self.gameCounter
    }
    
    func updateUI() {
        gameInfoContainerView.layer.cornerRadius = 10
        playerType.text = "Battle"
        personLabel.text = playersList.randomElement()?.playerName
        textLabel.text = "Hivj ki valakit és válasszatok: Fej vagy irás"
        front = UIImageView(image: UIImage(named: "001-coin-1"))
        back = UIImageView(image: UIImage(named: "002-coin"))
        back.frame = containerView.bounds
        front.frame = containerView.bounds
        containerView.addSubview(back)
    }
    
    @IBAction func flipTapped(_ sender: Any) {
        let starting = [back!, front!].randomElement() ?? front!
        flipCoin(times: Int.random(in: 3...8), from: starting)
        self.tap.isEnabled = true
        flipButton.isEnabled = false
    }
    
    func flipCoin(times: Int, from: UIImageView) {
        guard times > 0 else { return }
        let to = from == back ? front! : back!
        UIView.transition(from: from, to: to, duration: 0.3, options: [.transitionFlipFromRight], completion: { _ in
            self.flipCoin(times: times - 1, from: to)
        })
    }
    
}
