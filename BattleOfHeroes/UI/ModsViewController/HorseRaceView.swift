//
//  HorseRaceView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class HorseRaceView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var yellowLabel: UILabel!
    
    @IBOutlet weak var redHorse: UIImageView!
    @IBOutlet weak var yellowHorse: UIImageView!
    @IBOutlet weak var blueHorse: UIImageView!
    @IBOutlet weak var greenHorse: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    
    let horses = ["Red","Yellow","Green","Blue"]
    
    var redCounter = 0
    var yellowCounter = 0
    var greenCounter = 0
    var blueCounter = 0
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
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
        Bundle.main.loadNibNamed("HorseRaceView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    @IBAction func betAction(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HorseRaceBetViewController") as! HorseRaceBetViewController
        popOverVC.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.topViewController() {
            topController.present(popOverVC, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func moveButtonAction(_ sender: Any) {
        runTimer()
        moveButton.isHidden = true
        
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(moveHorse)), userInfo: nil, repeats: true)
    }
    
    @objc func moveHorse() {
        switch horses.randomElement() {
        case "Red":
            redCounter += 1
            redLabel.text = "R: \(redCounter)"
            changeHorsePosition(horse: redHorse)
            print("Red horse move")
        case "Yellow":
            yellowCounter += 1
            yellowLabel.text = "Y: \(yellowCounter)"
            changeHorsePosition(horse: yellowHorse)
            print("Yellow horse move")
        case "Green":
            greenCounter += 1
            greenLabel.text = "G: \(greenCounter)"
            changeHorsePosition(horse: greenHorse)
            print("Green horse move")
        case "Blue":
            blueCounter += 1
            blueLabel.text = "B: \(blueCounter)"
            changeHorsePosition(horse: blueHorse)
            print("Blue horse move")
        default:
            print("No horse move")
        }
        
        if redCounter == 10 || blueCounter == 10 || greenCounter == 10 || yellowCounter == 10 {
            print("Finish")
            self.tap.isEnabled = true
            timer.invalidate()
            
            if redCounter == 10 {
                 winnerLabel.text = "A győztes ló a: Piros"
            } else if blueCounter == 10 {
                winnerLabel.text = "A győztes ló a: Kék"
            } else if yellowCounter == 10 {
                winnerLabel.text = "A győztes ló a: Sárga"
            } else {
                winnerLabel.text = "A győztes ló a: Zöld"
            }

            
        }
        print("Red horse: \(redCounter) Green horse: \(greenCounter) Yellow horse: \(yellowCounter) Blue horse: \(blueCounter)")
        
    }
    
    func changeHorsePosition(horse: UIImageView) {
        let stepWidth = (self.contentView.frame.width - 60) / 11
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            horse.center.x += stepWidth
        }, completion: nil)
    }
    
    func updateUI() {
        NetworkSevice.sharedInstance.horseRaceRunning(isRun: true) { (error) in
            if error == nil {
                print("Horse race with database work")
            } else {
                print("error")
            }
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(playersList.count)))
        //GameManagement.sharedInstance.actuallyPlayerName = playersList[randomIndex].playerName
        GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
        GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "004-teamwork-1.png")
        postNotification(name: .updateGameData)
    }
}
