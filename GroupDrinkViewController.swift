//
//  GroupDrinkViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class GroupDrinkViewController: UIViewController {
    @IBOutlet weak var drinkView: LottieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playGroupDrinkAnimation()
    }
    
    func playGroupDrinkAnimation() {
        drinkView.loopAnimation = true
        drinkView.play()
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        postNotification(name: .reloadGroupDrinkTimer)
        self.dismiss(animated: true, completion: nil)
    }
}
