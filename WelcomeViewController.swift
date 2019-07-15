//
//  WelcomeViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/22/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import Lottie

class WelcomeViewController: UIViewController {

    @IBOutlet weak var errorView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.loopAnimation = true
        errorView.play()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
