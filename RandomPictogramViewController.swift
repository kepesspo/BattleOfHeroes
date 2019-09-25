//
//  RandomPictogramViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import MDCCommon

class RandomPictogramViewController: UIViewController {
    @IBOutlet weak var pictogramImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    var randomImage = [#imageLiteral(resourceName: "gesture_5"),#imageLiteral(resourceName: "gesture_1"),#imageLiteral(resourceName: "gesture_2"),#imageLiteral(resourceName: "gesture_4.png"),#imageLiteral(resourceName: "gesture_3.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictogramImageView.image = randomImage.randomElement()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    @IBAction func doneTapped(_ sender: Any) {
            postNotification(name: .showExtraGame)
            self.dismiss(animated: true, completion: nil)
    }
}
