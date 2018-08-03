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

class WheelOfFortuneView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var spinningWheel: TTFortuneWheel!
    
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
        Bundle.main.loadNibNamed("WheelOfFortuneView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        showFortuneWheel()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        contentView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    func showFortuneWheel() {
        var slices : [FortuneWheelSlice] = []
        for player in playersList{
            slices.append(FortuneWheelSlice(title: "\(player.playerName)"))
            
            
        }
//        for slicee in slices {
//            
//        }
        spinningWheel.slices = slices
        spinningWheel.equalSlices = true
        
        
        spinningWheel.frameStroke.width = 1
        spinningWheel.frameStroke.color = .white
    }
    
    @IBAction func rotateButton(_ sender: Any) {
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        spinningWheel.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.spinningWheel.startAnimating(fininshIndex: randomIndex) { (finished) in
                print(finished)
                let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.handleTap))
                self.contentView.addGestureRecognizer(gestureRecognizer)
            }
        }
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
}

