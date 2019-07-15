//
//  GameInfoViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/17/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class GameInfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let press = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.view.addGestureRecognizer(press)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        infoLabel.text = "Long tap to show game details screen. You can customize the game and you get some information about the game"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissView() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.firstRunClosed)
        self.dismiss(animated: true, completion: nil)
        
    }

}
