//
//  GameTypeViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/6/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class GameTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController {
            if segue.identifier == SegueIdentifiers.team {
                if let descriptionVC = navVC.viewControllers[0] as? SetUpPlayersViewController {
                    descriptionVC.gameType = 1
                } else {
                    let descriptionVC = segue.destination as! SetUpPlayersViewController
                    descriptionVC.gameType = 2
                }
            }
            
        }
    }
    
}
