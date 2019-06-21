//
//  WheelOfFortuneView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/2/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import TTFortuneWheel

class WheelOfFortuneView: GameView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var spinningWheel: TTFortuneWheel!
    @IBOutlet weak var spinnerButton: UIButton!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var spinLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("WheelOfFortuneView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        showFortuneWheel()
        updateUI()
    }
    
    func updateUI() {
        playerNameLabel.isHidden = true
        if let player = GameManagement.sharedInstance.getNextGamePlayer() {
            print("Player: \(player.playerName)")
            GameManagement.sharedInstance.actuallyPlayer = player
            GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
            GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
            postNotification(name: .updateGameData)
        }
        
    }
    
    
    func showFortuneWheel() {
        var slices : [Any] = []
        for player in playersList {
            slices.append(CarnivalWheelSlice.init(title: player.playerName))
        }
        
        spinningWheel.slices = slices as? [FortuneWheelSliceProtocol]
        spinningWheel.equalSlices = true
        spinningWheel.frameStroke.width = 0
        spinningWheel.slices.enumerated().forEach { (pair) in
            let slice = pair.element as! CarnivalWheelSlice
            let offset = pair.offset
            switch offset % 4 {
            case 0: slice.style = .brickRed
            case 1: slice.style = .sandYellow
            case 2: slice.style = .babyBlue
            case 3: slice.style = .deepBlue
            default: slice.style = .babyBlue
            }
        }
    }
    
    @IBAction func rotateButton(_ sender: Any) {
        spinLabel.text = "pörög..."
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        spinningWheel.startAnimating()
        self.spinnerButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.spinningWheel.startAnimating(fininshIndex: randomIndex) { (finished) in
                print(self.playersList[randomIndex].playerName)
                self.spinnerButton.isHidden = true
                self.spinLabel.isHidden = true
                self.tap.isEnabled = true
                self.playerNameLabel.isHidden = false
                self.playerNameLabel.text = self.playersList[randomIndex].playerName
            }
        }
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
}

