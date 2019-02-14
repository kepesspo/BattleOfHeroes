//
//  GameManagementViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/22/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import TTSegmentedControl

class GameManagementViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var gameManagmentSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var swiperView: UIView!
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var addGameView: UIView!
    
    var game: Game?
    var pickerData: [String] = [String]()
    
    enum occupation : String {
        case singer = "singer"
        case other = "other"
        case actor = "actor"
        case sportPlayer = "sportPlayer"
        case ENTREPRENEUR = "ENTREPRENEUR"
        case star = "star"
        
        func getAllOccupat() -> [String] {
            switch self{
            case .singer: return ["Pop Singer","Rapper","DJ"]
            case .other : return ["Reality Star","Dancer","US Presidents"]
            case .actor: return ["Actor","ACTRESS","TV Actress"]
            case .sportPlayer : return ["Soccer Players"]
            case .ENTREPRENEUR : return ["ENTREPRENEUR"]
            case .star : return ["YouTube Star","Instagram Star"]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: -1)
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowRadius = 4
//      cardView.layer.masksToBounds = true
        
        swiperView.layer.cornerRadius = 3
        swiperView.layer.masksToBounds = true
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
        
        setUpGameManagementSegmentedControl()
        
        informationTextView.text = game?.description
        gameLabel.text = game?.name
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let personManagement = game?.gameManagement as? WhoAmIManagerView {
            let personDictionary = [
                personManagement.footballPlayerSwitch: "sportPlayer",
                personManagement.entrepreneurSwitch: "ENTREPRENEUR",
                personManagement.youtubeAndInstaSwitch : "star",
                personManagement.singerSwitch: "singer",
                personManagement.otherPersonSwitch: "other",
                personManagement.actorSwitch: "Actor"
            ]
            
            GameManagement.sharedInstance.allowedPersonOccupation = []
            
            for item in personDictionary {
                guard item.key?.isOn == true else { continue }
                switch item.value{
                case "singer": GameManagement.sharedInstance.allowedPersonOccupation +=  occupation.singer.getAllOccupat()
                case "other" : GameManagement.sharedInstance.allowedPersonOccupation +=  occupation.other.getAllOccupat()
                case "Actor": GameManagement.sharedInstance.allowedPersonOccupation +=  occupation.actor.getAllOccupat()
                case "sportPlayer" : GameManagement.sharedInstance.allowedPersonOccupation += occupation.sportPlayer.getAllOccupat()
                case "ENTREPRENEUR" : GameManagement.sharedInstance.allowedPersonOccupation += occupation.ENTREPRENEUR.getAllOccupat()
                case "star" : GameManagement.sharedInstance.allowedPersonOccupation += occupation.star.getAllOccupat()
                default:
                    print("0 selected Occupation")
                }
            }
            if GameManagement.sharedInstance.allowedPersonOccupation.count == 0 {
                GameManagement.sharedInstance.allowedPersonOccupation = ["YouTube Star",
                                                                         "Instagram Star",
                                                                         "ENTREPRENEUR",
                                                                         "Soccer Players",
                                                                         "Actor",
                                                                         "ACTRESS",
                                                                         "TV Actress",
                                                                         "Reality Star",
                                                                         "Dancer",
                                                                         "US Presidents",
                                                                         "Pop Singer",
                                                                         "Rapper",
                                                                         "DJ"]
            }
            print(GameManagement.sharedInstance.allowedPersonOccupation)
        }
        
       
        if let musicManagement = game?.gameManagement as? MusicRecognizerManagerView {
            let yearDictionary = [
                musicManagement.switch1980: 1980...1989,
                musicManagement.switch1990: 1990...1999,
                musicManagement.switch2000: 2000...2009,
                musicManagement.switch2010: 2010...2019,
                musicManagement.switchAll: 1980...2019
            ]
            GameManagement.sharedInstance.allowedYears = []
            for item in yearDictionary {
                guard item.key?.isOn == true else { continue }
                for i in item.value {
                    GameManagement.sharedInstance.allowedYears.append(i)
                }
            }
            print(GameManagement.sharedInstance.allowedYears)
        }
    }
    
    func setUpGameManagementSegmentedControl() {
        gameManagmentSegmentedControl.itemTitles = ["Információ","Egyedi Játék","Adat hozzáadás"]
        gameManagmentSegmentedControl.selectItemAt(index: 0)
        gameManagmentSegmentedControl.layer.cornerRadius = 5
        gameManagmentSegmentedControl.allowChangeThumbWidth = false
        gameManagmentSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                self.containerView.isHidden = true
                self.addGameView.isHidden = true
                self.informationView.isHidden = false
                print("Információ")
            case 1:
                print("Custom Játék")
                self.informationView.isHidden = true
                self.containerView.isHidden = false
                self.addGameView.isHidden = true
            case 2:
                print("Játék hozzáadás")
                self.informationView.isHidden = true
                self.containerView.isHidden = true
                self.addGameView.isHidden = false
                
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
        }
        
    }
    
    
    
    @objc func swipeDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let gamemanagementView = game?.gameManagement {
            gamemanagementView.frame = self.containerView.bounds
            containerView.addSubview(gamemanagementView)
        }
    }
    
    @IBAction func closeManagement(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
