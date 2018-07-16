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
            if let descriptionVC = navVC.viewControllers[0] as? SetUpPlayersViewController {
                if segue.identifier == SegueIdentifiers.team {
                    descriptionVC.gameType = 1
                } else {
                    descriptionVC.gameType = 2
                }
            }
        }
    }
}
