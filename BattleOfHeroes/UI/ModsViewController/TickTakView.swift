//
//  TickTakView.swift
//  BattleOfHeroes
//
//  Created by Mark on 3/28/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class TickTakView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var loadView: LottieView!
    
    let playersList = NetworkSevice.sharedInstance.playerList
    let randomInterval = 5...30
    var timer : Timer?
    var endTime = 0
    var bombSoundEffect: AVAudioPlayer?
    
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
        Bundle.main.loadNibNamed("TickTakView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        GameManagement.sharedInstance.actuallyPlayerName = playersList[randomIndex].playerName
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea")
        postNotification(name: .updateGameData)
    }
    
    @IBAction func timerAction(_ sender: Any) {
        let randomTime = randomInterval.randomElement()
        endTime = randomTime ?? 0
        timerBtn.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        playLoadAnimation()
        print(randomTime)
    }
    
    func playLoadAnimation() {
        loadView.loopAnimation = true
        loadView.play()
        
    }
    
    @objc func runTimedCode() {
        if endTime == 0 {
            stopTimer()
            self.tap.isEnabled = true
        } else {
            endTime -= 1
            print(endTime)
        }
    }
    
    func stopTimer() {
        loadView.stop()
        loadView.isHidden = true
        playSound()
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func playSound() {
        let systemSoundID: SystemSoundID = 1014
        AudioServicesPlaySystemSound (systemSoundID)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
