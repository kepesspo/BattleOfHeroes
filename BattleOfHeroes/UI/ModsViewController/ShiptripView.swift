//
//  ShiptripView.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/17/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

class ShiptripView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var event1: UIButton!
    @IBOutlet weak var event2: UIButton!
    @IBOutlet weak var event3: UIButton!
    @IBOutlet weak var event4: UIButton!
    @IBOutlet weak var event5: UIButton!
    
    @IBOutlet weak var event1Value: UILabel!
    @IBOutlet weak var event2Value: UILabel!
    @IBOutlet weak var event3Value: UILabel!
    @IBOutlet weak var event4Value: UILabel!
    @IBOutlet weak var event5Value: UILabel!
    
    @IBOutlet weak var event1View: UIView!
    @IBOutlet weak var event2View: UIView!
    @IBOutlet weak var event3View: UIView!
    @IBOutlet weak var event4View: UIView!
    @IBOutlet weak var event5View: UIView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var plusDrinkLabel: UILabel!
    
    @IBOutlet weak var captainLabel: UILabel!
    
    let playersList = NetworkSevice.sharedInstance.playerList
    var evenetTap: UITapGestureRecognizer!
    
    var events = [1,2,3,4,5]
    var selectedEvents : [Int] = []
    
    var event1Count = 0
    var event2Count = 0
    var event3Count = 0
    var event4Count = 0
    var event5Count = 0
    var allEvent = 0
    var captains : [String] = []
    
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
        Bundle.main.loadNibNamed("ShiptripView", owner: self, options: nil)
        addSubview(contentView)
        contentView.layer.cornerRadius = 10
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        firstCheck()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        gameInLevelLabel.text = self.gameCounter
    }
    
    func firstCheck() {
        event1View.backgroundColor = event1Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event2View.backgroundColor = event2Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event3View.backgroundColor = event3Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event4View.backgroundColor = event4Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event5View.backgroundColor = event5Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
    }
    
    func setCaptains() {
        if playersList.count <= 2 {
            for _ in 1...(playersList.count / 2) {
                randPlayer()
            }
        } else {
            for _ in 1...(playersList.count / 3) {
                randPlayer()
            }
        }
        
    }
    
    func randPlayer() {
        if let player = playersList.randomElement()?.playerName {
            if captains.contains(player) {
                randPlayer()
            } else {
                captains.append(player)
            }
        }
        
        
    }
    
    func updateUI() {
        setCaptains()
        let arr = captains.map { (player) -> String in
            return String(player)
            }.joined(separator: ", ")
        
        captainLabel.text = "A Tisztek: \(arr)"
        playerLabel.text = playersList.randomElement()?.playerName
        playerType.text = "Group"
        for _ in 1...(playersList.count * 2) {
            if let element = events.randomElement() {
                allEvent += 1
                selectedEvents.append(element)
            }
        }
        
        for event in selectedEvents {
            switch event {
            case 1: event1Count = event1Count + 1
            case 2: event2Count = event2Count + 1
            case 3: event3Count = event3Count + 1
            case 4: event4Count = event4Count + 1
            case 5: event5Count = event5Count + 1
            default:
                print("Event tap")
            }
        }
        
        event1Value.text = "\(event1Count)"
        event2Value.text = "\(event2Count)"
        event3Value.text = "\(event3Count)"
        event4Value.text = "\(event4Count)"
        event5Value.text = "\(event5Count)"
    }
    
    func checkEndGame() {
        if allEvent == 0 {
            self.tap.isEnabled = true
        } else {
            print("Mehet tovább")
        }
        
    }
    
    @IBAction func event1Action(_ sender: Any) {
        allEvent = event1Count != 0 ? allEvent - 1 : allEvent
        event1Count = event1Count != 0 ? event1Count - 1 : event1Count
        event1View.backgroundColor = event1Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event1Value.text = "\(event1Count)"
        plusDrinkLabel.text = ""
        checkEndGame()
    }
    
    @IBAction func event2Action(_ sender: Any) {
        allEvent = event2Count != 0 ? allEvent - 1 : allEvent
        event2Count = event2Count != 0 ? event2Count - 1 : event2Count
        event2View.backgroundColor = event2Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event2Value.text = "\(event2Count)"
        plusDrinkLabel.text = ""
        checkEndGame()
    }
    
    @IBAction func event3Action(_ sender: Any) {
        allEvent = event3Count != 0 ? allEvent - 1 : allEvent
        event3Count = event3Count != 0 ? event3Count - 1 : event3Count
        event3View.backgroundColor = event3Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event3Value.text = "\(event3Count)"
        plusDrinkLabel.text = ""
        checkEndGame()
    }
    @IBAction func event4Action(_ sender: Any) {
        allEvent = event4Count != 0 ? allEvent - 1 : allEvent
        event4Count = event4Count != 0 ? event4Count - 1 : event4Count
        event4View.backgroundColor = event4Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event4Value.text = "\(event4Count)"
        plusDrinkLabel.text = "+ egy pia : \(playersList.randomElement()!.playerName)"
        checkEndGame()
    }
    
    @IBAction func event5Action(_ sender: Any) {
        allEvent = event5Count != 0 ? allEvent - 1 : allEvent
        event5Count = event5Count != 0 ? event5Count - 1 : event5Count
        event5View.backgroundColor = event5Count != 0 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.9070000052, green: 0.1640000045, blue: 0, alpha: 0.6000000238)
        event5Value.text = "\(event5Count)"
        plusDrinkLabel.text = ""
        checkEndGame()
    }
}
