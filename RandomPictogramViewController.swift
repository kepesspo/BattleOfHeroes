//
//  RandomPictogramViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class RandomPictogramViewController: UIViewController {

    @IBOutlet weak var pictogramImageView: UIImageView!
    var randomImage = [#imageLiteral(resourceName: "001-like.png"),#imageLiteral(resourceName: "002-clap.png"),#imageLiteral(resourceName: "003-hand.png"),]
    override func viewDidLoad() {
        super.viewDidLoad()
        pictogramImageView.image = randomImage.randomElement()
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

    @IBAction func doneTapped(_ sender: Any) {
            postNotification(name: .randomPictogram)
            self.dismiss(animated: true, completion: nil)
    }
}
