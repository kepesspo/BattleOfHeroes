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
    
    var randomImage = [#imageLiteral(resourceName: "001-like.png"),#imageLiteral(resourceName: "002-clap.png"),#imageLiteral(resourceName: "003-hand.png"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictogramImageView.image = randomImage.randomElement()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
            postNotification(name: .randomPictogram)
            self.dismiss(animated: true, completion: nil)
    }
}
