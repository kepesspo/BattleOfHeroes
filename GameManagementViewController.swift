//
//  GameManagementViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/22/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class GameManagementViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let management = game?.gameManagement as? MusicRecognizerManagerView else { return }
        
        let yearDictionary = [
            management.switch1980: 1980...1989,
            management.switch1990: 1990...1999,
            management.switch2000: 2000...2009,
            management.switch2010: 2010...2019,
            management.switchAll: 1980...2019
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let gamemanagementView = game?.gameManagement {
            gamemanagementView.frame = self.containerView.bounds
            containerView.addSubview(gamemanagementView)
        }
    }
    
    
    
 
    @IBAction func infoAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetaisViewController") as! GameDetaisViewController
        vc.titleData = game?.name
        vc.descriptionData = game?.description
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeManagement(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
