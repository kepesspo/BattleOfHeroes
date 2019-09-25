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
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playGroupDrinkAnimation()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    func playGroupDrinkAnimation() {
        drinkView.loopAnimation = true
        drinkView.play()
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        drinkView.stop()
        postNotification(name: .showExtraGame)
        self.dismiss(animated: true, completion: nil)
    }
}
