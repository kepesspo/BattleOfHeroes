//
//  TrueOrFalseView.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/27/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class TrueOrFalseView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var trueOrFalseLabel: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var gameInLevelLabel: UILabel!
    
    var trueOrFalseText : String?
    
    var gameTimer: Timer?
    var seconds = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("TrueOrFalseView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        showRandomText()
        
    }
    
    func showRandomText() {
        trueOrFalseLabel.text = "A nyestek csak éjjel vadásznak?"
    }
    
    @IBAction func startBtnAction(_ sender: Any) {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        startBtn.isHidden = true
    }
    
    @objc func runTimedCode() {
        if seconds == 0 {
            timer.text = "False"
            stopTimer()
            let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
            contentView.addGestureRecognizer(gestureRecognizer)
            
        } else {
            seconds -= 1
            timer.text = "\(seconds)"
        }
    }
    
    func stopTimer() {
        if gameTimer != nil {
            gameTimer?.invalidate()
            gameTimer = nil
        }
    }
    
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    
    
}
