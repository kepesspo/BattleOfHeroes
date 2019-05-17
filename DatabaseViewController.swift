//
//  DatabaseViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 12/6/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class DatabaseViewController: UIViewController {

    @IBOutlet weak var gearView: LottieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animated()
    }
    
    func animated() {
        gearView.loopAnimation = true
        gearView.play()
    }
}
